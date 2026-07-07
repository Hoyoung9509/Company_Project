# 방어적 코딩 게이트

`1-engineering.md`(영향 분석), `2-multi_engineering.md`(빌드 검증), `3-architecture.md`(인증·라우팅), `4-prisma-rules.md`(MyBatis 규칙)가 *구조적* 정확성을 다룬다면, 이 파일은 *기능적* 견고성을 다룬다.

---

## 1. 코딩 전 — 실패모드 스캔

구현 전에 "이 기능이 어떻게 깨질 수 있는가"를 훑고, 이번 세션에 처리할 것과 하지 않을 것을 선언한다.

| 범주 | 이 프로젝트에서 살필 것 |
|---|---|
| **입력** | null / 빈 값 / 형식 오류 / 결재 첨부파일 크기·형식 / 문의 폼 스팸 |
| **네트워크·DB** | MyBatis 조회 결과 null / DuplicateKeyException / DataAccessException / 타임아웃 |
| **상태·UI** | 로딩 / 결과 없음 / 에러 피드백 — 세 가지 상태 모두 JSP에 존재해야 함 |
| **동시성** | 결재 중복 클릭, 동시 승인 경합, 계정 중복 생성 |
| **권한** | 비인증 접근 / 잘못된 역할 / `/admin` 경로에 일반 직원 세션 / 본인 아닌 개인정보 접근 |

---

## 2. "완료" 선언 전 — 기능적 완료 기준

빌드 통과 ≠ 완료. 아래를 추가로 충족해야 "완료"다.

- [ ] 1단계에서 "처리하겠다"고 선언한 예외가 실제 코드에 처리됨
- [ ] 에러를 조용히 삼키지 않음 — 사용자에게 JSP 에러 메시지로 노출 / `catch (e) {}` 금지
- [ ] 로딩·빈 상태에 실제 UI가 있음 (성공 상태만 만들지 않음)
- [ ] DB·MyBatis 오류를 그대로 노출하지 않고 사용자용 메시지로 번역
  - `DuplicateKeyException` → "이미 존재하는 계정입니다"
  - `DataAccessException` → "데이터 처리 중 오류가 발생했습니다"
  - MyBatis 조회 결과 null → "존재하지 않는 항목입니다"
- [ ] 결재 상태 변경 등 여러 행을 바꾸는 작업은 `@Transactional` 안에서 처리
- [ ] 내 변경으로 안 쓰게 된 import·변수·메서드 제거
- [ ] 빌드 통과 (`./gradlew build`)
- [ ] 기능 추가·변경·삭제 시 `local/qc/` 동기화

### 이 프로젝트 전용 추가 체크

- [ ] 권한 체크가 JSP에만 있고 Interceptor·Controller에는 없는 경우 없음
- [ ] 어드민 작업(계정·콘텐츠·결재 강제 처리)에 AuditLog 저장됨
- [ ] 결재 상태 전환이 올바른 흐름(DRAFT→IN_REVIEW→APPROVED/REJECTED→DRAFT) 내에서만 가능
- [ ] VO 응답에 `passwordHash` 등 민감 필드 미포함 (Service에서 null 처리)
- [ ] 세션에 저장된 UserVo에 `passwordHash` 포함되지 않음

---

## 퇴근(EOD) 루틴 상세

1. `./gradlew build` 실행 → 결과 기록
2. `local/eod/<YYMMDD>.md` 생성:
   - 변경 파일 목록
   - 커밋 해시
   - 미완료·보류 항목
3. `git commit` — 세션 변경만, 기본 브랜치면 브랜치 먼저 분리
4. 작업 요약 출력