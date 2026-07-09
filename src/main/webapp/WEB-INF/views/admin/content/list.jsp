<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>콘텐츠 관리 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=4"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <h2 class="page-title">콘텐츠 관리</h2>

    <c:forEach var="group" items="${groupedContent}">
        <h3 class="content-group-title">
            ${group.value[0].typeLabel}
            <span class="content-group-count">${fn:length(group.value)}건</span>
        </h3>
        <table class="data-table">
            <thead><tr><th>제목</th><th>공개</th><th>등록일</th><th>관리</th></tr></thead>
            <tbody>
            <c:forEach var="c" items="${group.value}">
                <tr>
                    <td>${c.title}</td>
                    <td><span class="badge ${c.isPublished==1?'badge-APPROVED':'badge-REJECTED'}">${c.isPublished==1?'공개':'비공개'}</span></td>
                    <td>${c.createdAt}</td>
                    <td style="display:flex;gap:6px;flex-wrap:wrap;">
                        <c:choose>
                            <c:when test="${c.isPublished == 1}">
                                <form method="post" action="/admin/content/${c.id}/unpublish" style="display:inline">
                                    <button type="submit" class="btn-sm btn-secondary">비공개</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <form method="post" action="/admin/content/${c.id}/publish" style="display:inline">
                                    <button type="submit" class="btn-sm btn-primary">공개</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                        <a href="/admin/content/${c.id}/edit" class="btn-sm btn-secondary">수정</a>
                        <form method="post" action="/admin/content/${c.id}/delete" style="display:inline"
                              onsubmit="return confirm('삭제하면 복구할 수 없습니다. 계속하시겠습니까?')">
                            <button type="submit" class="btn-sm btn-danger">삭제</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:forEach>
</div>
</main>
</body>
</html>
