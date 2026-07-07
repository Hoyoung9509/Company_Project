package com.company.homepage.controller.portal;

import com.company.homepage.common.util.SessionUtil;
import com.company.homepage.service.ApprovalService;
import com.company.homepage.service.ContentService;
import com.company.homepage.vo.UserVo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class PortalController {

    private final ContentService contentService;
    private final ApprovalService approvalService;

    @GetMapping("/portal")
    public String dashboard(HttpSession session, Model model) {
        UserVo user = SessionUtil.getLoginUser(session);
        model.addAttribute("loginUser", user);
        model.addAttribute("notices", contentService.getContentsByType("NOTICE_INTERNAL"));
        model.addAttribute("myApprovals", approvalService.getMyApprovals(user.getId()));
        return "portal/dashboard";
    }
}