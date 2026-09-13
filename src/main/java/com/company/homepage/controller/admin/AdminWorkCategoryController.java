package com.company.homepage.controller.admin;

import com.company.homepage.common.util.SessionUtil;
import com.company.homepage.service.AuditLogService;
import com.company.homepage.service.WorkCategoryService;
import com.company.homepage.vo.WorkCategoryVo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/work-categories")
public class AdminWorkCategoryController {

    private final WorkCategoryService workCategoryService;
    private final AuditLogService auditLogService;

    @GetMapping
    public String list(HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("categories", workCategoryService.getAll());
        return "admin/work-categories/list";
    }

    @PostMapping("/new")
    public String create(@ModelAttribute WorkCategoryVo category, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        workCategoryService.create(category);
        auditLogService.log(adminId, "WORK_CATEGORY_CREATE", "WORK_CATEGORY", category.getId(), null, category.getName());
        return "redirect:/admin/work-categories";
    }

    @PostMapping("/{id}/edit")
    public String edit(@PathVariable String id, @ModelAttribute WorkCategoryVo category, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        WorkCategoryVo before = workCategoryService.getById(id);
        category.setId(id);
        workCategoryService.update(category);
        auditLogService.log(adminId, "WORK_CATEGORY_UPDATE", "WORK_CATEGORY", id, before.getName(), category.getName());
        return "redirect:/admin/work-categories";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        WorkCategoryVo target = workCategoryService.getById(id);
        workCategoryService.delete(id);
        auditLogService.log(adminId, "WORK_CATEGORY_DELETE", "WORK_CATEGORY", id, target.getName(), null);
        return "redirect:/admin/work-categories";
    }

    @PostMapping("/{id}/move-up")
    public String moveUp(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        workCategoryService.moveUp(id);
        auditLogService.log(adminId, "WORK_CATEGORY_REORDER", "WORK_CATEGORY", id, null, "up");
        return "redirect:/admin/work-categories";
    }

    @PostMapping("/{id}/move-down")
    public String moveDown(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        workCategoryService.moveDown(id);
        auditLogService.log(adminId, "WORK_CATEGORY_REORDER", "WORK_CATEGORY", id, null, "down");
        return "redirect:/admin/work-categories";
    }
}
