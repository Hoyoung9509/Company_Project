<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>서비스 - Company</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="page-banner">
    <h1>서비스</h1>
    <p>최고의 가치를 제공하는 서비스를 만나보세요</p>
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