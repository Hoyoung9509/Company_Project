<%@ page pageEncoding="UTF-8" %>
<%
    com.company.homepage.vo.UserVo _loginUser =
        (com.company.homepage.vo.UserVo) session.getAttribute("loginUser");
%>
<header>
    <nav>
        <a href="/"><strong>Company</strong></a>
        <a href="/about">회사소개</a>
        <a href="/services">서비스</a>
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