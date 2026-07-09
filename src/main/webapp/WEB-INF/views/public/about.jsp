<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회사소개 - JuniMusic</title>
    <link rel="stylesheet" href="/resources/css/style.css?v=4">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="page-banner">
    <h1>회사소개</h1>
    <p>아이와 함께 자라는 음악, JuniMusic</p>
</section>

<div class="section">
    <h2>비전 &amp; 미션</h2>
    <div class="about-grid">
        <div class="about-card">
            <h3>비전</h3>
            <p>아이들의 세상에 가장 맑은 노래를 전하는 기업</p>
        </div>
        <div class="about-card">
            <h3>미션</h3>
            <p>아이와 부모 모두가 웃을 수 있는 동요를 만드는 파트너</p>
        </div>
        <div class="about-card">
            <h3>핵심 가치</h3>
            <p>순수 · 즐거움 · 창의 · 감동</p>
        </div>
    </div>
</div>

<div class="section section-gray">
    <h2>연혁</h2>
    <ul class="timeline">
        <li><span class="year">2024</span> JuniMusic 설립</li>
        <li><span class="year">2024</span> 첫 동요 앨범 발매</li>
    </ul>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>