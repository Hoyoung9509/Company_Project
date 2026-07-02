# Prisma 마이그레이션 규칙

기존 마이그레이션 파일(`prisma/migrations/<timestamp>_<name>/migration.sql`)은 **수정·rename 금지**. 한 번 운영에 적용된 마이그레이션은 불변이다.

`schema.prisma` 변경 후엔 항상 새 마이그레이션을 추가한다:

```bash
pnpm prisma migrate dev --name <짧은_설명>
```

기존 파일을 직접 수정하거나 rename하면 운영 배포 시 `P3018`(이미 존재하는 ENUM/테이블 재생성 시도) 또는 `P3019`(checksum 불일치)로 배포가 차단된다.

---

## 이 프로젝트의 핵심 모델 (스키마 변경 시 영향 범위 확인)

- **User** — 계정 비활성화(`isActive`), 역할(`role`) 변경은 `AuditLog` 생성 필수 (`3-architecture.md` 참조)
- **Session** — 직접 수정하지 않는다. `getSession()` 헬퍼를 통해서만 읽는다
- **Approval / ApprovalLog** — 상태 전환은 항상 `prisma.$transaction()`으로 묶는다
- **AuditLog** — 삭제 불가 모델. 어드민도 삭제할 수 없도록 API에서 DELETE를 노출하지 않는다
- **Content** — `published` / `draft` 상태 필드 변경 시 퍼블릭 페이지 렌더링 영향 확인
