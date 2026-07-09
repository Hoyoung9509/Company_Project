<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>뉴스 - JuniMusic</title>
    <link rel="stylesheet" href="/resources/css/style.css?v=6">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="page-banner">
    <h1>뉴스</h1>
    <p>JuniMusic의 최신 소식을 전합니다</p>
</section>

<div class="section">
    <c:choose>
        <c:when test="${empty contentList}">
            <p class="empty-msg">등록된 뉴스가 없습니다.</p>
        </c:when>
        <c:otherwise>
            <div class="news-list">
                <c:forEach var="item" items="${contentList}">
                    <div class="news-item">
                        <div class="news-info">
                            <h3><a href="/news/${item.id}">${item.title}</a></h3>
                            <p>${item.body}</p>
                        </div>
                        <span class="news-date">${item.createdAt}</span>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>