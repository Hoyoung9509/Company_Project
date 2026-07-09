<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${content.title} - 작업물</title>
    <link rel="stylesheet" href="/resources/css/style.css?v=10">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="page-banner">
    <h1>작업물</h1>
    <p>JuniMusic이 만든 동요와 영상을 소개합니다</p>
</section>

<div class="section">
    <a href="/works" class="back-link">← 목록으로</a>
    <div class="public-detail-box public-detail-box-wide">
        <c:if test="${not empty content.youtubeId}">
            <div class="work-detail-video">
                <iframe src="https://www.youtube.com/embed/${content.youtubeId}"
                        allow="autoplay; encrypted-media; picture-in-picture" allowfullscreen></iframe>
            </div>
        </c:if>
        <h2>${content.title}</h2>
        <p class="public-detail-meta">${content.createdAt}</p>
        <hr>
        <p class="public-detail-body">${content.body}</p>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>
