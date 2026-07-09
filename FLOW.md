# 현재 프로젝트 구조 및 요청 흐름

> 임시 참고 문서 — 파악 후 삭제해도 됩니다.

---

## 1. 만들어진 파일 목록

### 설정 / 빌드
| 파일 | 역할 |
|---|---|
| `build.gradle.kts` | Spring Boot 3.3, MyBatis, MySQL, Lombok 의존성 |
| `src/main/resources/application.yml` | 서버 포트, DB 연결, MyBatis, ViewResolver 설정 |

### Java 소스
| 파일 | 역할 |
|---|---|
| `HomeApplication.java` | Spring Boot 시작점 (`main` 메서드) |
| `controller/PublicController.java` | `GET /` 요청을 받아 JSP 이름 반환 |
| `service/ContentService.java` | 서비스 인터페이스 (메서드 선언만) |
| `service/impl/ContentServiceImpl.java` | 서비스 구현체 (현재 mock 데이터 반환) |
| `vo/ContentVo.java` | DB 컬럼과 매핑되는 데이터 객체 (`@Data` Lombok) |

### JSP / CSS
| 파일 | 역할 |
|---|---|
| `webapp/WEB-INF/views/public/index.jsp` | 메인 페이지 HTML |
| `webapp/WEB-INF/views/common/header.jsp` | 공통 네비게이션 (index.jsp에 include) |
| `webapp/WEB-INF/views/common/footer.jsp` | 공통 하단 (index.jsp에 include) |
| `webapp/resources/css/style.css` | 레이아웃 스타일 |

### 스크립트
| 파일 | 역할 |
|---|---|
| `scripts/start.bat` | `gradlew bootRun` 실행 |
| `scripts/stop.bat` | 8080 포트 프로세스 종료 |

---

## 2. 요청 흐름 (GET /)

```
브라우저
  |
  | HTTP GET http://localhost:8080/
  v
[Tomcat 내장 서버]
  DispatcherServlet (모든 요청의 관문)
  |
  | URL 패턴 매핑 확인
  v
[PublicController.java]
  @GetMapping("/")
  public String index(Model model)
  |
  | contentService.getPublishedContents() 호출
  v
[ContentService.java]  ← 인터페이스 (선언)
  |
  v
[ContentServiceImpl.java]  ← 구현체
  현재: mock 데이터(ContentVo) 리스트 반환
  추후: Repository → MyBatis → MySQL 로 교체 예정
  |
  | 반환된 데이터를 Model에 담음
  |   model.addAttribute("companyName", "회사 홈페이지")
  |   model.addAttribute("contentList", ...)
  |
  | "public/index" 문자열 반환
  v
[ViewResolver]  ← application.yml 설정 기반
  prefix: /WEB-INF/views/
  suffix: .jsp
  → /WEB-INF/views/public/index.jsp 파일을 찾음
  |
  v
[index.jsp]
  <%@ include file="/WEB-INF/views/common/header.jsp" %>
  ${companyName}, ${contentList} 로 데이터 출력
  <%@ include file="/WEB-INF/views/common/footer.jsp" %>
  |
  | HTML 완성
  v
브라우저 렌더링
```

---

## 3. 데이터 이동 경로 요약

```
Controller → Service → (VO) → Controller(Model) → JSP → HTML
```

| 단계 | 파일 | 하는 일 |
|---|---|---|
| 1 | `PublicController` | 요청 수신, Service 호출 |
| 2 | `ContentService` | 인터페이스로 계약 정의 |
| 3 | `ContentServiceImpl` | 실제 데이터 조회 (현재 mock) |
| 4 | `ContentVo` | 데이터를 담는 그릇 |
| 5 | `PublicController` | Model에 데이터 저장 |
| 6 | `index.jsp` | Model 데이터로 HTML 생성 |
| 7 | `header.jsp` / `footer.jsp` | index.jsp에 정적 포함 |

---

## 4. DB 연결 후 추가될 파일 (예정)

```
ContentServiceImpl
  → ContentRepository.java         (Mapper 인터페이스)
  → resources/mapper/ContentMapper.xml  (SQL 작성)
  → MySQL DB
```