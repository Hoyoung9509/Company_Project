# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 프로젝트 개요

**회사 홈페이지** — 외부 공개 영역, 내부 직원 포털, 어드민 패널을 하나의 Spring Boot 앱으로 제공한다.

| 사용자 유형 | 접근 경로 | 설명 |
|---|---|---|
| 외부 방문자 | `/` | 비로그인, 공개 페이지만 열람 |
| 내부 직원 | `/portal` | 세션 로그인, 결재·개인정보·공지·조직도 |
| 어드민 | `/admin` | 사이트 전체 관리 (계정·콘텐츠·결재·감사 로그) |

## 기술 스택

| 항목 | 내용 |
|---|---|
| 언어 | Java 17 |
| 빌드 | Gradle 9.0.0 (Kotlin DSL) |
| 프레임워크 | Spring Boot 3.3.0 (Spring MVC + 내장 Tomcat) |
| 뷰 | JSP + tomcat-embed-jasper |
| ORM | MyBatis 3.0.3 |
| DB | MySQL 8.0 로컬 (root/root, DB: company_homepage) |
| 검색 | Elasticsearch (도입 예정) |
| 기타 | Lombok 1.18.32, JSTL 3.0.1 |
| 베이스 패키지 | com.company.homepage |

## Build & Run

```bash
scripts/start.bat          # 서버 시작 (gradlew bootRun)
scripts/stop.bat           # 서버 종료 (포트 8080 kill)

./gradlew build            # 전체 빌드 (컴파일 + 테스트)
./gradlew compileJava      # 컴파일만
./gradlew test             # 테스트만
```

접속: http://localhost:8080

## 핵심 아키텍처 결정 — 변경 금지

- **인증:** JWT 금지 — HttpSession 기반 stateful session 사용
- **권한 검증:** 서버 사이드 Interceptor에서만 수행 — 클라이언트 체크는 UI 피드백 전용
- **어드민 격리:** `/admin` 경로는 AdminInterceptor로 보호, 일반 직원 세션으로 접근 시 즉시 403
- **결재 상태 변경:** 반드시 트랜잭션(@Transactional) 안에서 이력(ApprovalLog)과 함께 처리
- **개인정보 API:** 응답 VO에 불필요한 필드 포함 금지, 본인 또는 어드민만 접근

## 참조 파일

| 파일 | 역할 |
|---|---|
| `claude/1-engineering.md` | 영향 분석, DRY, 주석 규칙 |
| `claude/2-multi_engineering.md` | 빌드 검증 루프, QC 체크리스트 |
| `claude/3-architecture.md` | 인증·라우팅·결재·어드민 설계 |
| `claude/4-mybatis-rules.md` | MyBatis Mapper 작성 규칙 |
| `claude/5-defensive-coding.md` | 방어적 코딩, 실패모드 스캔, EOD 루틴 |
| `claude/6-stack-notes.md` | 기술 스택 버전별 주의사항 |
| `claude/claude-code-prompt-guide.md` | 프롬프트 작성 가이드 |

## 핵심 행동 원칙

**구현 전:**
- 가정을 명시한다. 불확실하면 묻는다. 특히 "누가 이 기능에 접근할 수 있는가"를 먼저 확인한다.
- 더 단순한 방법이 있으면 먼저 말한다. 요청하지 않은 기능·추상화·유연성은 만들지 않는다.

**구현 중:**
- 바뀐 모든 줄은 사용자의 요청으로 직접 추적 가능해야 한다.
- Interceptor·세션 헬퍼를 변경하면 영향받는 모든 경로를 같은 세션에 수정한다.
- 인접 코드·포맷을 임의로 "개선"하지 않는다.

**완료 선언 전:**
- `빌드 통과 ≠ 완료` — `claude/5-defensive-coding.md` 체크리스트를 충족해야 완료.
- 기능 추가·변경·삭제 시 QC 체크리스트를 같은 세션에 동기화.

## 공개 콘텐츠 작성 원칙

- **사실만 쓴다.** 제공받은 내용에 없는 회사 정보·수치·실적을 임의로 만들지 않는다.
- **정보가 없으면 멈춘다.** 빠진 내용을 업계 일반 문구로 채우지 말고 즉시 무엇이 필요한지 묻는다.

## 퇴근(EOD) 자동 루틴

트리거: 사용자 메시지가 `퇴근` 또는 `eod`, 또는 작업 끝에 "끝나면 퇴근 루틴 실행"이 붙은 경우.

1. **빌드 확인** — `./gradlew build` 통과 여부 확인
2. **요약 문서** — `local/eod/<YYMMDD>.md`에 변경 파일·커밋 해시·작업 요약 기록 (`local/`은 .gitignore)
3. **커밋** — 이번 세션 변경만 커밋. 기본 브랜치면 먼저 브랜치를 분리한다.
4. **종료** — 작업 요약 출력 후 종료.