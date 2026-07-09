<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작업물 - JuniMusic</title>
    <link rel="stylesheet" href="/resources/css/style.css?v=10">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<% if (_loginUser != null && "ADMIN".equals(_loginUser.getRole())) { %>
<a href="/admin/content/new?type=WORK&redirectTo=/works" class="fab-add" title="작업물 등록">+</a>
<% } %>

<section class="page-banner">
    <h1>작업물</h1>
    <p>JuniMusic이 만든 동요와 영상을 소개합니다</p>
</section>

<div class="section">
    <c:choose>
        <c:when test="${empty contentList}">
            <p class="empty-msg">등록된 작업물이 없습니다.</p>
        </c:when>
        <c:otherwise>
            <div class="work-list">
                <c:forEach var="item" items="${contentList}">
                    <div class="work-card">
                        <c:choose>
                            <c:when test="${not empty item.youtubeId}">
                                <div class="work-thumb work-thumb-video" data-youtube-id="${item.youtubeId}"
                                     style="background-image:url('https://img.youtube.com/vi/${item.youtubeId}/hqdefault.jpg');"
                                     onclick="juniPlayInlineVideo(this)" role="button" tabindex="0"
                                     aria-label="영상 재생">
                                    <span class="play-icon">▶</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="work-thumb"><span class="play-icon">▶</span></div>
                            </c:otherwise>
                        </c:choose>
                        <div class="work-info">
                            <h3><a href="/works/${item.id}" class="work-title-link">${item.title}</a></h3>
                            <p>${item.body}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <c:forEach begin="1" end="${totalPages}" var="p">
                <a href="/works?page=${p}" class="page-link${p == currentPage ? ' active' : ''}">${p}</a>
            </c:forEach>
        </div>
    </c:if>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>
function juniPlayInlineVideo(el) {
    var id = el.getAttribute('data-youtube-id');
    var iframe = document.createElement('iframe');
    iframe.src = 'https://www.youtube.com/embed/' + id + '?autoplay=1';
    iframe.setAttribute('allow', 'autoplay; encrypted-media; picture-in-picture');
    iframe.setAttribute('allowfullscreen', '');
    iframe.style.width = '100%';
    iframe.style.height = '100%';
    iframe.style.border = '0';
    el.classList.remove('work-thumb-video');
    el.removeAttribute('onclick');
    el.removeAttribute('role');
    el.removeAttribute('tabindex');
    el.innerHTML = '';
    el.appendChild(iframe);
}
</script>

</body>
</html>
