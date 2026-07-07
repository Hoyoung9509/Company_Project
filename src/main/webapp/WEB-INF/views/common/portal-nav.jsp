<%@ page pageEncoding="UTF-8" %>
<div class="sidebar">
    <div class="sidebar-logo"><a href="/portal">Company</a></div>
    <nav class="sidebar-nav">
        <a href="/portal">대시보드</a>
        <a href="/portal/notice">공지사항</a>
        <a href="/portal/approval">결재함</a>
        <a href="/portal/directory">조직도</a>
        <a href="/portal/profile">내 정보</a>
    </nav>
    <div class="sidebar-footer">
        <span class="user-name">${loginUser.name}</span>
        <div class="sidebar-links">
            <% if ("ADMIN".equals(((com.company.homepage.vo.UserVo)session.getAttribute("loginUser")).getRole())) { %>
            <a href="/admin">어드민</a>
            <% } %>
            <a href="/logout">로그아웃</a>
        </div>
    </div>
</div>