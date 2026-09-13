<%@ page pageEncoding="UTF-8" %>
<div class="admin-sidebar">
    <div class="sidebar-logo"><a href="/">JuniMusic</a></div>
    <nav class="sidebar-nav">
        <a href="/admin">대시보드</a>
        <a href="/admin/users">계정 관리</a>
        <a href="/admin/content">콘텐츠 관리</a>
        <a href="/admin/work-categories">작업물 카테고리</a>
        <a href="/admin/staff">직원 프로필</a>
        <a href="/admin/process-steps">제작과정 관리</a>
        <a href="/admin/history">연혁 관리</a>
        <a href="/admin/approvals">결재 관리</a>
        <a href="/admin/contacts">문의 관리</a>
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