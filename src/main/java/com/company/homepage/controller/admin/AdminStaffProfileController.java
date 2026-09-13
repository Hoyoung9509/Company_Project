package com.company.homepage.controller.admin;

import com.company.homepage.common.util.SessionUtil;
import com.company.homepage.service.AuditLogService;
import com.company.homepage.service.FileStorageService;
import com.company.homepage.service.StaffProfileService;
import com.company.homepage.vo.StaffProfileVo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/staff")
public class AdminStaffProfileController {

    private final StaffProfileService staffProfileService;
    private final AuditLogService auditLogService;
    private final FileStorageService fileStorageService;

    @GetMapping
    public String list(HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("profiles", staffProfileService.getAll());
        return "admin/staff/list";
    }

    @GetMapping("/new")
    public String newForm(HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        return "admin/staff/new";
    }

    @PostMapping("/new")
    public String create(@ModelAttribute StaffProfileVo profile,
                          @RequestParam(value = "photo", required = false) MultipartFile photo,
                          HttpSession session, Model model) {
        if (photo != null && !photo.isEmpty()) {
            try {
                profile.setPhotoUrl(fileStorageService.store(photo, "staff"));
            } catch (IllegalArgumentException e) {
                model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
                model.addAttribute("profile", profile);
                model.addAttribute("error", e.getMessage());
                return "admin/staff/new";
            }
        }
        String adminId = SessionUtil.getLoginUser(session).getId();
        staffProfileService.create(profile);
        auditLogService.log(adminId, "STAFF_PROFILE_CREATE", "STAFF_PROFILE", profile.getId(), null, profile.getName());
        return "redirect:/admin/staff";
    }

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable String id, HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("profile", staffProfileService.getById(id));
        return "admin/staff/edit";
    }

    @PostMapping("/{id}/edit")
    public String edit(@PathVariable String id, @ModelAttribute StaffProfileVo profile,
                        @RequestParam(value = "photo", required = false) MultipartFile photo,
                        HttpSession session, Model model) {
        StaffProfileVo before = staffProfileService.getById(id);
        if (photo != null && !photo.isEmpty()) {
            try {
                String newUrl = fileStorageService.store(photo, "staff");
                fileStorageService.delete(before.getPhotoUrl());
                profile.setPhotoUrl(newUrl);
            } catch (IllegalArgumentException e) {
                profile.setId(id);
                profile.setPhotoUrl(before.getPhotoUrl());
                model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
                model.addAttribute("profile", profile);
                model.addAttribute("error", e.getMessage());
                return "admin/staff/edit";
            }
        } else {
            profile.setPhotoUrl(before.getPhotoUrl());
        }
        String adminId = SessionUtil.getLoginUser(session).getId();
        profile.setId(id);
        staffProfileService.update(profile);
        auditLogService.log(adminId, "STAFF_PROFILE_UPDATE", "STAFF_PROFILE", id, before.getName(), profile.getName());
        return "redirect:/admin/staff";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        StaffProfileVo target = staffProfileService.getById(id);
        fileStorageService.delete(target.getPhotoUrl());
        staffProfileService.delete(id);
        auditLogService.log(adminId, "STAFF_PROFILE_DELETE", "STAFF_PROFILE", id, target.getName(), null);
        return "redirect:/admin/staff";
    }

    @PostMapping("/{id}/move-up")
    public String moveUp(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        staffProfileService.moveUp(id);
        auditLogService.log(adminId, "STAFF_PROFILE_REORDER", "STAFF_PROFILE", id, null, "up");
        return "redirect:/admin/staff";
    }

    @PostMapping("/{id}/move-down")
    public String moveDown(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        staffProfileService.moveDown(id);
        auditLogService.log(adminId, "STAFF_PROFILE_REORDER", "STAFF_PROFILE", id, null, "down");
        return "redirect:/admin/staff";
    }
}
