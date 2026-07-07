<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>결재함 - 포털</title>
<link rel="stylesheet" href="/resources/css/style.css"></head>
<body class="portal-body">
<%@ include file="/WEB-INF/views/common/portal-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <div class="page-header">
        <h2 class="page-title">결재함</h2>
        <a href="/portal/approval/new" class="btn-primary">새 기안</a>
    </div>
    <c:choose>
        <c:when test="${empty approvals}"><p class="empty-msg">결재 문서가 없습니다.</p></c:when>
        <c:otherwise>
            <table class="data-table">
                <thead><tr><th>제목</th><th>상태</th><th>기안일</th></tr></thead>
                <tbody>
                <c:forEach var="a" items="${approvals}">
                    <tr>
                        <td><a href="/portal/approval/${a.id}">${a.title}</a></td>
                        <td><span class="badge badge-${a.status}">${a.status}</span></td>
                        <td>${a.createdAt}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</main>
</body>
</html>