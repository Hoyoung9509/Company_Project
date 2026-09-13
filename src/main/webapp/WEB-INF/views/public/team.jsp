<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팀 소개 - JuniMusic</title>
    <link rel="stylesheet" href="/resources/css/style.css?v=37">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="page-banner">
    <h1>팀 소개</h1>
    <p>JuniMusic을 만들어가는 사람들을 소개합니다</p>
</section>

<div class="section">
    <c:choose>
        <c:when test="${empty profiles}">
            <p class="empty-msg">등록된 프로필이 없습니다.</p>
        </c:when>
        <c:otherwise>
            <div class="staff-list">
                <c:forEach var="p" items="${profiles}">
                    <div class="staff-card">
                        <a href="/team/${p.id}" class="staff-photo-link">
                            <c:choose>
                                <c:when test="${not empty p.photoUrl}">
                                    <div class="staff-photo" style="background-image:url('${p.photoUrl}');"></div>
                                </c:when>
                                <c:otherwise>
                                    <div class="staff-photo"></div>
                                </c:otherwise>
                            </c:choose>
                        </a>
                        <div class="staff-info">
                            <h3><a href="/team/${p.id}" class="staff-name-link">${p.name}</a></h3>
                            <p class="staff-position">${p.position}</p>
                            <c:if test="${not empty p.bio}">
                                <p class="staff-bio">${p.bio}</p>
                            </c:if>
                            <c:if test="${not empty p.career}">
                                <div class="staff-detail">
                                    <strong>경력</strong>
                                    <p class="staff-multiline">${p.career}</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty p.portfolio}">
                                <div class="staff-detail">
                                    <strong>대표 작업물</strong>
                                    <p class="staff-multiline">${p.portfolio}</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>
