<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${companyName}</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="hero">
    <h1>${companyName}</h1>
    <p>신뢰와 혁신으로 함께 성장합니다</p>
</section>

<div class="section">
    <h2>서비스 소개</h2>
    <div class="cards">
        <div class="card">
            <h3>서비스 A</h3>
            <p>예시 서비스 설명입니다.</p>
        </div>
        <div class="card">
            <h3>서비스 B</h3>
            <p>예시 서비스 설명입니다.</p>
        </div>
        <div class="card">
            <h3>서비스 C</h3>
            <p>예시 서비스 설명입니다.</p>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>