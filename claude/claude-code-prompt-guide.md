# Claude Code 프롬프트 가이드 — Company_Project

이 프로젝트에서 Claude Code를 효과적으로 쓰기 위한 실전 프롬프트 패턴 모음.
스택: **Spring Boot 3.3.0 / JSP / MyBatis / MySQL**

---

## 기본 원칙

- 요청이 구체적일수록 결과가 정확하다.
- "만들어줘" 보다 "Controller → Service → Mapper XML → JSP 순으로 만들어줘"가 낫다.
- 코드를 수정받기 전에 파일을 읽도록 유도하면 실수가 줄어든다.

---

## 자주 쓰는 프롬프트 패턴

### 새 기능 구현

```
[기능명] 기능을 Controller → Service → Repository → Mapper XML → JSP 순으로 만들어줘.
- 접근 권한: [누가 접근할 수 있는지]
- DB 테이블: [테이블명과 주요 컬럼]
- 화면: [어떤 내용을 표시하는지]
```

예시:
```
공지사항 목록 기능을 Controller → Service → Repository → Mapper XML → JSP 순으로 만들어줘.
- 접근 권한: AuthInterceptor 적용 (로그인한 직원만)
- DB 테이블: notice (id, title, content, createdAt, isActive)
- 화면: 제목·날짜 목록, 클릭 시 상세 페이지 이동
```

---

### 기존 파일 수정

```
[파일경로]를 읽고 [무엇을 왜] 수정해줘.
```

예시:
```
src/main/java/com/company/homepage/service/impl/LoginServiceImpl.java를 읽고
비밀번호 비교 로직을 BCrypt 방식으로 교체해줘.
```

---

### 버그 수정

```
[증상]이 발생하고 있어.
관련 파일: [의심 파일 목록]
에러 메시지: [복사한 에러 전문]
```

---

### JSP 화면 수정

```
src/main/webapp/WEB-INF/views/[경로].jsp를 읽고
[무엇을] 변경해줘. 기존 스타일(style.css)에 맞춰서.
```

---

### Mapper XML 추가

```
[Repository 인터페이스 경로]를 읽고
[메서드명] 쿼리를 Mapper XML에 추가해줘.
조건: [WHERE 조건, 정렬, 페이징 등]
```

---

### 코드 평가 (수정 없이)

```
[파일경로]를 읽고 평가만 해줘. 수정하지 마.
```

---

## Interceptor 관련 작업

```
AuthInterceptor를 적용해서 /portal/[경로]를 로그인 보호해줘.
미인증 접근 시 /login?redirect=/portal/[경로] 로 이동.
```

```
AdminInterceptor에 [경로]를 추가해줘.
비어드민 접근 시 403 반환.
```

---

## 결재 관련 작업

```
결재 상태를 [FROM] → [TO]로 전환하는 로직을 만들어줘.
- @Transactional로 감싸서
- ApprovalLog도 함께 생성
- 잘못된 상태 전환 시 예외 처리 포함
```

---

## 주의: 하지 말아야 할 프롬프트

| 나쁜 예 | 이유 |
|---|---|
| "로그인 만들어줘" | 범위가 불명확 — 어느 레이어까지인지, 어떤 인증 방식인지 모름 |
| "고쳐줘" | 뭘 고치는지 모름 |
| "최적화해줘" | 불필요한 리팩토링 유발 |
| "JWT 써줘" | 이 프로젝트는 HttpSession 기반 (CLAUDE.md 참조) |

---

## 자주 쓰는 단축 명령

| 입력 | 동작 |
|---|---|
| `퇴근` | EOD 루틴 실행 (빌드 확인 → 요약 저장 → 커밋) |
| `빌드 확인` | `./gradlew build` 실행 후 결과 보고 |
| `서버 시작` | `scripts/start.bat` 실행 |
| `서버 종료` | 포트 8080 프로세스 kill |