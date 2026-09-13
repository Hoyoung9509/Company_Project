<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제작과정 - JuniMusic</title>
    <link rel="stylesheet" href="/resources/css/style.css?v=37">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="page-banner">
    <h1>제작과정</h1>
    <p>JuniMusic의 체계적인 동요 제작 프로세스</p>
</section>

<c:choose>
    <c:when test="${empty processSteps}">
        <div class="section">
            <p class="empty-msg">등록된 제작과정이 없습니다.</p>
        </div>
    </c:when>
    <c:otherwise>
        <section class="process-band">
            <div class="process-steps">
                <c:forEach var="s" items="${processSteps}" varStatus="loop">
                    <div class="process-step">
                        <span class="process-step-index"><c:if test="${loop.index < 9}">0</c:if>${loop.index + 1}</span>
                        <h3>${s.title}</h3>
                        <p>${s.description}</p>
                    </div>
                    <c:if test="${not loop.last}">
                        <span class="process-arrow">&#8594;</span>
                    </c:if>
                </c:forEach>
            </div>
        </section>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>
