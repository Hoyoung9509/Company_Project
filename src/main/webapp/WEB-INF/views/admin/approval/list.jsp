<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>결재 관리 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=5"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <h2 class="page-title">결재 관리</h2>
    <table class="data-table">
        <thead><tr><th>제목</th><th>기안자</th><th>상태</th><th>기안일</th><th>관리</th></tr></thead>
        <tbody>
        <c:forEach var="a" items="${approvals}">
            <tr>
                <td><a href="/admin/approvals/${a.id}">${a.title}</a></td>
                <td>${a.drafterName}</td>
                <td><span class="badge badge-${a.status}">${a.status}</span></td>
                <td>${a.createdAt}</td>
                <td><a href="/admin/approvals/${a.id}" class="btn-sm btn-secondary">상세</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</main>
</body>
</html>