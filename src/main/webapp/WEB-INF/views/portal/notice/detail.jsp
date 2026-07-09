<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>${notice.title} - 공지사항</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=7"></head>
<body class="portal-body">
<%@ include file="/WEB-INF/views/common/portal-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <a href="/portal/notice" class="back-link">← 목록으로</a>
    <div class="detail-box">
        <h2>${notice.title}</h2>
        <p class="detail-meta">${notice.createdAt}</p>
        <hr>
        <p class="detail-body">${notice.body}</p>
    </div>
</div>
</main>
</body>
</html>