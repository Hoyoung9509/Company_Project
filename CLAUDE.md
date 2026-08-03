# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 프로젝트 개요

**JuniMusic 홈페이지** — 동요 제작 회사 JuniMusic의 외부 공개 영역, 내부 직원 포털, 어드민 패널을 하나의 Spring Boot 앱으로 제공한다. 자바 패키지명 `com.company.homepage`, DB명 `company_homepage`는 아직 리브랜딩 전 이름 그대로다 (화면에 노출되는 텍스트/디자인부터 우선 반영했고, 코드 식별자 리네이밍은 별도 작업으로 남아 있음). 코드에서 `company`/`homepage`를 보면 곧 JuniMusic이다.

| 사용자 유형 | 접근 경로 | 설명 |
|---|---|---|
| 외부 방문자 | `/` | 비로그인, 공개 페이지만 열람 |
| 내부 직원 | `/portal` | 세션 로그인, 결재·개인정보·공지·조직도 |
| 어드민 | `/admin` | 사이트 전체 관리 (계정·콘텐츠·결재·감사 로그) |

## 저장소 구조 — 두 개의 독립된 툴체인이 공존

이 저장소에는 겉보기와 달리 실제로 실행되는 애플리케이션이 하나뿐이다.

- **Spring Boot (Java/Gradle, `src/main/`)** — 실제로 서빙되는 앱. Spring MVC + 내장 Tomcat + JSP + MyBatis. 위 표의 세 영역을 전부 여기서 렌더링한다.
- **Next.js + Prisma (`app/`, `prisma/`, pnpm)** — **DB 스키마/마이그레이션 관리 전용 툴체인**이다. `app/` 아래는 `create-next-app` 보일러플레이트 그대로이고 실제 서비스로 배포되지 않는다. `prisma/schema.prisma`가 테이블 구조의 소스 오브 트루스이며, 여기서 `pnpm prisma migrate dev`로 생성한 마이그레이션이 같은 MySQL DB(`company_homepage`)에 적용된다. 런타임에는 Prisma Client가 아니라 **MyBatis**가 이 DB를 읽고 쓴다. 즉 스키마는 Prisma로 정의하고, 쿼리는 MyBatis Mapper XML로 짠다 — 두 계층을 혼동하지 않는다.

DB 테이블 구조를 바꿔야 하면 `prisma/schema.prisma`를 먼저 고치고 마이그레이션을 생성한 뒤, 영향받는 VO·Mapper XML·Service를 같은 세션에 맞춰 수정한다. 직접 `ALTER TABLE`을 실행하지 않는다. 기존 마이그레이션 SQL 파일은 수정·삭제 금지(checksum 불일치로 배포 차단).

## Build & Run

```bash
scripts/start.bat              # 서버 시작 (gradlew bootRun), 접속: http://localhost:8080
scripts/stop.bat                # 포트 8080 프로세스 종료

./gradlew build                 # 전체 빌드 (컴파일 + 테스트) — 기본 검증 게이트
./gradlew compileJava           # 컴파일만
./gradlew test                  # 테스트만

pnpm prisma migrate dev --name <설명>   # 스키마 변경 시 마이그레이션 생성
pnpm prisma generate                    # Prisma Client 재생성 (lib/generated/prisma, 커밋 안 함)

docker compose -f docker/docker-compose.yml up -d   # Elasticsearch + Kibana (검색 기능용, 선택)
```

로컬 MySQL: `root/root`, DB `company_homepage`, JDBC `jdbc:mysql://localhost:3306/company_homepage?...` (`src/main/resources/application.yml`).

`.bat` 스크립트에는 한글을 쓰지 않는다 — cmd.exe가 CP949로 읽어서 파싱이 깨진다(`claude/6-stack-notes.md` 참고).

## 핵심 아키텍처 결정 — 변경 금지

- **인증:** JWT 금지 — **DB 기반 HttpSession**. 어드민이 계정을 비활성화/역할 변경하면 즉시 반영돼야 하기 때문.
- **권한 검증:** 서버 사이드 Interceptor(`AuthInterceptor`→`/portal/**`, `AdminInterceptor`→`/admin/**`, `common/config/WebMvcConfig.java`에 등록)에서만 수행. 클라이언트/JSP 체크는 UI 피드백 전용이며 이것만으로 권한을 막으면 안 된다.
- **세션:** `session.setAttribute("loginUser", UserVo)` — `UserVo`에 `passwordHash`가 절대 포함되지 않아야 한다. 조회는 `SessionUtil.getLoginUser/requireLogin/requireAdmin`(`common/util/SessionUtil.java`)을 통해서만 한다.
- **결재 상태 전환** (`DRAFT → IN_REVIEW → APPROVED/REJECTED → (재기안) DRAFT`): 상태 변경은 반드시 `@Transactional` 안에서 `ApprovalLog` 생성과 함께 원자적으로 처리한다.
- **감사 로그(AuditLog)·결재 이력(ApprovalLog)은 삭제 불가.** 계정/콘텐츠/결재 강제처리 등 어드민 작업은 반드시 AuditLog를 남긴다. 해당 Mapper XML에 DELETE 쿼리를 만들지 않는다.
- **개인정보 응답:** VO에 불필요한/민감한 필드(`passwordHash` 등)를 담지 않는다. 타 직원 조회(조직도)는 이름·부서·직급만 노출, 연락처 제외. 전체 상세는 AdminInterceptor 통과 후만.
- **공개 콘텐츠:** `content.isPublished = 1`인 것만 공개 페이지 노출. 이 조건은 Mapper XML WHERE절에 명시한다.

