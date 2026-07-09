<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>계정 생성 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=5"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <a href="/admin/users" class="back-link">← 계정 관리로</a>
    <h2 class="page-title">계정 생성</h2>
    <form method="post" action="/admin/users/new" class="portal-form">
        <div class="form-group"><label>사원번호 *</label><input type="text" name="employeeId" required></div>
        <div class="form-group"><label>이름 *</label><input type="text" name="name" required></div>
        <div class="form-group"><label>이메일 *</label><input type="email" name="email" required></div>
        <div class="form-group"><label>임시 비밀번호 *</label><input type="text" name="passwordHash" required placeholder="초기 비밀번호"></div>
        <div class="form-group"><label>부서</label><input type="text" name="department"></div>
        <div class="form-group"><label>직급</label><input type="text" name="position"></div>
        <div class="form-group"><label>연락처</label><input type="tel" name="phone"></div>
        <div class="form-group"><label>역할</label>
            <select name="role">
                <option value="EMPLOYEE">EMPLOYEE</option>
                <option value="MANAGER">MANAGER</option>
                <option value="ADMIN">ADMIN</option>
            </select>
        </div>
        <button type="submit" class="btn-primary">생성</button>
    </form>
</div>
</main>
</body>
</html>