package com.company.homepage.controller.portal;

import com.company.homepage.common.util.SessionUtil;
import com.company.homepage.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class DirectoryController {

    private final UserService userService;

    @GetMapping("/portal/directory")
    public String directory(HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("users", userService.getActiveUsers());
        return "portal/directory";
    }
}