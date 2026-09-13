<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회사소개 - JuniMusic</title>
    <link rel="stylesheet" href="/resources/css/style.css?v=37">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="page-banner">
    <h1>회사소개</h1>
    <p>아이와 함께 자라는 음악, JuniMusic</p>
</section>

<div class="section">
    <c:choose>
        <c:when test="${empty contentList}">
            <p class="empty-msg">등록된 회사소개 콘텐츠가 없습니다.</p>
        </c:when>
        <c:otherwise>
            <div class="about-grid">
                <c:forEach var="item" items="${contentList}">
                    <div class="about-card">
                        <h3>${item.title}</h3>
                        <p>${item.body}</p>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<div class="section section-gray">
    <h2>연혁</h2>
    <c:choose>
        <c:when test="${empty historyList}">
            <p class="empty-msg">등록된 연혁이 없습니다.</p>
        </c:when>
        <c:otherwise>
            <ul class="timeline">
                <c:forEach var="h" items="${historyList}">
                    <li><span class="year">${h.year}</span> ${h.description}</li>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>