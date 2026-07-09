<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>조직도 - 포털</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=5"></head>
<body class="portal-body">
<%@ include file="/WEB-INF/views/common/portal-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <h2 class="page-title">조직도</h2>
    <table class="data-table">
        <thead><tr><th>이름</th><th>부서</th><th>직급</th><th>이메일</th></tr></thead>
        <tbody>
        <c:forEach var="u" items="${users}">
            <tr>
                <td>${u.name}</td>
                <td>${u.department}</td>
                <td>${u.position}</td>
                <td>${u.email}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</main>
</body>
</html>