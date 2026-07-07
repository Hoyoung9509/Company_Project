package com.company.homepage.controller.portal;

import com.company.homepage.common.util.SessionUtil;
import com.company.homepage.service.ContentService;
import com.company.homepage.vo.ContentVo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
@RequiredArgsConstructor
public class NoticeController {

    private final ContentService contentService;

    @GetMapping("/portal/notice")
    public String list(HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("notices", contentService.getContentsByType("NOTICE_INTERNAL"));
        return "portal/notice/list";
    }

    @GetMapping("/portal/notice/{id}")
    public String detail(@PathVariable String id, HttpSession session, Model model) {
        ContentVo notice = contentService.getById(id);
        if (notice == null) return "redirect:/portal/notice";
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("notice", notice);
        return "portal/notice/detail";
    }
}