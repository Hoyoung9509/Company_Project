package com.company.homepage.controller.admin;

import com.company.homepage.common.util.SessionUtil;
import com.company.homepage.service.AuditLogService;
import com.company.homepage.service.UserService;
import com.company.homepage.vo.UserVo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class AdminUserController {

    private final UserService userService;
    private final AuditLogService auditLogService;

    @GetMapping("/admin/users")
    public String list(HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("users", userService.getAllUsers());
        return "admin/users/list";
    }

    @GetMapping("/admin/users/new")
    public String newForm(HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        return "admin/users/new";
    }

    @PostMapping("/admin/users/new")
    public String create(@ModelAttribute UserVo user, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        userService.createUser(user);
        auditLogService.log(adminId, "USER_CREATE", "USER", user.getEmployeeId(), null, user.getName());
        return "redirect:/admin/users";
    }

    @PostMapping("/admin/users/{id}/role")
    public String updateRole(@PathVariable String id, @RequestParam String role, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        UserVo target = userService.getUserById(id);
        userService.updateRole(id, role);
        auditLogService.log(adminId, "ROLE_CHANGE", "USER", id, target.getRole(), role);
        return "redirect:/admin/users";
    }

    @PostMapping("/admin/users/{id}/deactivate")
    public String deactivate(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        userService.setActive(id, false);
        auditLogService.log(adminId, "DEACTIVATE", "USER", id, "active", "inactive");
        return "redirect:/admin/users";
    }

    @PostMapping("/admin/users/{id}/activate")
    public String activate(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        userService.setActive(id, true);
        auditLogService.log(adminId, "ACTIVATE", "USER", id, "inactive", "active");
        return "redirect:/admin/users";
    }

    @GetMapping("/admin/users/{id}/edit")
    public String editForm(@PathVariable String id, HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("target", userService.getUserById(id));
        return "admin/users/edit";
    }

    @PostMapping("/admin/users/{id}/edit")
    public String edit(@PathVariable String id, @ModelAttribute UserVo form, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        UserVo before = userService.getUserById(id);
        form.setId(id);
        userService.adminUpdate(form);
        auditLogService.log(adminId, "USER_UPDATE", "USER", id, before.getPosition(), form.getPosition());
        return "redirect:/admin/users";
    }
}