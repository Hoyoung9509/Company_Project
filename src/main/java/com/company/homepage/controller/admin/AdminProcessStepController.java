package com.company.homepage.controller.admin;

import com.company.homepage.common.util.SessionUtil;
import com.company.homepage.service.AuditLogService;
import com.company.homepage.service.ProcessStepService;
import com.company.homepage.vo.ProcessStepVo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/process-steps")
public class AdminProcessStepController {

    private final ProcessStepService processStepService;
    private final AuditLogService auditLogService;

    @GetMapping
    public String list(HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("steps", processStepService.getAll());
        return "admin/process-steps/list";
    }

    @PostMapping("/new")
    public String create(@ModelAttribute ProcessStepVo step, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        processStepService.create(step);
        auditLogService.log(adminId, "PROCESS_STEP_CREATE", "PROCESS_STEP", step.getId(), null, step.getTitle());
        return "redirect:/admin/process-steps";
    }

    @PostMapping("/{id}/edit")
    public String edit(@PathVariable String id, @ModelAttribute ProcessStepVo step, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        ProcessStepVo before = processStepService.getById(id);
        step.setId(id);
        processStepService.update(step);
        auditLogService.log(adminId, "PROCESS_STEP_UPDATE", "PROCESS_STEP", id, before.getTitle(), step.getTitle());
        return "redirect:/admin/process-steps";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        ProcessStepVo target = processStepService.getById(id);
        processStepService.delete(id);
        auditLogService.log(adminId, "PROCESS_STEP_DELETE", "PROCESS_STEP", id, target.getTitle(), null);
        return "redirect:/admin/process-steps";
    }

    @PostMapping("/{id}/move-up")
    public String moveUp(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        processStepService.moveUp(id);
        auditLogService.log(adminId, "PROCESS_STEP_REORDER", "PROCESS_STEP", id, null, "up");
        return "redirect:/admin/process-steps";
    }

    @PostMapping("/{id}/move-down")
    public String moveDown(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        processStepService.moveDown(id);
        auditLogService.log(adminId, "PROCESS_STEP_REORDER", "PROCESS_STEP", id, null, "down");
        return "redirect:/admin/process-steps";
    }
}
