<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>계정 수정 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=4"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <a href="/admin/users" class="back-link">← 계정 관리로</a>
    <h2 class="page-title">계정 수정</h2>
    <form method="post" action="/admin/users/${target.id}/edit" class="portal-form">
        <div class="form-group">
            <label>사원번호</label>
            <input type="text" value="${target.employeeId}" disabled>
        </div>
        <div class="form-group">
            <label>이름</label>
            <input type="text" name="name" value="${target.name}" required>
        </div>
        <div class="form-group">
            <label>이메일</label>
            <input type="email" name="email" value="${target.email}" required>
        </div>
        <div class="form-group">
            <label>연락처</label>
            <input type="tel" name="phone" value="${target.phone}">
        </div>
        <div class="form-group">
            <label>부서</label>
            <input type="text" name="department" value="${target.department}">
        </div>
        <div class="form-group">
            <label>직급</label>
            <input type="text" name="position" value="${target.position}" placeholder="예: 대리, 팀장, 과장">
        </div>
        <div class="form-group">
            <label>역할</label>
            <select name="role">
                <option value="EMPLOYEE" ${target.role=='EMPLOYEE'?'selected':''}>사원</option>
                <option value="MANAGER"  ${target.role=='MANAGER' ?'selected':''}>팀장</option>
                <option value="ADMIN"    ${target.role=='ADMIN'   ?'selected':''}>관리자</option>
            </select>
        </div>
        <div class="btn-group">
            <a href="/admin/users" class="btn-secondary">취소</a>
            <button type="submit" class="btn-primary">저장</button>
        </div>
    </form>
</div>
</main>
</body>
</html>