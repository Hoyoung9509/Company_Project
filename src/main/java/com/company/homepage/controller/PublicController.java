package com.company.homepage.controller;

import com.company.homepage.service.ContactService;
import com.company.homepage.service.ContentService;
import com.company.homepage.vo.ContactVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
public class PublicController {

    private final ContentService contentService;
    private final ContactService contactService;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("companyName", "회사 홈페이지");
        model.addAttribute("contentList", contentService.getPublishedContents());
        return "public/index";
    }

    @GetMapping("/about")
    public String about() {
        return "public/about";
    }

    @GetMapping("/services")
    public String services(Model model) {
        model.addAttribute("contentList", contentService.getContentsByType("SERVICE"));
        return "public/services";
    }

    @GetMapping("/careers")
    public String careers(Model model) {
        model.addAttribute("contentList", contentService.getContentsByType("CAREER"));
        return "public/careers";
    }

    @GetMapping("/news")
    public String news(Model model) {
        model.addAttribute("contentList", contentService.getContentsByType("NOTICE_PUBLIC"));
        return "public/news";
    }

    @GetMapping("/contact")
    public String contactForm() {
        return "public/contact";
    }

    @PostMapping("/contact")
    public String contactSubmit(@ModelAttribute ContactVo contact, Model model) {
        if (contact.getName() == null || contact.getName().isBlank() ||
            contact.getEmail() == null || contact.getEmail().isBlank() ||
            contact.getMessage() == null || contact.getMessage().isBlank()) {
            model.addAttribute("error", "이름, 이메일, 문의 내용은 필수입니다.");
            return "public/contact";
        }
        contactService.submit(contact);
        model.addAttribute("success", "문의가 접수되었습니다. 빠른 시일 내에 연락드리겠습니다.");
        return "public/contact";
    }
}