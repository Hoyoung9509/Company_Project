<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>공지 수정 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=5"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <a href="/admin/content" class="back-link">← 콘텐츠 관리로</a>
    <h2 class="page-title">공지 수정</h2>
    <form method="post" action="/admin/content/${content.id}/edit" class="portal-form">
        <div class="form-group">
            <label>타입</label>
            <input type="text" value="${content.type}" disabled>
        </div>
        <div class="form-group">
            <label>제목 *</label>
            <input type="text" name="title" value="${content.title}" required>
        </div>
        <div class="form-group">
            <label>내용 *</label>
            <textarea name="body" rows="8" required>${content.body}</textarea>
        </div>
        <div class="form-group">
            <label>영상 링크 (유튜브, 선택)</label>
            <input type="text" name="mediaUrl" value="${content.mediaUrl}" placeholder="https://www.youtube.com/watch?v=...">
        </div>
        <div class="btn-group">
            <a href="/admin/content" class="btn-secondary">취소</a>
            <button type="submit" class="btn-primary">저장</button>
        </div>
    </form>
</div>
</main>
</body>
</html>