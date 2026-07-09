<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${content.title} - 뉴스</title>
    <link rel="stylesheet" href="/resources/css/style.css?v=9">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="page-banner">
    <h1>뉴스</h1>
    <p>JuniMusic의 최신 소식을 전합니다</p>
</section>

<div class="section">
    <a href="/news" class="back-link">← 목록으로</a>
    <div class="public-detail-box">
        <h2>${content.title}</h2>
        <p class="public-detail-meta">${content.createdAt}</p>
        <hr>
        <p class="public-detail-body">${content.body}</p>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>