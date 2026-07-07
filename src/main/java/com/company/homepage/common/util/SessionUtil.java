package com.company.homepage.common.util;

import com.company.homepage.vo.UserVo;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {
    public static UserVo getLoginUser(HttpSession session) {
        if (session == null) return null;
        return (UserVo) session.getAttribute("loginUser");
    }
    public static boolean isLoggedIn(HttpSession session) {
        return getLoginUser(session) != null;
    }
    public static boolean isAdmin(HttpSession session) {
        UserVo user = getLoginUser(session);
        return user != null && "ADMIN".equals(user.getRole());
    }
    public static boolean isManagerOrAdmin(HttpSession session) {
        UserVo user = getLoginUser(session);
        return user != null && ("ADMIN".equals(user.getRole()) || "MANAGER".equals(user.getRole()));
    }
}