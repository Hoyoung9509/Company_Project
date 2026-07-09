<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>포털 - JuniMusic</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=4"></head>
<body class="portal-body">
<%@ include file="/WEB-INF/views/common/portal-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <h2 class="page-title">대시보드</h2>
    <p class="page-subtitle">안녕하세요, <strong>${loginUser.name}</strong>님.</p>

    <div class="dash-grid">
        <div class="dash-card">
            <h3>최근 공지사항</h3>
            <c:choose>
                <c:when test="${empty notices}"><p class="empty-msg">공지사항이 없습니다.</p></c:when>
                <c:otherwise>
                    <ul class="dash-list">
                        <c:forEach var="n" items="${notices}" varStatus="s">
                            <c:if test="${s.index < 5}">
                            <li><a href="/portal/notice/${n.id}">${n.title}</a><span>${n.createdAt}</span></li>
                            </c:if>
                        </c:forEach>
                    </ul>
                    <a href="/portal/notice" class="more-link">전체 보기</a>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="dash-card">
            <h3>내 결재 현황</h3>
            <c:choose>
                <c:when test="${empty myApprovals}"><p class="empty-msg">결재 문서가 없습니다.</p></c:when>
                <c:otherwise>
                    <ul class="dash-list">
                        <c:forEach var="a" items="${myApprovals}" varStatus="s">
                            <c:if test="${s.index < 5}">
                            <li><a href="/portal/approval/${a.id}">${a.title}</a><span class="badge badge-${a.status}">${a.status}</span></li>
                            </c:if>
                        </c:forEach>
                    </ul>
                    <a href="/portal/approval" class="more-link">전체 보기</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</main>
</body>
</html>