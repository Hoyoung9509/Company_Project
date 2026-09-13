<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>직원 프로필 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=37"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <div class="page-header">
        <h2 class="page-title">직원 프로필</h2>
        <a href="/admin/staff/new" class="btn-primary">+ 새 프로필 등록</a>
    </div>

    <c:choose>
        <c:when test="${empty profiles}">
            <p class="empty-msg">등록된 프로필이 없습니다.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="p" items="${profiles}">
                <form id="deleteForm_${p.id}" method="post" action="/admin/staff/${p.id}/delete"
                      onsubmit="return confirm('삭제하면 복구할 수 없습니다. 계속하시겠습니까?')"></form>
                <form id="moveUpForm_${p.id}" method="post" action="/admin/staff/${p.id}/move-up"></form>
                <form id="moveDownForm_${p.id}" method="post" action="/admin/staff/${p.id}/move-down"></form>
            </c:forEach>
            <table class="data-table">
                <colgroup>
                    <col style="width:10%;">
                    <col style="width:25%;">
                    <col style="width:20%;">
                    <col style="width:15%;">
                    <col style="width:30%;">
                </colgroup>
                <thead>
                <tr>
                    <th>순서</th>
                    <th>이름</th>
                    <th>직급/역할</th>
                    <th>등록일</th>
                    <th>관리</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="p" items="${profiles}" varStatus="loop">
                    <tr>
                        <td style="display:flex;gap:4px;">
                            <button type="submit" form="moveUpForm_${p.id}" class="btn-sm btn-secondary"
                                    ${loop.first ? 'disabled' : ''}>▲</button>
                            <button type="submit" form="moveDownForm_${p.id}" class="btn-sm btn-secondary"
                                    ${loop.last ? 'disabled' : ''}>▼</button>
                        </td>
                        <td>${p.name}</td>
                        <td>${p.position}</td>
                        <td>${p.createdAt}</td>
                        <td style="display:flex;gap:6px;flex-wrap:wrap;">
                            <a href="/admin/staff/${p.id}/edit" class="btn-sm btn-secondary">수정</a>
                            <button type="submit" form="deleteForm_${p.id}" class="btn-sm btn-danger">삭제</button>
                        </td>
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
