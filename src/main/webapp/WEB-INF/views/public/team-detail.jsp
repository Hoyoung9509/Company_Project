<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${profile.name} - 팀 소개</title>
    <link rel="stylesheet" href="/resources/css/style.css?v=37">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="page-banner">
    <h1>팀 소개</h1>
    <p>JuniMusic을 만들어가는 사람들을 소개합니다</p>
</section>

<div class="section">
    <a href="/team" class="back-link">← 목록으로</a>
    <div class="public-detail-box">
        <c:choose>
            <c:when test="${not empty profile.photoUrl}">
                <div class="staff-detail-photo" style="background-image:url('${profile.photoUrl}');"></div>
            </c:when>
            <c:otherwise>
                <div class="staff-detail-photo"></div>
            </c:otherwise>
        </c:choose>
        <h2>${profile.name}</h2>
        <p class="staff-position">${profile.position}</p>
        <c:if test="${not empty profile.bio}">
            <p class="public-detail-meta">${profile.bio}</p>
        </c:if>
        <hr>
        <c:if test="${not empty profile.career}">
            <div class="staff-detail">
                <strong>경력</strong>
                <p class="staff-multiline">${profile.career}</p>
            </div>
        </c:if>
        <c:if test="${not empty profile.portfolio}">
            <div class="staff-detail">
                <strong>대표 작업물</strong>
                <p class="staff-multiline">${profile.portfolio}</p>
            </div>
        </c:if>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>
