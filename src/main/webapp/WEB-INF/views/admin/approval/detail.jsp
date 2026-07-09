<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>${approval.title} - 결재 관리</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=6"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <a href="/admin/approvals" class="back-link">← 결재 목록으로</a>
    <div class="detail-box">
        <div class="detail-header">
            <h2>${approval.title}</h2>
            <span class="badge badge-${approval.status}">${approval.status}</span>
        </div>
        <p class="detail-meta">기안자: ${approval.drafterName} | ${approval.createdAt}</p>
        <hr>
        <p class="detail-body">${approval.content}</p>
    </div>
    <div class="action-area">
        <h3>강제 처리 (Admin Override)</h3>
        <form method="post" action="/admin/approvals/${approval.id}/override" class="inline-form">
            <select name="status">
                <option value="APPROVED">APPROVED</option>
                <option value="REJECTED">REJECTED</option>
                <option value="DRAFT">DRAFT (반환)</option>
            </select>
            <input type="text" name="comment" placeholder="사유">
            <button type="submit" class="btn-danger">처리</button>
        </form>
    </div>
    <c:if test="${not empty approval.logs}">
        <div class="log-section">
            <h3>처리 이력</h3>
            <ul class="log-list">
                <c:forEach var="log" items="${approval.logs}">
                    <li><span class="badge badge-${log.action}">${log.action}</span>
                        <span>${log.actorName}</span>
                        <c:if test="${not empty log.comment}"><span class="log-comment">"${log.comment}"</span></c:if>
                        <span class="log-date">${log.createdAt}</span></li>
                </c:forEach>
            </ul>
        </div>
    </c:if>
</div>
</main>
</body>
</html>