<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>공지사항 - 포털</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=9"></head>
<body class="portal-body">
<%@ include file="/WEB-INF/views/common/portal-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <h2 class="page-title">공지사항</h2>
    <c:choose>
        <c:when test="${empty notices}"><p class="empty-msg">공지사항이 없습니다.</p></c:when>
        <c:otherwise>
            <table class="data-table">
                <thead><tr><th>제목</th><th>등록일</th></tr></thead>
                <tbody>
                <c:forEach var="n" items="${notices}">
                    <tr>
                        <td><a href="/portal/notice/${n.id}">${n.title}</a></td>
                        <td>${n.createdAt}</td>
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