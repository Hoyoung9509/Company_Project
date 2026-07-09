<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${companyName}</title>
    <link rel="stylesheet" href="/resources/css/style.css?v=7">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<% if (_loginUser != null && "ADMIN".equals(_loginUser.getRole())) { %>
<a href="/admin/content/new?type=SERVICE&redirectTo=/" class="fab-add" title="서비스 등록">+</a>
<% } %>

<section class="hero">
    <h1>${companyName}</h1>
    <p>아이들의 마음에 노래를 선물합니다</p>
</section>

<div class="section">
    <h2>서비스 소개</h2>
    <div class="cards">
        <c:forEach var="item" items="${contentList}">
            <div class="card">
                <h3>${item.title}</h3>
                <p>${item.body}</p>
            </div>
        </c:forEach>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>