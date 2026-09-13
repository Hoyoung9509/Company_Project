<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>문의 관리 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=37"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <h2 class="page-title">문의 관리</h2>
    <table class="data-table">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>이름</th>
                <th>이메일</th>
                <th>연락처</th>
                <th>접수일</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${empty contactList}">
                <tr><td colspan="7" style="text-align:center;color:#888;">접수된 문의가 없습니다.</td></tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="c" items="${contactList}">
                    <tr>
                        <td>${c.id}</td>
                        <td><a href="/admin/contacts/${c.id}">${c.title}</a></td>
                        <td>${c.name}</td>
                        <td>${c.email}</td>
                        <td>${c.phone}</td>
                        <td>${c.createdAt}</td>
                        <td>
                            <form method="post" action="/admin/contacts/${c.id}/delete" style="display:inline"
                                  onsubmit="return confirm('삭제하면 복구할 수 없습니다. 계속하시겠습니까?')">
                                <button type="submit" class="btn-sm btn-danger">삭제</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</div>
</main>
</body>
</html>
