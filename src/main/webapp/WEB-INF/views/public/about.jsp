<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회사소개 - Company</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="page-banner">
    <h1>회사소개</h1>
    <p>신뢰와 혁신으로 함께 성장합니다</p>
</section>

<div class="section">
    <h2>비전 &amp; 미션</h2>
    <div class="about-grid">
        <div class="about-card">
            <h3>비전</h3>
            <p>업계를 선도하는 혁신 기업</p>
        </div>
        <div class="about-card">
            <h3>미션</h3>
            <p>고객의 성공을 통해 함께 성장하는 파트너</p>
        </div>
        <div class="about-card">
            <h3>핵심 가치</h3>
            <p>신뢰 · 혁신 · 협력 · 성장</p>
        </div>
    </div>
</div>

<div class="section section-gray">
    <h2>연혁</h2>
    <ul class="timeline">
        <li><span class="year">2024</span> 회사 설립</li>
        <li><span class="year">2024</span> 서비스 론칭</li>
    </ul>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>