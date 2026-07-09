<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>검색 - JuniMusic</title>
    <link rel="stylesheet" href="/resources/css/style.css?v=9">
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="page-banner">
    <h1>통합 검색</h1>
    <p>뉴스, 채용, 서비스 정보를 검색합니다</p>
</section>

<div class="section">
    <form action="/search" method="get" class="search-form">
        <div class="search-input-wrap">
            <input type="text" name="q" value="${q}" placeholder="검색어를 입력하세요" autofocus>
            <button type="submit">검색</button>
        </div>
    </form>

    <c:if test="${not empty q}">
        <p class="search-meta">
            "<strong>${q}</strong>" 검색 결과
            <c:choose>
                <c:when test="${not empty results}"> — ${results.size()}건</c:when>
                <c:otherwise> — 0건</c:otherwise>
            </c:choose>
        </p>
        <c:choose>
            <c:when test="${empty results}">
                <p class="empty-msg">검색 결과가 없습니다.</p>
            </c:when>
            <c:otherwise>
                <div class="search-results">
                    <c:forEach var="item" items="${results}">
                        <div class="search-item">
                            <div class="search-item-header">
                                <span class="badge badge-type">
                                    <c:choose>
                                        <c:when test="${item.type == 'NOTICE_PUBLIC'}">뉴스</c:when>
                                        <c:when test="${item.type == 'CAREER'}">채용</c:when>
                                        <c:when test="${item.type == 'SERVICE'}">서비스</c:when>
                                        <c:otherwise>${item.type}</c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="search-date">${item.createdAt}</span>
                            </div>
                            <h3 class="search-title">
                                <c:choose>
                                    <c:when test="${item.type == 'NOTICE_PUBLIC'}">
                                        <a href="/news/${item.id}">${item.title}</a>
                                    </c:when>
                                    <c:when test="${item.type == 'CAREER'}">
                                        <a href="/careers/${item.id}">${item.title}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/services">${item.title}</a>
                                    </c:otherwise>
                                </c:choose>
                            </h3>
                            <p class="search-excerpt">${item.body}</p>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>