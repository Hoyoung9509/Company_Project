package com.company.homepage.controller.admin;

import com.company.homepage.common.util.SessionUtil;
import com.company.homepage.service.ApprovalService;
import com.company.homepage.service.ContentService;
import com.company.homepage.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class AdminController {

    private final UserService userService;
    private final ContentService contentService;
    private final ApprovalService approvalService;

    @GetMapping("/admin")
    public String dashboard(HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("userCount", userService.getAllUsers().size());
        model.addAttribute("contentCount", contentService.getAllContents().size());
        model.addAttribute("approvalCount", approvalService.getAllApprovals().size());
        return "admin/dashboard";
    }
}