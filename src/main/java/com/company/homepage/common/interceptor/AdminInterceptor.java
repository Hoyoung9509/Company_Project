package com.company.homepage.common.interceptor;

import com.company.homepage.common.util.SessionUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AdminInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (!SessionUtil.isAdmin(request.getSession(false))) {
            response.sendError(403, "접근 권한이 없습니다.");
            return false;
        }
        return true;
    }
}