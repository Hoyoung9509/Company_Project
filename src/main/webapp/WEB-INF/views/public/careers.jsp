<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>채용 - Company</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="page-banner">
    <h1>채용</h1>
    <p>함께 성장할 인재를 기다립니다</p>
</section>

<div class="section">
    <c:choose>
        <c:when test="${empty contentList}">
            <p class="empty-msg">현재 진행 중인 채용 공고가 없습니다.</p>
        </c:when>
        <c:otherwise>
            <div class="job-list">
                <c:forEach var="item" items="${contentList}">
                    <div class="job-item">
                        <h3>${item.title}</h3>
                        <p>${item.body}</p>
                        <span class="job-date">${item.createdAt}</span>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>