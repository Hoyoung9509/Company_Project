package com.company.homepage.controller.admin;

import com.company.homepage.common.util.SessionUtil;
import com.company.homepage.service.AuditLogService;
import com.company.homepage.service.CompanyHistoryService;
import com.company.homepage.vo.CompanyHistoryVo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/history")
public class AdminCompanyHistoryController {

    private final CompanyHistoryService companyHistoryService;
    private final AuditLogService auditLogService;

    @GetMapping
    public String list(HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("historyList", companyHistoryService.getAll());
        return "admin/history/list";
    }

    @PostMapping("/new")
    public String create(@ModelAttribute CompanyHistoryVo history, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        companyHistoryService.create(history);
        auditLogService.log(adminId, "HISTORY_CREATE", "COMPANY_HISTORY", history.getId(), null, history.getYear());
        return "redirect:/admin/history";
    }

    @PostMapping("/{id}/edit")
    public String edit(@PathVariable String id, @ModelAttribute CompanyHistoryVo history, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        CompanyHistoryVo before = companyHistoryService.getById(id);
        history.setId(id);
        companyHistoryService.update(history);
        auditLogService.log(adminId, "HISTORY_UPDATE", "COMPANY_HISTORY", id, before.getYear(), history.getYear());
        return "redirect:/admin/history";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        CompanyHistoryVo target = companyHistoryService.getById(id);
        companyHistoryService.delete(id);
        auditLogService.log(adminId, "HISTORY_DELETE", "COMPANY_HISTORY", id, target.getYear(), null);
        return "redirect:/admin/history";
    }

    @PostMapping("/{id}/move-up")
    public String moveUp(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        companyHistoryService.moveUp(id);
        auditLogService.log(adminId, "HISTORY_REORDER", "COMPANY_HISTORY", id, null, "up");
        return "redirect:/admin/history";
    }

    @PostMapping("/{id}/move-down")
    public String moveDown(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        companyHistoryService.moveDown(id);
        auditLogService.log(adminId, "HISTORY_REORDER", "COMPANY_HISTORY", id, null, "down");
        return "redirect:/admin/history";
    }
}
