<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>감사 로그 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=4"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <h2 class="page-title">감사 로그</h2>
    <table class="data-table">
        <thead><tr><th>일시</th><th>관리자</th><th>액션</th><th>대상</th><th>변경 전</th><th>변경 후</th></tr></thead>
        <tbody>
        <c:forEach var="log" items="${logs}">
            <tr>
                <td>${log.createdAt}</td>
                <td>${log.adminName}</td>
                <td>${log.action}</td>
                <td>${log.targetType} / ${log.targetId}</td>
                <td>${log.before}</td>
                <td>${log.after}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</main>
</body>
</html>