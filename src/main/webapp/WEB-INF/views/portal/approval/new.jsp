<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>기안 작성 - 포털</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=4"></head>
<body class="portal-body">
<%@ include file="/WEB-INF/views/common/portal-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <a href="/portal/approval" class="back-link">← 결재함으로</a>
    <h2 class="page-title">기안 작성</h2>
    <form method="post" action="/portal/approval/new" class="portal-form">
        <div class="form-group">
            <label>제목 <span class="required">*</span></label>
            <input type="text" name="title" required placeholder="기안 제목을 입력하세요">
        </div>
        <div class="form-group">
            <label>내용 <span class="required">*</span></label>
            <textarea name="content" rows="10" required placeholder="기안 내용을 입력하세요"></textarea>
        </div>
        <div class="btn-group">
            <button type="submit" name="action" value="draft" class="btn-secondary">임시저장</button>
            <button type="submit" name="action" value="submit" class="btn-primary">제출</button>
        </div>
    </form>
</div>
</main>
</body>
</html>