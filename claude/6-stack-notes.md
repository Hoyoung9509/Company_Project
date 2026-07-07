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