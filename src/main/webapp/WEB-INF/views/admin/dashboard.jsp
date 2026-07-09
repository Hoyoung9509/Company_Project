<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>어드민 대시보드</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=9"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <h2 class="page-title">어드민 대시보드</h2>
    <div class="dash-grid">
        <div class="stat-card"><span class="stat-num">${userCount}</span><span class="stat-label">전체 계정</span></div>
        <div class="stat-card"><span class="stat-num">${contentCount}</span><span class="stat-label">콘텐츠</span></div>
        <div class="stat-card"><span class="stat-num">${approvalCount}</span><span class="stat-label">결재 문서</span></div>
    </div>
    <div class="quick-links">
        <a href="/admin/users" class="quick-link">계정 관리</a>
        <a href="/admin/content" class="quick-link">콘텐츠 관리</a>
        <a href="/admin/approvals" class="quick-link">결재 관리</a>
        <a href="/admin/logs" class="quick-link">감사 로그</a>
    </div>
</div>
</main>
</body>
</html>