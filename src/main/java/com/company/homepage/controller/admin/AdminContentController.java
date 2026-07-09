package com.company.homepage.controller.admin;

import com.company.homepage.common.util.SessionUtil;
import com.company.homepage.service.AuditLogService;
import com.company.homepage.service.ContentService;
import com.company.homepage.vo.ContentVo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class AdminContentController {

    private static final String[] TYPE_ORDER = {"SERVICE", "WORK", "CAREER", "NOTICE_PUBLIC", "NOTICE_INTERNAL", "ABOUT"};

    private final ContentService contentService;
    private final AuditLogService auditLogService;

    @GetMapping("/admin/content")
    public String list(HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        List<ContentVo> all = contentService.getAllContents();
        Map<String, List<ContentVo>> grouped = new LinkedHashMap<>();
        for (String type : TYPE_ORDER) {
            List<ContentVo> items = all.stream()
                    .filter(c -> type.equals(c.getType()))
                    .collect(Collectors.toList());
            if (!items.isEmpty()) grouped.put(type, items);
        }
        model.addAttribute("groupedContent", grouped);
        return "admin/content/list";
    }

    @GetMapping("/admin/content/new")
    public String newForm(HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        return "admin/content/new";
    }

    @PostMapping("/admin/content/new")
    public String create(@ModelAttribute ContentVo content, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        contentService.create(content);
        auditLogService.log(adminId, "CONTENT_CREATE", "CONTENT", content.getId(), null, content.getTitle());
        return "redirect:/admin/content";
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

    @GetMapping("/admin/content/{id}/edit")
    public String editForm(@PathVariable String id, HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("content", contentService.getById(id));
        return "admin/content/edit";
    }

    @PostMapping("/admin/content/{id}/edit")
    public String edit(@PathVariable String id, @ModelAttribute ContentVo content, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        ContentVo before = contentService.getById(id);
        content.setId(id);
        contentService.update(content);
        auditLogService.log(adminId, "CONTENT_UPDATE", "CONTENT", id, before.getTitle(), content.getTitle());
        return "redirect:/admin/content";
    }

    @PostMapping("/admin/content/{id}/delete")
    public String delete(@PathVariable String id, HttpSession session) {
        String adminId = SessionUtil.getLoginUser(session).getId();
        ContentVo target = contentService.getById(id);
        contentService.delete(id);
        auditLogService.log(adminId, "CONTENT_DELETE", "CONTENT", id, target.getTitle(), null);
        return "redirect:/admin/content";
    }
}