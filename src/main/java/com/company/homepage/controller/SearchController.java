package com.company.homepage.controller;

import com.company.homepage.service.ElasticsearchSyncService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class SearchController {

    private final ElasticsearchSyncService esSyncService;

    @GetMapping("/search")
    public String search(@RequestParam(defaultValue = "") String q, Model model) {
        model.addAttribute("q", q);
        if (!q.isBlank()) {
            model.addAttribute("results", esSyncService.search(q, false));
        }
        return "public/search";
    }
}
