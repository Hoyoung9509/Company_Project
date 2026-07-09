package com.company.homepage.controller.portal;

import com.company.homepage.common.util.SessionUtil;
import com.company.homepage.service.ElasticsearchSyncService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class PortalSearchController {

    private final ElasticsearchSyncService esSyncService;

    @GetMapping("/portal/search")
    public String search(@RequestParam(defaultValue = "") String q,
                         HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("q", q);
        if (!q.isBlank()) {
            model.addAttribute("results", esSyncService.search(q, true));
        }
        return "portal/search";
    }
}
