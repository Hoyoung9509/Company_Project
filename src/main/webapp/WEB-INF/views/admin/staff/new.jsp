<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>프로필 등록 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=37"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <a href="/admin/staff" class="back-link">← 프로필 관리로</a>
    <h2 class="page-title">프로필 등록</h2>
    <c:if test="${not empty error || param.error == 'fileTooLarge'}">
        <p class="msg-error">
            <c:choose>
                <c:when test="${param.error == 'fileTooLarge'}">사진 파일은 10MB 이하만 업로드할 수 있습니다.</c:when>
                <c:otherwise>${error}</c:otherwise>
            </c:choose>
        </p>
    </c:if>
    <form method="post" action="/admin/staff/new" enctype="multipart/form-data" class="portal-form">
        <div class="form-group">
            <label>이름 *</label>
            <input type="text" name="name" value="${profile.name}" required>
        </div>
        <div class="form-group">
            <label>직급/역할 *</label>
            <input type="text" name="position" value="${profile.position}" required placeholder="예: 대표이사, 작곡가, 보컬 디렉터">
        </div>
        <div class="form-group">
            <label>사진 (JPG, PNG / 최대 10MB)</label>
            <input type="file" name="photo" accept="image/jpeg,image/png">
        </div>
        <div class="form-group">
            <label>한 줄 소개</label>
            <input type="text" name="bio" value="${profile.bio}" placeholder="예: 아이들의 목소리를 가장 잘 이해하는 작곡가">
        </div>
        <div class="form-group">
            <label>경력</label>
            <textarea name="career" rows="6" placeholder="한 줄에 하나씩 입력하면 그대로 줄바꿈되어 표시됩니다.">${profile.career}</textarea>
        </div>
        <div class="form-group">
            <label>대표 작업물</label>
            <textarea name="portfolio" rows="6" placeholder="한 줄에 하나씩 입력하면 그대로 줄바꿈되어 표시됩니다.">${profile.portfolio}</textarea>
        </div>
        <div class="btn-group">
            <a href="/admin/staff" class="btn-secondary">취소</a>
            <button type="submit" class="btn-primary">등록</button>
        </div>
    </form>
</div>
</main>
</body>
</html>
