<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>서비스 - JuniMusic</title>
    <link rel="stylesheet" href="/resources/css/style.css?v=7">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<% if (_loginUser != null && "ADMIN".equals(_loginUser.getRole())) { %>
<a href="/admin/content/new?type=SERVICE&redirectTo=/services" class="fab-add" title="서비스 등록">+</a>
<% } %>

<section class="page-banner">
    <h1>서비스</h1>
    <p>아이들을 위한 다양한 동요 콘텐츠를 만나보세요</p>
</section>

<div class="section">
    <c:choose>
        <c:when test="${empty contentList}">
            <p class="empty-msg">등록된 서비스가 없습니다.</p>
        </c:when>
        <c:otherwise>
            <div class="cards">
                <c:forEach var="item" items="${contentList}">
                    <div class="card">
                        <h3>${item.title}</h3>
                        <p>${item.body}</p>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>