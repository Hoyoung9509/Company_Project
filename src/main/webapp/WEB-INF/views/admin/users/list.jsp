<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>계정 관리 - 어드민</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/style.css?v=7"></head>
<body class="admin-body">
<%@ include file="/WEB-INF/views/common/admin-nav.jsp" %>
<main class="portal-main">
<div class="portal-content">
    <div class="page-header">
        <h2 class="page-title">계정 관리</h2>
        <a href="/admin/users/new" class="btn-primary">계정 생성</a>
    </div>
    <table class="data-table">
        <thead><tr><th>사원번호</th><th>이름</th><th>부서</th><th>직급</th><th>역할</th><th>상태</th><th>관리</th></tr></thead>
        <tbody>
        <c:forEach var="u" items="${users}">
            <tr>
                <td>${u.employeeId}</td>
                <td>${u.name}</td>
                <td>${u.department}</td>
                <td>${u.position}</td>
                <td>
                    <form method="post" action="/admin/users/${u.id}/role" class="inline-form">
                        <select name="role" onchange="this.form.submit()">
                            <option value="EMPLOYEE" ${u.role=='EMPLOYEE'?'selected':''}>사원</option>
                            <option value="MANAGER"  ${u.role=='MANAGER' ?'selected':''}>팀장</option>
                            <option value="ADMIN"    ${u.role=='ADMIN'   ?'selected':''}>관리자</option>
                        </select>
                    </form>
                </td>
                <td><span class="badge ${u.isActive==1?'badge-APPROVED':'badge-REJECTED'}">${u.isActive==1?'활성':'비활성'}</span></td>
                <td style="display:flex;gap:6px;flex-wrap:wrap;">
                    <a href="/admin/users/${u.id}/edit" class="btn-sm btn-secondary">수정</a>
                    <c:choose>
                        <c:when test="${u.isActive == 1}">
                            <form method="post" action="/admin/users/${u.id}/deactivate" style="display:inline">
                                <button type="submit" class="btn-sm btn-danger">비활성화</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <form method="post" action="/admin/users/${u.id}/activate" style="display:inline">
                                <button type="submit" class="btn-sm btn-secondary">활성화</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</main>
</body>
</html>