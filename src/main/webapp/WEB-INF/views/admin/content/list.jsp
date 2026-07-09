<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>콘텐츠 관리 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=6"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <div class="page-header">
        <h2 class="page-title">콘텐츠 관리</h2>
        <a href="/admin/content/new" class="btn-primary">+ 새 콘텐츠 등록</a>
    </div>

    <c:forEach var="group" items="${groupedContent}">
        <form id="bulkDeleteForm_${group.key}" method="post" action="/admin/content/bulk-delete"
              onsubmit="return confirm('선택한 게시물을 삭제하면 복구할 수 없습니다. 계속하시겠습니까?')"></form>

        <h3 class="content-group-title">
            ${group.value[0].typeLabel}
            <span class="content-group-count">${fn:length(group.value)}건</span>
            <button type="submit" form="bulkDeleteForm_${group.key}" id="bulkDeleteBtn_${group.key}"
                    class="btn-sm btn-danger" style="display:none;margin-left:auto;">선택삭제</button>
        </h3>
        <table class="data-table">
            <thead>
            <tr>
                <th><input type="checkbox" onclick="toggleGroupCheckboxes(this, '${group.key}')" style="width:auto;"></th>
                <th>제목</th>
                <th>공개</th>
                <th>등록일</th>
                <th>관리</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="c" items="${group.value}">
                <tr>
                    <td><input type="checkbox" name="ids" value="${c.id}" form="bulkDeleteForm_${group.key}" class="content-checkbox-${group.key}" onchange="updateBulkDeleteButton('${group.key}')" style="width:auto;"></td>
                    <td class="title-cell" title="${c.title}">${c.title}</td>
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

<script>
function toggleGroupCheckboxes(master, type) {
    document.querySelectorAll('.content-checkbox-' + type).forEach(function (cb) {
        cb.checked = master.checked;
    });
    updateBulkDeleteButton(type);
}

function updateBulkDeleteButton(type) {
    var anyChecked = Array.prototype.some.call(
        document.querySelectorAll('.content-checkbox-' + type),
        function (cb) { return cb.checked; }
    );
    var btn = document.getElementById('bulkDeleteBtn_' + type);
    if (btn) btn.style.display = anyChecked ? '' : 'none';
}
</script>
</main>
</body>
</html>
