<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>내 정보 - 포털</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=10"></head>
<body class="portal-body">
<%@ include file="/WEB-INF/views/common/portal-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <h2 class="page-title">내 정보</h2>
    <% if (request.getParameter("updated") != null) { %>
    <p class="msg-success">정보가 업데이트되었습니다.</p>
    <% } %>
    <form method="post" action="/portal/profile" class="portal-form">
        <div class="form-group"><label>사원번호</label>
            <input type="text" value="${user.employeeId}" disabled></div>
        <div class="form-group"><label>부서</label>
            <input type="text" value="${user.department}" disabled></div>
        <div class="form-group"><label>직급</label>
            <input type="text" value="${user.position}" disabled></div>
        <div class="form-group"><label>이름</label>
            <input type="text" name="name" value="${user.name}" required></div>
        <div class="form-group"><label>이메일</label>
            <input type="email" name="email" value="${user.email}" required></div>
        <div class="form-group"><label>연락처</label>
            <input type="tel" name="phone" value="${user.phone}"></div>
        <button type="submit" class="btn-primary">저장</button>
    </form>
</div>
</main>
</body>
</html>