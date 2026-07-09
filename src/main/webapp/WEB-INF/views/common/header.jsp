<%@ page pageEncoding="UTF-8" %>
<%
    com.company.homepage.vo.UserVo _loginUser =
        (com.company.homepage.vo.UserVo) session.getAttribute("loginUser");
%>
<header>
    <nav>
        <a href="/"><strong>JuniMusic</strong></a>
        <a href="/about">회사소개</a>
        <a href="/services">서비스</a>
        <a href="/works">작업물</a>
        <a href="/careers">채용</a>
        <a href="/news">뉴스</a>
        <a href="/contact">문의</a>
        <form action="/search" method="get" class="header-search">
            <input type="text" name="q" placeholder="검색">
            <button type="submit">검색</button>
        </form>
        <% if (_loginUser != null) { %>
            <a href="/portal" class="login">포털</a>
            <a href="/logout" class="login">로그아웃</a>
        <% } else { %>
            <a href="/login" class="login">로그인</a>
        <% } %>
    </nav>
</header>