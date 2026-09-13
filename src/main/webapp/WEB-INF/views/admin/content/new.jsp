<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>콘텐츠 등록 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=37"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <a href="${empty redirectTo ? '/admin/content' : redirectTo}" class="back-link">← 돌아가기</a>
    <h2 class="page-title">콘텐츠 등록</h2>
    <c:if test="${not empty error}">
        <p class="msg-error">${error}</p>
    </c:if>
    <form method="post" action="/admin/content/new" class="portal-form">
        <c:if test="${not empty redirectTo}">
            <input type="hidden" name="redirectTo" value="${redirectTo}">
        </c:if>
        <div class="form-group">
            <label>타입 *</label>
            <select name="type" id="typeSelect" onchange="toggleMediaUrl()" required>
                <option value="WORK" ${presetType == 'WORK' ? 'selected' : ''}>작업물 (WORK)</option>
                <option value="SERVICE" ${presetType == 'SERVICE' ? 'selected' : ''}>서비스 (SERVICE)</option>
                <option value="CAREER" ${presetType == 'CAREER' ? 'selected' : ''}>채용 (CAREER)</option>
                <option value="NOTICE_PUBLIC" ${presetType == 'NOTICE_PUBLIC' ? 'selected' : ''}>뉴스 (NOTICE_PUBLIC)</option>
                <option value="NOTICE_INTERNAL" ${presetType == 'NOTICE_INTERNAL' ? 'selected' : ''}>사내공지 (NOTICE_INTERNAL)</option>
                <option value="ABOUT" ${presetType == 'ABOUT' ? 'selected' : ''}>회사소개 (ABOUT)</option>
            </select>
        </div>
        <div class="form-group">
            <label>제목 *</label>
            <input type="text" name="title" value="${content.title}" required>
        </div>
        <div class="form-group">
            <label>내용 *</label>
            <textarea name="body" rows="8" required>${content.body}</textarea>
        </div>
        <div class="form-group" id="mediaUrlGroup">
            <label>영상 링크 (유튜브, 작업물만 사용)</label>
            <input type="text" name="mediaUrl" value="${content.mediaUrl}" placeholder="https://www.youtube.com/watch?v=...">
        </div>
        <div class="form-group" id="categoryGroup">
            <label>작업물 카테고리 *</label>
            <select name="workCategoryId" id="categorySelect">
                <option value="" disabled selected>카테고리 선택</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.id}">${cat.name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label><input type="checkbox" name="isPublished" value="1" style="width:auto;" ${not empty redirectTo ? 'checked' : ''}> 즉시 공개</label>
        </div>
        <div class="btn-group">
            <a href="${empty redirectTo ? '/admin/content' : redirectTo}" class="btn-secondary">취소</a>
            <button type="submit" class="btn-primary">등록</button>
        </div>
    </form>
</div>
</main>
<script>
function toggleMediaUrl() {
    var type = document.getElementById('typeSelect').value;
    var isWork = (type === 'WORK');
    var display = isWork ? '' : 'none';
    document.getElementById('mediaUrlGroup').style.display = display;
    document.getElementById('categoryGroup').style.display = display;
    document.getElementById('categorySelect').required = isWork;
}
toggleMediaUrl();
</script>
</body>
</html>
