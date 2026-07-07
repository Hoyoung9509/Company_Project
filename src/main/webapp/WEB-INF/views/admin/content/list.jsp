<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>콘텐츠 관리 - 어드민</title>
<link rel="stylesheet" href="/resources/css/style.css"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <h2 class="page-title">콘텐츠 관리</h2>
    <table class="data-table">
        <thead><tr><th>타입</th><th>제목</th><th>공개</th><th>등록일</th><th>관리</th></tr></thead>
        <tbody>
        <c:forEach var="c" items="${contentList}">
            <tr>
                <td><span class="badge badge-type">${c.type}</span></td>
                <td>${c.title}</td>
                <td><span class="badge ${c.isPublished==1?'badge-APPROVED':'badge-REJECTED'}">${c.isPublished==1?'공개':'비공개'}</span></td>
                <td>${c.createdAt}</td>
                <td>
                    <c:choose>
                        <c:when test="${c.isPublished == 1}">
                            <form method="post" action="/admin/content/${c.id}/unpublish" style="display:inline">
                                <button type="submit" class="btn-sm btn-secondary">비공개</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <form method="post" action="/admin/content/${c.id}/publish" style="display:inline">
                                <button type="submit" class="btn-sm btn-primary">공개</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</main>
</body>
</html>