package com.company.homepage.controller;

import com.company.homepage.service.ContentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class PublicController {

    private final ContentService contentService;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("companyName", "회사 홈페이지");
        model.addAttribute("contentList", contentService.getPublishedContents());
        return "public/index";
    }
}