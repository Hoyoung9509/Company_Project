package com.company.homepage.controller.admin;

import com.company.homepage.common.util.SessionUtil;
import com.company.homepage.service.AuditLogService;
import com.company.homepage.service.ContentService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class AdminContentController {

    private final ContentService contentService;
    private final AuditLogService auditLogService;

    @GetMapping("/admin/content")
    public String list(HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("contentList", contentService.getAllContents());
        return "admin/content/list";
    }

    @PostMapping("/admin/content/{id}/publish")
    public String publish(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        contentService.setPublished(id, true);
        auditLogService.log(adminId, "PUBLISH", "CONTENT", id, "unpublished", "published");
        return "redirect:/admin/content";
    }

    @PostMapping("/admin/content/{id}/unpublish")
    public String unpublish(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        contentService.setPublished(id, false);
        auditLogService.log(adminId, "UNPUBLISH", "CONTENT", id, "published", "unpublished");
        return "redirect:/admin/content";
    }
}