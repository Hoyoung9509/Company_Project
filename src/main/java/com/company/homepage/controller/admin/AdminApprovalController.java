package com.company.homepage.controller.admin;

import com.company.homepage.common.util.SessionUtil;
import com.company.homepage.service.ApprovalService;
import com.company.homepage.service.AuditLogService;
import com.company.homepage.vo.ApprovalVo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class AdminApprovalController {

    private final ApprovalService approvalService;
    private final AuditLogService auditLogService;

    @GetMapping("/admin/approvals")
    public String list(HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("approvals", approvalService.getAllApprovals());
        return "admin/approval/list";
    }

    @GetMapping("/admin/approvals/{id}")
    public String detail(@PathVariable String id, HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("approval", approvalService.getById(id));
        return "admin/approval/detail";
    }

    @PostMapping("/admin/approvals/{id}/override")
    public String override(@PathVariable String id,
                           @RequestParam String status,
                           @RequestParam(required = false) String comment,
                           HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        ApprovalVo before = approvalService.getById(id);
        approvalService.adminOverride(id, adminId, status, comment);
        auditLogService.log(adminId, "APPROVAL_OVERRIDE", "APPROVAL", id, before.getStatus(), status);
        return "redirect:/admin/approvals/" + id;
    }
}