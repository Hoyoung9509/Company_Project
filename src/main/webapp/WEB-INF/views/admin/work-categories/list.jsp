<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>작업물 카테고리 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=37"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <div class="page-header">
        <h2 class="page-title">작업물 카테고리</h2>
    </div>

    <form method="post" action="/admin/work-categories/new" class="portal-form">
        <div class="form-group">
            <label>새 카테고리 이름 *</label>
            <input type="text" name="name" required placeholder="예: 동요, 캐릭터송, 뮤직비디오">
        </div>
        <div class="btn-group">
            <button type="submit" class="btn-primary">추가</button>
        </div>
    </form>

    <c:choose>
        <c:when test="${empty categories}">
            <p class="empty-msg">등록된 카테고리가 없습니다.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="cat" items="${categories}">
                <form id="editForm_${cat.id}" method="post" action="/admin/work-categories/${cat.id}/edit"></form>
                <form id="deleteForm_${cat.id}" method="post" action="/admin/work-categories/${cat.id}/delete"
                      onsubmit="return confirm('이 카테고리를 삭제하면 해당 작업물은 미분류로 남습니다. 계속하시겠습니까?')"></form>
                <form id="moveUpForm_${cat.id}" method="post" action="/admin/work-categories/${cat.id}/move-up"></form>
                <form id="moveDownForm_${cat.id}" method="post" action="/admin/work-categories/${cat.id}/move-down"></form>
            </c:forEach>
            <table class="data-table">
                <colgroup>
                    <col style="width:15%;">
                    <col style="width:35%;">
                    <col style="width:20%;">
                    <col style="width:30%;">
                </colgroup>
                <thead>
                <tr>
                    <th>순서</th>
                    <th>이름</th>
                    <th>등록일</th>
                    <th>관리</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="cat" items="${categories}" varStatus="loop">
                    <tr>
                        <td style="display:flex;gap:4px;">
                            <button type="submit" form="moveUpForm_${cat.id}" class="btn-sm btn-secondary"
                                    ${loop.first ? 'disabled' : ''}>▲</button>
                            <button type="submit" form="moveDownForm_${cat.id}" class="btn-sm btn-secondary"
                                    ${loop.last ? 'disabled' : ''}>▼</button>
                        </td>
                        <td><input type="text" name="name" value="${cat.name}" required form="editForm_${cat.id}" style="width:100%;"></td>
                        <td>${cat.createdAt}</td>
                        <td style="display:flex;gap:6px;flex-wrap:wrap;">
                            <button type="submit" form="editForm_${cat.id}" class="btn-sm btn-primary">저장</button>
                            <button type="submit" form="deleteForm_${cat.id}" class="btn-sm btn-danger">삭제</button>
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
