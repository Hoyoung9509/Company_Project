<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>콘텐츠 등록 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=6"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <a href="/admin/content" class="back-link">← 콘텐츠 관리로</a>
    <h2 class="page-title">콘텐츠 등록</h2>
    <form method="post" action="/admin/content/new" class="portal-form">
        <div class="form-group">
            <label>타입 *</label>
            <select name="type" id="typeSelect" onchange="toggleMediaUrl()" required>
                <option value="WORK">작업물 (WORK)</option>
                <option value="SERVICE">서비스 (SERVICE)</option>
                <option value="CAREER">채용 (CAREER)</option>
                <option value="NOTICE_PUBLIC">뉴스 (NOTICE_PUBLIC)</option>
                <option value="NOTICE_INTERNAL">사내공지 (NOTICE_INTERNAL)</option>
            </select>
        </div>
        <div class="form-group">
            <label>제목 *</label>
            <input type="text" name="title" required>
        </div>
        <div class="form-group">
            <label>내용 *</label>
            <textarea name="body" rows="8" required></textarea>
        </div>
        <div class="form-group" id="mediaUrlGroup">
            <label>영상 링크 (유튜브, 작업물만 사용)</label>
            <input type="text" name="mediaUrl" placeholder="https://www.youtube.com/watch?v=...">
        </div>
        <div class="form-group">
            <label><input type="checkbox" name="isPublished" value="1" style="width:auto;"> 즉시 공개</label>
        </div>
        <div class="btn-group">
            <a href="/admin/content" class="btn-secondary">취소</a>
            <button type="submit" class="btn-primary">등록</button>
        </div>
    </form>
</div>
</main>
<script>
function toggleMediaUrl() {
    var type = document.getElementById('typeSelect').value;
    document.getElementById('mediaUrlGroup').style.display = (type === 'WORK') ? '' : 'none';
}
toggleMediaUrl();
</script>
</body>
</html>
