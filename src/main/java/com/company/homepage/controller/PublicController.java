package com.company.homepage.controller;

import com.company.homepage.service.ContactService;
import com.company.homepage.service.ContentService;
import com.company.homepage.vo.ContactVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Collections;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class PublicController {

    private static final int WORKS_PAGE_SIZE = 9;

    private final ContentService contentService;
    private final ContactService contactService;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("companyName", "JuniMusic");
        model.addAttribute("contentList", contentService.getContentsByType("SERVICE"));
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

    @GetMapping("/works")
    public String works(@RequestParam(defaultValue = "1") int page, Model model) {
        List<com.company.homepage.vo.ContentVo> all = contentService.getContentsByType("WORK");
        int totalPages = Math.max(1, (int) Math.ceil(all.size() / (double) WORKS_PAGE_SIZE));
        int currentPage = Math.min(Math.max(page, 1), totalPages);
        int fromIndex = (currentPage - 1) * WORKS_PAGE_SIZE;
        int toIndex = Math.min(fromIndex + WORKS_PAGE_SIZE, all.size());
        List<com.company.homepage.vo.ContentVo> pageItems =
                fromIndex < all.size() ? all.subList(fromIndex, toIndex) : Collections.emptyList();
        model.addAttribute("contentList", pageItems);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        return "public/works";
    }

    @GetMapping("/works/{id}")
    public String worksDetail(@PathVariable String id, Model model) {
        model.addAttribute("content", contentService.getById(id));
        return "public/works-detail";
    }

    @GetMapping("/careers")
    public String careers(Model model) {
        model.addAttribute("contentList", contentService.getContentsByType("CAREER"));
        return "public/careers";
    }

    @GetMapping("/careers/{id}")
    public String careersDetail(@PathVariable String id, Model model) {
        model.addAttribute("content", contentService.getById(id));
        return "public/careers-detail";
    }

    @GetMapping("/news")
    public String news(Model model) {
        model.addAttribute("contentList", contentService.getContentsByType("NOTICE_PUBLIC"));
        return "public/news";
    }

    @GetMapping("/news/{id}")
    public String newsDetail(@PathVariable String id, Model model) {
        model.addAttribute("content", contentService.getById(id));
        return "public/news-detail";
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