<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작업물 - JuniMusic</title>
    <link rel="stylesheet" href="/resources/css/style.css?v=4">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="page-banner">
    <h1>작업물</h1>
    <p>JuniMusic이 만든 동요와 영상을 소개합니다</p>
</section>

<div class="section">
    <c:choose>
        <c:when test="${empty contentList}">
            <p class="empty-msg">등록된 작업물이 없습니다.</p>
        </c:when>
        <c:otherwise>
            <div class="work-list">
                <c:forEach var="item" items="${contentList}">
                    <div class="work-card">
                        <c:choose>
                            <c:when test="${not empty item.youtubeId}">
                                <a href="https://www.youtube.com/watch?v=${item.youtubeId}" target="_blank" rel="noopener"
                                   class="work-thumb work-thumb-video"
                                   style="background-image:url('https://img.youtube.com/vi/${item.youtubeId}/hqdefault.jpg');">
                                    <span class="play-icon">▶</span>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <div class="work-thumb"><span class="play-icon">▶</span></div>
                            </c:otherwise>
                        </c:choose>
                        <div class="work-info">
                            <h3>${item.title}</h3>
                            <p>${item.body}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>
