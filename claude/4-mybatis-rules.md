# MyBatis Mapper 작성 규칙

## 기본 원칙

- SQL은 반드시 Mapper XML(`src/main/resources/mapper/`)에 작성한다. Java 코드에 SQL 문자열을 직접 쓰지 않는다.
- `@Select` 등 어노테이션 방식을 혼용하지 않는다. XML 방식으로 통일한다.

---

## namespace / id 규칙

```xml
<mapper namespace="com.company.homepage.repository.ContentRepository">
    <select id="findPublished" resultType="ContentVo">
```

- `namespace`는 대응하는 Java Mapper 인터페이스의 **풀 패키지 경로**를 정확히 적는다.
- `id`는 인터페이스의 **메서드명과 완전히 일치**해야 한다. 다르면 런타임에 찾지 못한다.
- 기존 `id`를 변경하면 반드시 인터페이스 메서드명도 함께 바꾼다.

---

## resultType vs resultMap

- 컬럼명과 VO 필드명이 **같으면** `resultType="VO클래스명"` 사용.
- 컬럼명과 필드명이 **다르면** `resultMap`을 정의해서 명시적으로 매핑한다.
- `application.yml`에 `type-aliases-package: com.company.homepage.vo` 설정되어 있으므로 VO 클래스명만 써도 된다.

```xml
<!-- 컬럼명과 필드명이 다를 때 -->
<resultMap id="userMap" type="UserVo">
    <result column="employee_id" property="employeeId"/>
</resultMap>
```

---

## 파라미터 규칙

- 파라미터가 1개일 때: `#{value}` 또는 `#{파라미터명}`
- 파라미터가 2개 이상일 때: VO 또는 `@Param`으로 묶어서 전달한다.

```java
// 인터페이스
UserVo findByEmployeeId(String employeeId);
List<ContentVo> findByTypeAndPublished(@Param("type") String type, @Param("published") boolean published);
```

---

## 금지 사항

- AuditLog, ApprovalLog Mapper에는 **DELETE 쿼리를 작성하지 않는다**. 감사 목적으로 영구 보존.
- 기존 Mapper XML의 `id`를 인터페이스 변경 없이 rename하지 않는다.
- camelCase 컬럼명(`isPublished`, `createdAt`)은 `map-underscore-to-camel-case`가 변환하지 않으므로 직접 매핑하거나 SQL에서 alias를 사용한다.

---

## DB 스키마 변경 시

- 테이블 구조는 `prisma/schema.prisma`로 관리한다. 직접 ALTER TABLE을 실행하지 않는다.
- 스키마 변경 후 `pnpm prisma migrate dev --name <설명>`으로 마이그레이션을 생성한다.
- 기존 마이그레이션 SQL 파일은 수정·삭제 금지 (checksum 불일치로 배포 차단).
- 스키마가 바뀌면 영향받는 VO·Mapper XML·Service를 같은 세션에 수정한다.