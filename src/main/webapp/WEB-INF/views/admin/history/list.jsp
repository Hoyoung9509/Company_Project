<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>연혁 관리 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=37"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <div class="page-header">
        <h2 class="page-title">연혁 관리</h2>
    </div>
    <p class="empty-msg" style="text-align:left;">회사소개(<a href="/about" target="_blank">/about</a>) 페이지의 "연혁" 타임라인에 노출되는 항목을 여기서 관리합니다.</p>

    <form method="post" action="/admin/history/new" class="portal-form">
        <div class="form-group">
            <label>연도 *</label>
            <input type="text" name="year" required placeholder="예: 2024">
        </div>
        <div class="form-group">
            <label>내용 *</label>
            <textarea name="description" rows="2" required placeholder="예: JuniMusic 설립"></textarea>
        </div>
        <div class="btn-group">
            <button type="submit" class="btn-primary">추가</button>
        </div>
    </form>

    <c:choose>
        <c:when test="${empty historyList}">
            <p class="empty-msg">등록된 연혁이 없습니다.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="h" items="${historyList}">
                <form id="editForm_${h.id}" method="post" action="/admin/history/${h.id}/edit"></form>
                <form id="deleteForm_${h.id}" method="post" action="/admin/history/${h.id}/delete"
                      onsubmit="return confirm('삭제하면 복구할 수 없습니다. 계속하시겠습니까?')"></form>
                <form id="moveUpForm_${h.id}" method="post" action="/admin/history/${h.id}/move-up"></form>
                <form id="moveDownForm_${h.id}" method="post" action="/admin/history/${h.id}/move-down"></form>
            </c:forEach>
            <table class="data-table">
                <colgroup>
                    <col style="width:8%;">
                    <col style="width:15%;">
                    <col style="width:47%;">
                    <col style="width:30%;">
                </colgroup>
                <thead>
                <tr>
                    <th>순서</th>
                    <th>연도</th>
                    <th>내용</th>
                    <th>관리</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="h" items="${historyList}" varStatus="loop">
                    <tr>
                        <td style="display:flex;gap:4px;">
                            <button type="submit" form="moveUpForm_${h.id}" class="btn-sm btn-secondary"
                                    ${loop.first ? 'disabled' : ''}>▲</button>
                            <button type="submit" form="moveDownForm_${h.id}" class="btn-sm btn-secondary"
                                    ${loop.last ? 'disabled' : ''}>▼</button>
                        </td>
                        <td><input type="text" name="year" value="${h.year}" required form="editForm_${h.id}" style="width:100%;"></td>
                        <td><textarea name="description" rows="2" required form="editForm_${h.id}" style="width:100%;">${h.description}</textarea></td>
                        <td style="display:flex;gap:6px;flex-wrap:wrap;">
                            <button type="submit" form="editForm_${h.id}" class="btn-sm btn-primary">저장</button>
                            <button type="submit" form="deleteForm_${h.id}" class="btn-sm btn-danger">삭제</button>
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
