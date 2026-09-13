<%@ page pageEncoding="UTF-8" %>
<%
    com.company.homepage.vo.UserVo _loginUser =
        (com.company.homepage.vo.UserVo) session.getAttribute("loginUser");
    String _uri = (String) request.getAttribute("jakarta.servlet.forward.request_uri");
    if (_uri == null) {
        _uri = request.getRequestURI();
    }
%>
<header>
    <nav>
        <a href="/"><strong>JuniMusic</strong></a>
        <a href="/about">회사소개</a>
        <a href="/team">팀 소개</a>
        <a href="/services">서비스</a>
        <a href="/process">제작과정</a>
        <a href="/works">작업물</a>
        <a href="/careers">채용</a>
        <a href="/news">뉴스</a>
        <a href="/contact">문의</a>
        <% if (_loginUser != null) { %>
            <a href="/portal" class="login">포털</a>
            <a href="/logout" class="login">로그아웃</a>
        <% } else { %>
            <a href="/login" class="login">로그인</a>
        <% } %>
    </nav>
</header>
<% boolean _isAdmin = _loginUser != null && "ADMIN".equals(_loginUser.getRole());
   if (!_isAdmin && !"/contact".equals(_uri)) { %>
<a href="/contact" class="fab-contact">문의하기</a>
<% } %>