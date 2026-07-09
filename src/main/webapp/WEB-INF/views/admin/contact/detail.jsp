<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>문의 상세 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=6"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <h2 class="page-title">문의 상세</h2>
    <table class="data-table detail-table">
        <tr><th style="width:120px">번호</th><td>${contact.id}</td></tr>
        <tr><th>접수일</th><td>${contact.createdAt}</td></tr>
        <tr><th>이름</th><td>${contact.name}</td></tr>
        <tr><th>이메일</th><td>${contact.email}</td></tr>
        <tr><th>연락처</th><td>${contact.phone}</td></tr>
        <tr><th>제목</th><td>${contact.title}</td></tr>
        <tr>
            <th>내용</th>
            <td style="white-space:pre-wrap;word-break:break-all;min-height:120px;">${contact.message}</td>
        </tr>
    </table>
    <div style="margin-top:16px;display:flex;gap:8px;">
        <a href="/admin/contacts" class="btn-sm btn-secondary">목록으로</a>
        <form method="post" action="/admin/contacts/${contact.id}/delete" style="display:inline"
              onsubmit="return confirm('삭제하면 복구할 수 없습니다. 계속하시겠습니까?')">
            <button type="submit" class="btn-sm btn-danger">삭제</button>
        </form>
    </div>
</div>
</main>
</body>
</html>
