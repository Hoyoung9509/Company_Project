<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Noto Sans KR', sans-serif; background: #f0f2f5;
               display: flex; justify-content: center; align-items: center; height: 100vh; }

        .login-box { background: #fff; border-radius: 10px; padding: 48px 40px;
                     width: 380px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }

        .login-box h1 { font-size: 1.5rem; color: #1a1a2e; margin-bottom: 8px; text-align: center; }
        .login-box p  { font-size: 13px; color: #999; text-align: center; margin-bottom: 32px; }

        .form-group { margin-bottom: 16px; }
        .form-group label { display: block; font-size: 13px; color: #555; margin-bottom: 6px; }
        .form-group input {
            width: 100%; padding: 11px 14px; border: 1px solid #ddd;
            border-radius: 6px; font-size: 14px; outline: none;
        }
        .form-group input:focus { border-color: #1a1a2e; }

        .error-msg { color: #e53e3e; font-size: 13px; margin-bottom: 16px; text-align: center; }

        .btn-login {
            width: 100%; padding: 12px; background: #1a1a2e; color: #fff;
            border: none; border-radius: 6px; font-size: 15px; cursor: pointer;
            margin-top: 8px;
        }
        .btn-login:hover { background: #2d2d4e; }
    </style>
</head>
<body>

<div class="login-box">
    <h1>Company</h1>
    <p>사원번호와 비밀번호를 입력하세요</p>

    <% if (request.getAttribute("error") != null) { %>
        <p class="error-msg">${error}</p>
    <% } %>

    <form method="post" action="/login">
        <div class="form-group">
            <label>사원번호</label>
            <input type="text" name="employeeId" placeholder="사원번호 입력" required>
        </div>
        <div class="form-group">
            <label>비밀번호</label>
            <input type="password" name="password" placeholder="비밀번호 입력" required>
        </div>
        <button type="submit" class="btn-login">로그인</button>
    </form>
</div>

</body>
</html>