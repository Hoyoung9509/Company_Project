# 기술 스택 주의사항

이 파일은 각 기술의 버전별 특이사항과 이 프로젝트에서 확인된 호환성 이슈를 기록한다.

---

## Spring Boot 3.3.0

- Jakarta EE 10 기반 — `javax.*` 대신 `jakarta.*` 사용 (import 주의)
  - `jakarta.servlet.http.HttpSession`
  - `jakarta.servlet.http.HttpServletRequest`
- `io.spring.dependency-management` 플러그인이 Gradle 9과 충돌 → **제거됨**
  - 대신 `implementation(platform("org.springframework.boot:spring-boot-dependencies:3.3.0"))`으로 BOM 적용

---

## Gradle 9.0.0 (Kotlin DSL)

- `runtimeOnly("com.mysql:mysql-connector-j")` 사용 시 **"Cannot mutate the dependency attributes of configuration ':runtimeOnly'"** 에러 발생
  - `implementation("com.mysql:mysql-connector-j")`으로 변경 — 해결됨
- BOM(`platform()`)은 `compileOnly`, `annotationProcessor` 설정에 **자동 전파되지 않음**
  - Lombok 버전은 반드시 명시: `compileOnly("org.projectlombok:lombok:1.18.32")` + `annotationProcessor("org.projectlombok:lombok:1.18.32")`

---

## JSP + tomcat-embed-jasper

- Spring Boot 3 내장 Tomcat에서 JSP를 쓰려면 `tomcat-embed-jasper` 의존성 필수
- `application.yml` ViewResolver 설정:
  ```yaml
  spring.mvc.view.prefix: /WEB-INF/views/
  spring.mvc.view.suffix: .jsp
  ```
- 포함(include)되는 JSP(`header.jsp`, `footer.jsp`)에는 `contentType` 지시자 사용 금지
  - 부모 JSP와 중복 시 **"illegal to have multiple occurrences of contentType"** Jasper 에러 발생
  - `<%@ page pageEncoding="UTF-8" %>`만 사용

---

## MyBatis 3.0.3 (mybatis-spring-boot-starter)

- `application.yml` 설정:
  ```yaml
  mybatis:
    mapper-locations: classpath:mapper/**/*.xml
    type-aliases-package: com.company.homepage.vo
    configuration:
      map-underscore-to-camel-case: true
  ```
- `map-underscore-to-camel-case: true`는 `snake_case → camelCase` 변환만 한다.
  - `isPublished`, `createdAt` 같이 이미 camelCase인 DB 컬럼명은 변환하지 않는다 — 그대로 매핑.
- Mapper 인터페이스에 `@Mapper` 어노테이션 또는 메인 클래스에 `@MapperScan` 필요

---

## Lombok 1.18.32

- `@Data` — getter/setter/equals/hashCode/toString 자동 생성
- `@RequiredArgsConstructor` — `final` 필드 생성자 자동 생성 (Spring DI와 함께 사용)
- 버전을 `compileOnly`와 `annotationProcessor` 양쪽에 **반드시 명시**

---

## JSTL 3.0.1

- 의존성:
  ```
  implementation("jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl-api")
  implementation("org.glassfish.web:jakarta.servlet.jsp.jstl:3.0.1")
  ```
- JSP 상단 taglib 선언: `<%@ taglib prefix="c" uri="jakarta.tags.core" %>`

---

## MySQL 8.0

- JDBC URL: `jdbc:mysql://localhost:3306/company_homepage?useSSL=false&serverTimezone=Asia/Seoul&characterEncoding=UTF-8`
- 로컬 개발: root/root
- Driver: `com.mysql.cj.jdbc.Driver`

---

## PowerShell 파일 작성 주의사항

- `Out-File -Encoding utf8` 또는 `Set-Content -Encoding utf8`은 **UTF-8 BOM**을 추가한다
  - Java 컴파일러가 `﻿` illegal character 에러를 낸다
  - 반드시 `[System.IO.File]::WriteAllText(path, content, New-Object System.Text.UTF8Encoding $false)` 사용

---

## Elasticsearch (예정)

- 현재 미구성. 도입 결정 시 이 섹션에 버전·설정·주의사항 추가.
- Spring Data Elasticsearch 또는 High-Level REST Client 방향으로 검토 예정.

---

## Cloudflare Tunnel (로컬 PC 배포)

- 로컬 PC를 `cloudflared` 터널로 외부에 노출할 때 사용. 포트포워딩·방화벽 설정 불필요 (아웃바운드 전용 연결이라 인바운드 포트를 안 염).
- Quick Tunnel(`tunnel --url ...`)은 무료·계정 불필요하지만 재시작마다 URL이 바뀜. 영구 URL이 필요하면 `tunnel login` → `tunnel create <이름>` → `tunnel route dns <이름> <도메인>` → `tunnel run <이름>` 순서로 인증된 터널을 만든다. 설정은 `%USERPROFILE%\.cloudflared\config.yml`에 저장됨 (저장소 밖).
- `cloudflared.exe`를 winget으로 설치한 직후에는 현재 셸 세션의 PATH가 갱신되지 않는다. 설치 경로(`C:\Program Files (x86)\cloudflared\cloudflared.exe`)를 직접 지정하거나 새 셸을 열어야 한다.
- Git Bash에서 `cmd.exe /c`로 배치 파일을 헤드리스(콘솔 없음 + 출력 리다이렉트) 실행하면, 그 안에서 또 다른 `.bat`(예: `gradlew.bat`)을 `call`할 때 "인식할 수 없는 명령"으로 실패하는 경우가 있다. `.exe`/`.bat`을 `Start-Process`의 `-FilePath`로 직접 지정하거나, 콘솔이 있는 상태로 실행하면 해결됨.
- **Cloudflare는 정적 파일(.css, .js 등)을 확장자 기준으로 엣지에서 자동 캐싱한다** (기본 4시간, `Cache-Control: max-age=14400`). HTML은 동적 페이지라 캐싱 안 되지만(`CF-Cache-Status: DYNAMIC`), CSS/JS는 캐싱되어 `CF-Cache-Status: HIT`이 뜬다.
  - **증상**: CSS를 수정하고 서버를 재기동해도 실제 기기(특히 모바일)에는 반영이 안 됨. HTML은 매번 새로 오니 새 메뉴/텍스트는 보이는데, 레이아웃을 담당하는 CSS만 옛날 버전이라 반응형이 깨진 것처럼 보임.
  - **해결**: `<link>` 경로에 `?v=N` 쿼리스트링을 붙여 캐시를 무효화한다 (예: `style.css?v=2`). CSS를 수정할 때마다 버전 숫자를 올릴 것. `curl -D - <url>`로 응답 헤더의 `Cf-Cache-Status`(HIT/MISS/DYNAMIC)를 확인하면 캐싱 때문인지 바로 판별 가능.