## MyBatis 규칙 (요약 — 상세는 `claude/4-mybatis-rules.md`)

- SQL은 전부 `src/main/resources/mapper/*.xml`에 작성한다. `@Select` 등 어노테이션 방식과 섞지 않는다.
- `namespace`는 대응 Java Mapper 인터페이스의 풀 패키지 경로와 정확히, `id`는 메서드명과 완전히 일치해야 한다.
- 컬럼명과 VO 필드명이 다르면 `resultMap`으로 명시 매핑한다. `map-underscore-to-camel-case: true`는 `snake_case`만 변환하며, 이미 camelCase인 컬럼(`isPublished`, `createdAt`)은 그대로 매핑되므로 별도 처리 필요.
- 파라미터 2개 이상이면 VO 또는 `@Param`으로 묶는다.

## 검색 (Elasticsearch)

`ElasticsearchSyncService` / `ContentSearchRepository` / `document/ContentDocument.java`가 MySQL의 콘텐츠를 ES로 동기화해 `SearchController` / `PortalSearchController`가 검색을 제공한다. 로컬 실행은 `docker/docker-compose.yml`로 띄운다 (`http://localhost:9200`).

## 배포

`Dockerfile`은 `build/libs/*.war`를 `eclipse-temurin:17-jre-alpine` 위에서 실행한다 (먼저 `./gradlew build`로 war를 생성해야 함). `k8s/`에 namespace/configmap/secret/deployment/service가 있고, DB URL·ES URI는 ConfigMap, DB 자격증명은 Secret으로 주입된다.

## 참조 파일

프로젝트 작업 규칙이 `claude/` 아래 세분화되어 있다. 작업 성격에 맞는 파일을 먼저 확인한다.

| 파일 | 역할 |
|---|---|
| `claude/CLAUDE.md` | 이 파일의 원본 격 — 행동 원칙, EOD 루틴 등 작업 방식 전반 |
| `claude/1-engineering.md` | 영향 분석(blast radius), DRY, 주석 규칙 |
| `claude/2-multi_engineering.md` | 빌드 검증 루프(`./gradlew build`), 작업 규모별 QC 체크리스트 |
| `claude/3-architecture.md` | 인증·라우팅·결재·어드민 설계 상세 |
| `claude/4-mybatis-rules.md` | MyBatis Mapper 작성 규칙 상세 |
| `claude/5-defensive-coding.md` | 방어적 코딩(실패모드 스캔), "완료" 기준, EOD 루틴 상세 |
| `claude/6-stack-notes.md` | 기술 스택 버전별 호환성 이슈 (아래 요약) |

### 자주 걸리는 이슈 (`claude/6-stack-notes.md` 요약)

- Jakarta EE 10 기반 — `javax.*`가 아니라 `jakarta.*` import.
- Gradle 9의 BOM(`platform()`)은 `compileOnly`/`annotationProcessor`에 전파되지 않는다 — Lombok 버전은 양쪽에 직접 명시.
- `runtimeOnly`로 mysql-connector 선언 시 Gradle 9에서 설정 mutate 에러 — `implementation`으로 선언.
- include되는 JSP(`header.jsp`, `footer.jsp` 등)에는 `contentType` 지시자를 쓰지 않는다 — 부모와 중복되면 Jasper 에러.
- PowerShell로 파일 작성 시 `Out-File`/`Set-Content -Encoding utf8`은 BOM을 붙여 Java 컴파일 에러를 낸다 — `[System.IO.File]::WriteAllText`로 BOM 없이 쓴다.
- 정적 리소스(CSS/JS)는 Cloudflare 엣지에서 확장자 기준 자동 캐싱된다 — CSS 수정 시 `style.css?v=N` 캐시버스트 쿼리스트링 숫자를 올린다 (커밋 히스토리에 반복되는 패턴).

## 코드/문서 작성 규칙

- **이모지 사용 금지.** 소스 코드, 커밋 메시지, 주석, 문서 어디에도 쓰지 않는다.
- **공개 콘텐츠는 사실만.** 제공받지 않은 회사 정보·수치·실적을 임의로 만들지 않는다. 정보가 없으면 업계 일반 문구로 채우지 말고 무엇이 필요한지 먼저 묻는다.
