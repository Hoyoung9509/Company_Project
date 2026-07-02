# 아키텍처 설계 원칙

이 파일의 결정들은 프로젝트 전체에 영향을 미친다. 임의로 바꾸지 말고, 변경이 필요하면 이유를 명시하고 논의한다.

---

## 세션 / 인증

회사 홈페이지는 **DB 기반 stateful session**을 사용한다. JWT를 다시 도입하지 말 것.

**이유:** 어드민이 계정을 비활성화하거나 역할을 바꾸는 즉시 효과가 적용돼야 한다. JWT는 만료 전까지 stale 상태가 유지되어 이를 보장할 수 없다.

### 세션 구조

```
Cookie: sessionId (UUID만 저장)
DB Session: id | userId | expiresAt | createdAt
DB User: id | email | employeeId | name | role | department | isActive | ...
```

매 요청마다 `getSession()`이 `Session JOIN User`로 최신 role/isActive를 읽는다.
`isActive = false`이면 `getSession()`이 null을 반환하여 즉시 로그아웃 효과.

### 인증 헬퍼 (Server Action / Route Handler에서 사용)

```ts
requireSession()    // 로그인 여부만 확인, 미인증 시 /login 리다이렉트
requireEmployee()   // role: EMPLOYEE | MANAGER | ADMIN
requireManager()    // role: MANAGER | ADMIN
requireAdmin()      // role: ADMIN 전용, 그 외 즉시 403
```

새 Server Action에서 세션이 필요하면 위 헬퍼를 사용한다. 직접 쿠키를 읽거나 JWT를 도입하지 않는다.

---

## 라우팅 구조

```
/                     공개 홈
/about                회사 소개
/services             서비스 소개
/careers              채용 정보
/news                 공지사항 (외부)
/contact              문의 폼

/portal               직원 포털 홈       requireEmployee()
/portal/approval      결재함             requireEmployee()
/portal/approval/new  기안 작성          requireEmployee()
/portal/approval/[id] 결재 상세          requireEmployee() + 본인/결재자/어드민만
/portal/notice        사내 공지          requireEmployee()
/portal/directory     조직도             requireEmployee()
/portal/profile       내 정보            requireEmployee() + 본인만

/admin                어드민 홈          requireAdmin()
/admin/users          계정 관리          requireAdmin()
/admin/content        콘텐츠 관리        requireAdmin()
/admin/approvals      결재 전체 관리     requireAdmin()
/admin/logs           감사 로그          requireAdmin()

/login                로그인 페이지
/api/...              API Route Handler
```

### 미들웨어 규칙

- `/portal/**` — `requireEmployee()`로 보호. 미인증 시 `/login?redirect=...`으로 이동.
- `/admin/**` — `requireAdmin()`으로 보호. 미인증 또는 비어드민 세션이면 **403** (로그인 페이지로 보내지 않음 — 존재 자체를 노출하지 않는다).
- 권한 체크는 반드시 **서버 사이드**에서 수행한다. 클라이언트의 역할 체크는 UI 피드백 전용이다.

---

## 결재 상태 머신

```
DRAFT → (기안 제출) → IN_REVIEW
IN_REVIEW → (승인) → APPROVED
IN_REVIEW → (반려) → REJECTED
REJECTED → (재기안) → DRAFT
```

### 구현 규칙

- 모든 상태 전환은 `prisma.$transaction()`으로 감싼다 — `Approval` 상태 변경 + `ApprovalLog` 생성이 원자적이어야 한다.
- 결재선의 중간 결재자가 퇴사·비활성화된 경우를 반드시 처리한다 (어드민 대체 지정 또는 자동 스킵 정책 결정 필요).
- 동일 결재 건에 대한 동시 승인 경합(race condition)을 `prisma.$transaction()` + 상태 조건부 update로 방지한다.
- 결재 이력(`ApprovalLog`)은 삭제하지 않는다. 감사 목적으로 영구 보존.

---

## 어드민 감사 로그

어드민이 수행하는 아래 작업은 반드시 `AuditLog`를 생성한다:

- 계정 생성 / 수정 / 비활성화 / 역할 변경
- 콘텐츠 게시 / 수정 / 비공개 전환
- 결재 강제 처리 (승인·반려 override)
- 어드민 계정 추가

`AuditLog` 최소 필드: `adminId | action | targetType | targetId | before | after | createdAt`

감사 로그는 어드민도 삭제할 수 없다. 조회 전용.

---

## 개인정보 접근 제어

- 직원 본인의 정보: `requireEmployee()` + `userId === session.userId` 확인
- 타 직원 정보 (조직도 등): 공개 허용 필드만 노출 (이름·부서·직급), 연락처·개인정보는 제외
- 전체 직원 상세 정보: `requireAdmin()`만 접근 가능
- API 응답에 `password`, `ssn`, 급여 등 민감 필드가 포함되지 않도록 `select` 필드를 명시한다

---

## 콘텐츠 관리

공개 페이지(회사소개·서비스·채용공고·공지사항)의 내용은 DB에 저장하고 어드민이 편집한다.

- `공개(published)` / `비공개(draft)` 상태를 반드시 구분한다
- 상태 전환 시 `AuditLog` 생성
- 공개 페이지는 Server Component로 렌더링하여 SEO를 보장한다
