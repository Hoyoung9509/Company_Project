# AI Coding Agent General Development Principles

## 1. 영향 분석 & Blast Radius 체크

- 함수·클래스·Mapper를 변경하기 전에 호출부를 추적한다.
- **Cascade 수정:** Interceptor·세션 헬퍼·공통 VO를 바꾸면 영향받는 모든 Controller/Service를 같은 세션에 수정한다. 절반만 바뀐 상태로 두지 않는다.

## 2. DRY & 재사용성

- 권한 체크·세션 조회·공통 예외 처리 등 반복 로직은 공용 클래스로 추출한다.
- 기존 프로젝트 유틸·컨벤션을 먼저 확인하고, 없을 때만 새로 만든다.

## 3. 읽기 좋은 코드 & 주석

- 변수·메서드명으로 의도를 표현한다. 코드가 무엇을 하는지 반복하는 주석은 쓰지 않는다.
- **왜** 이 로직이 필요한지 비자명한 경우에만 주석을 단다.
- Javadoc(`/** */`)은 외부에서 호출하는 Service 인터페이스 메서드, 공통 유틸 클래스에 붙인다. Controller·VO·단순 getter는 생략한다.

## 4. 기존 패턴 존중

- 프로젝트의 네이밍·패키지 구조·Mapper XML 스타일을 따른다.
- `claude/3-architecture.md`의 인증·세션 설계, `claude/4-mybatis-rules.md`의 Mapper 규칙을 항상 먼저 확인한다.
- 인증 Interceptor(`AuthInterceptor`, `AdminInterceptor`)나 결재 상태 전환 로직을 건드리면 영향받는 모든 경로를 같은 세션에 수정한다.