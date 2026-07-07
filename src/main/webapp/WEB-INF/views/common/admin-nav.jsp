<%@ page pageEncoding="UTF-8" %>
<div class="admin-sidebar">
    <div class="sidebar-logo"><a href="/admin">Admin</a></div>
    <nav class="sidebar-nav">
        <a href="/admin">대시보드</a>
        <a href="/admin/users">계정 관리</a>
        <a href="/admin/content">콘텐츠 관리</a>
        <a href="/admin/approvals">결재 관리</a>
        <a href="/admin/logs">감사 로그</a>
    </nav>
    <div class="sidebar-footer">
        <span class="user-name">${loginUser.name}</span>
        <div class="sidebar-links">
            <a href="/portal">포털로</a>
            <a href="/logout">로그아웃</a>
        </div>
    </div>
</div>