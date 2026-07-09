<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문의 - JuniMusic</title>
    <link rel="stylesheet" href="/resources/css/style.css?v=8">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="page-banner">
    <h1>문의</h1>
    <p>궁금한 점이 있으시면 언제든지 연락주세요</p>
</section>

<div class="section">
    <div class="contact-wrap">

        <% if (request.getAttribute("error") != null) { %>
            <p class="msg-error">${error}</p>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            <p class="msg-success">${success}</p>
        <% } %>

        <form method="post" action="/contact" class="contact-form">
            <div class="form-row">
                <div class="form-group">
                    <label>이름 <span class="required">*</span></label>
                    <input type="text" name="name" placeholder="홍길동" required>
                </div>
                <div class="form-group">
                    <label>이메일 <span class="required">*</span></label>
                    <input type="email" name="email" placeholder="example@junimusic.shop" required>
                </div>
            </div>
            <div class="form-group">
                <label>연락처</label>
                <input type="tel" name="phone" placeholder="010-0000-0000">
            </div>
            <div class="form-group">
                <label>제목 <span class="required">*</span></label>
                <input type="text" name="title" placeholder="문의 제목을 입력해주세요" required>
            </div>
            <div class="form-group">
                <label>문의 내용 <span class="required">*</span></label>
                <textarea name="message" rows="6" placeholder="문의 내용을 입력해주세요" required></textarea>
            </div>
            <button type="submit" class="btn-submit">문의 보내기</button>
        </form>

    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>