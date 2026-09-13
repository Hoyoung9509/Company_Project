<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>제작과정 관리 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=37"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <div class="page-header">
        <h2 class="page-title">제작과정 관리</h2>
    </div>
    <p class="empty-msg" style="text-align:left;">홈페이지 "제작과정" 섹션과 <a href="/process" target="_blank">/process</a> 페이지에 노출되는 단계를 여기서 관리합니다.</p>

    <form method="post" action="/admin/process-steps/new" class="portal-form">
        <div class="form-group">
            <label>제목 *</label>
            <input type="text" name="title" required placeholder="예: 상담 · 기획">
        </div>
        <div class="form-group">
            <label>설명 *</label>
            <textarea name="description" rows="3" required placeholder="예: 원하시는 동요의 컨셉과 용도를 함께 논의합니다"></textarea>
        </div>
        <div class="btn-group">
            <button type="submit" class="btn-primary">추가</button>
        </div>
    </form>

    <c:choose>
        <c:when test="${empty steps}">
            <p class="empty-msg">등록된 제작과정 단계가 없습니다.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="s" items="${steps}">
                <form id="editForm_${s.id}" method="post" action="/admin/process-steps/${s.id}/edit"></form>
                <form id="deleteForm_${s.id}" method="post" action="/admin/process-steps/${s.id}/delete"
                      onsubmit="return confirm('삭제하면 복구할 수 없습니다. 계속하시겠습니까?')"></form>
                <form id="moveUpForm_${s.id}" method="post" action="/admin/process-steps/${s.id}/move-up"></form>
                <form id="moveDownForm_${s.id}" method="post" action="/admin/process-steps/${s.id}/move-down"></form>
            </c:forEach>
            <table class="data-table">
                <colgroup>
                    <col style="width:8%;">
                    <col style="width:22%;">
                    <col style="width:40%;">
                    <col style="width:30%;">
                </colgroup>
                <thead>
                <tr>
                    <th>순서</th>
                    <th>제목</th>
                    <th>설명</th>
                    <th>관리</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="s" items="${steps}" varStatus="loop">
                    <tr>
                        <td style="display:flex;gap:4px;">
                            <button type="submit" form="moveUpForm_${s.id}" class="btn-sm btn-secondary"
                                    ${loop.first ? 'disabled' : ''}>▲</button>
                            <button type="submit" form="moveDownForm_${s.id}" class="btn-sm btn-secondary"
                                    ${loop.last ? 'disabled' : ''}>▼</button>
                        </td>
                        <td><input type="text" name="title" value="${s.title}" required form="editForm_${s.id}" style="width:100%;"></td>
                        <td><textarea name="description" rows="2" required form="editForm_${s.id}" style="width:100%;">${s.description}</textarea></td>
                        <td style="display:flex;gap:6px;flex-wrap:wrap;">
                            <button type="submit" form="editForm_${s.id}" class="btn-sm btn-primary">저장</button>
                            <button type="submit" form="deleteForm_${s.id}" class="btn-sm btn-danger">삭제</button>
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
