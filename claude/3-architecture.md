# 아키텍처 설계 원칙

이 파일의 결정들은 프로젝트 전체에 영향을 미친다. 임의로 바꾸지 말고, 변경이 필요하면 이유를 명시하고 논의한다.

---

## 세션 / 인증

**DB 기반 HttpSession**을 사용한다. JWT를 도입하지 말 것.

**이유:** 어드민이 계정을 비활성화하거나 역할을 바꾸는 즉시 효과가 적용돼야 한다.

### 세션 구조

```
HttpSession key: "loginUser" → UserVo (passwordHash 제거 후 저장)

UserVo: id | employeeId | name | email | department | position | phone | role
```

로그인 성공 시 `session.setAttribute("loginUser", user)`로 저장한다.
매 요청마다 Interceptor가 세션을 읽어 로그인 여부·역할을 확인한다.

### 인증 Interceptor

```
AuthInterceptor    → /portal/** 보호, 미인증 시 /login?redirect=... 이동
AdminInterceptor   → /admin/** 보호, 미인증 또는 비어드민 시 즉시 403
```

새 Controller에서 세션이 필요하면 위 Interceptor를 적용한다.
직접 세션을 읽거나 JWT를 도입하지 않는다.

### 세션 조회 헬퍼 (common/util/SessionUtil.java)

```java
SessionUtil.getLoginUser(session)   // UserVo 반환, 없으면 null
SessionUtil.requireLogin(session)   // null이면 UnauthorizedException
SessionUtil.requireAdmin(session)   // ADMIN 아니면 ForbiddenException
```

---

## 라우팅 구조

```
/                     공개 홈
/about                회사 소개
/services             서비스 소개
/careers              채용 정보
/news                 공지사항 (외부)
/contact              문의 폼
/login                로그인 (GET: 폼, POST: 처리)
/logout               로그아웃

/portal               직원 포털 홈         → AuthInterceptor
/portal/approval      결재함               → AuthInterceptor
/portal/approval/new  기안 작성            → AuthInterceptor
/portal/approval/{id} 결재 상세            → AuthInterceptor + 본인/결재자/어드민
/portal/notice        사내 공지            → AuthInterceptor
/portal/directory     조직도               → AuthInterceptor
/portal/profile       내 정보              → AuthInterceptor + 본인만

/admin                어드민 홈            → AdminInterceptor
/admin/users          계정 관리            → AdminInterceptor
/admin/content        콘텐츠 관리          → AdminInterceptor
/admin/approvals      결재 전체 관리       → AdminInterceptor
/admin/logs           감사 로그            → AdminInterceptor
```

### Interceptor 등록 (WebMvcConfig.java)

```java
registry.addInterceptor(authInterceptor).addPathPatterns("/portal/**");
registry.addInterceptor(adminInterceptor).addPathPatterns("/admin/**");
```

---

## 결재 상태 머신

```
DRAFT → (기안 제출) → IN_REVIEW
IN_REVIEW → (승인) → APPROVED
IN_REVIEW → (반려) → REJECTED
REJECTED → (재기안) → DRAFT
```

### 구현 규칙

- 모든 상태 전환은 `@Transactional`로 감싼다 — Approval 상태 변경 + ApprovalLog 생성이 원자적이어야 한다.
- 결재선의 중간 결재자가 비활성화된 경우를 반드시 처리한다.
- 결재 이력(ApprovalLog)은 삭제하지 않는다. 감사 목적으로 영구 보존.

---

## 어드민 감사 로그

어드민이 수행하는 아래 작업은 반드시 AuditLog를 DB에 저장한다:

- 계정 생성 / 수정 / 비활성화 / 역할 변경
- 콘텐츠 게시 / 수정 / 비공개 전환
- 결재 강제 처리
- 어드민 계정 추가

AuditLog는 어드민도 삭제할 수 없다. Mapper XML에 DELETE 쿼리를 만들지 않는다.

---

## 개인정보 접근 제어

- 직원 본인 정보: `AuthInterceptor` 통과 + `loginUser.getId().equals(targetId)` 확인
- 타 직원 정보 (조직도): 공개 허용 필드만 노출 (이름·부서·직급), 연락처는 제외
- 전체 직원 상세: `AdminInterceptor` 통과 후만 접근 가능
- VO 응답에 `passwordHash` 등 민감 필드가 포함되지 않도록 Service에서 null 처리

---

## 콘텐츠 관리

- `content` 테이블의 `isPublished = 1` 인 것만 공개 페이지에 노출
- 상태 전환 시 AuditLog 생성
- 공개 페이지 Controller는 `isPublished` 조건을 Mapper XML WHERE절에 반드시 포함