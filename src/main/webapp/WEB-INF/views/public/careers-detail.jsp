<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${content.title} - 채용</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="page-banner">
    <h1>채용</h1>
    <p>함께 성장할 인재를 기다립니다</p>
</section>

<div class="section">
    <a href="/careers" class="back-link">← 목록으로</a>
    <div class="public-detail-box">
        <h2>${content.title}</h2>
        <p class="public-detail-meta">${content.createdAt}</p>
        <hr>
        <p class="public-detail-body">${content.body}</p>
        <a href="/contact" class="btn-apply">지원 문의하기</a>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>