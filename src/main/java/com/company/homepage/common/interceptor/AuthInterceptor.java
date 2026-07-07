package com.company.homepage.common.interceptor;

import com.company.homepage.common.util.SessionUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AuthInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (!SessionUtil.isLoggedIn(request.getSession(false))) {
            response.sendRedirect("/login?redirect=" + request.getRequestURI());
            return false;
        }
        return true;
    }
}