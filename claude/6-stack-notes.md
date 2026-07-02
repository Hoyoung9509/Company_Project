# 기술 스택 주의사항 (Next.js 16 / React 19 / Tailwind v4)

기술 스택 확정 후 이 파일을 검토한다. 학습 데이터의 이전 버전 관행과 다른 부분을 정리했다.
일반 아키텍처 원칙과 세션·인증 설계는 `3-architecture.md`를 참조한다.

---

## Next.js 16 (App Router)

### `params` / `searchParams`는 Promise다

`page.tsx` / `layout.tsx`에서 반드시 `await`한 뒤 필드를 읽어야 한다. 동기 구조 분해는 Next.js 16 오류다.

```ts
// ✅ 올바른 방법
const { id } = await params;

// ❌ Next.js 16 오류
const { id } = params;
```

### Server vs Client 분리

- 데이터 패칭·DB 접근은 **Server Component**에서 처리한다.
- `'use client'`는 상태·이벤트가 필요한 조각에만 붙인다: 결재 서류 에디터, 문의 폼, 모달, 동적 필터 등.
- 공개 페이지(회사소개·서비스·채용·공지)는 Server Component로 렌더링하여 SEO를 보장한다.

### Server Action 뮤테이션

- 생성·수정에는 Server Action을 사용한다. React 19 `useActionState`로 pending/error 상태를 관리한다.
- 제출 버튼에 `disabled` / 로딩 상태를 반드시 붙인다 — 중복 제출 방지.
- 결재 승인·반려처럼 되돌릴 수 없는 작업에는 확인 다이얼로그를 추가한다.

### 미들웨어에서 세션 체크

Next.js `middleware.ts`에서 쿠키의 `sessionId`를 읽어 `/portal`, `/admin` 경로를 보호한다.
미들웨어는 Edge Runtime이므로 Prisma를 직접 호출할 수 없다 — 가벼운 쿠키 존재 여부만 확인하고, 실제 권한 검증은 각 Server Action / Route Handler에서 `requireEmployee()` / `requireAdmin()`으로 수행한다.

---

## Tailwind CSS v4

스타일시트 진입점에 `@import "tailwindcss";`를 사용한다. 이전 버전의 `@tailwind base; @tailwind components; @tailwind utilities;` 방식이 아니다. 테마 설정은 CSS의 `@theme` 블록으로, `@tailwindcss/postcss` 기반이다. `tailwind.config.js`를 기반 설정으로 사용하지 않는다.

---

## 파일 업로드 (결재 서류 첨부)

- 파일 크기 제한을 서버 사이드에서 검증한다. 클라이언트 검증은 UX용이며 신뢰하지 않는다.
- 허용 파일 형식(MIME type)을 서버에서 재확인한다.
- 업로드 실패 시 사용자에게 명확한 오류 메시지를 표시한다 (용량 초과·형식 오류 구분).
- 업로드된 파일을 public 경로에 직접 노출하지 않는다. 접근 권한 체크 후 서빙한다.
