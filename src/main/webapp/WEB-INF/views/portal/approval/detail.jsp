<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>${approval.title} - 결재</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=7"></head>
<body class="portal-body">
<%@ include file="/WEB-INF/views/common/portal-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <a href="/portal/approval" class="back-link">← 결재함으로</a>
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
        <c:if test="${approval.status == 'DRAFT' && loginUser.id == approval.drafterId}">
            <form method="post" action="/portal/approval/${approval.id}/submit">
                <button type="submit" class="btn-primary">제출</button>
            </form>
        </c:if>
        <c:if test="${approval.status == 'IN_REVIEW' && (loginUser.role == 'MANAGER' || loginUser.role == 'ADMIN')}">
            <form method="post" action="/portal/approval/${approval.id}/approve" class="inline-form">
                <input type="text" name="comment" placeholder="의견 (선택)">
                <button type="submit" class="btn-primary">승인</button>
            </form>
            <form method="post" action="/portal/approval/${approval.id}/reject" class="inline-form">
                <input type="text" name="comment" placeholder="반려 사유">
                <button type="submit" class="btn-danger">반려</button>
            </form>
        </c:if>
        <c:if test="${approval.status == 'REJECTED' && loginUser.id == approval.drafterId}">
            <form method="post" action="/portal/approval/${approval.id}/resubmit">
                <button type="submit" class="btn-secondary">재제출</button>
            </form>
        </c:if>
    </div>

    <c:if test="${not empty approval.logs}">
        <div class="log-section">
            <h3>처리 이력</h3>
            <ul class="log-list">
                <c:forEach var="log" items="${approval.logs}">
                    <li>
                        <span class="badge badge-${log.action}">${log.action}</span>
                        <span>${log.actorName}</span>
                        <c:if test="${not empty log.comment}"><span class="log-comment">"${log.comment}"</span></c:if>
                        <span class="log-date">${log.createdAt}</span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </c:if>
</div>
</main>
</body>
</html>