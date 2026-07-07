package com.company.homepage.controller.portal;

import com.company.homepage.common.util.SessionUtil;
import com.company.homepage.service.ApprovalService;
import com.company.homepage.vo.ApprovalVo;
import com.company.homepage.vo.UserVo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class ApprovalController {

    private final ApprovalService approvalService;

    @GetMapping("/portal/approval")
    public String list(HttpSession session, Model model) {
        UserVo user = SessionUtil.getLoginUser(session);
        model.addAttribute("loginUser", user);
        model.addAttribute("approvals", approvalService.getMyApprovals(user.getId()));
        return "portal/approval/list";
    }

    @GetMapping("/portal/approval/new")
    public String newForm(HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        return "portal/approval/new";
    }

    @PostMapping("/portal/approval/new")
    public String create(@RequestParam String title,
                         @RequestParam String content,
                         @RequestParam(required = false) String action,
                         HttpSession session) {
        UserVo user = SessionUtil.getLoginUser(session);
        ApprovalVo approval = new ApprovalVo();
        approval.setTitle(title);
        approval.setContent(content);
        approvalService.create(approval, user.getId());
        if ("submit".equals(action)) {
            approvalService.submit(approval.getId(), user.getId());
        }
        return "redirect:/portal/approval";
    }

    @GetMapping("/portal/approval/{id}")
    public String detail(@PathVariable String id, HttpSession session, Model model) {
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        model.addAttribute("approval", approvalService.getById(id));
        return "portal/approval/detail";
    }

    @PostMapping("/portal/approval/{id}/submit")
    public String submit(@PathVariable String id, HttpSession session) {
        approvalService.submit(id, SessionUtil.getLoginUser(session).getId());
        return "redirect:/portal/approval/" + id;
    }

    @PostMapping("/portal/approval/{id}/approve")
    public String approve(@PathVariable String id,
                          @RequestParam(required = false) String comment,
                          HttpSession session) {
        approvalService.approve(id, SessionUtil.getLoginUser(session).getId(), comment);
        return "redirect:/portal/approval/" + id;
    }

    @PostMapping("/portal/approval/{id}/reject")
    public String reject(@PathVariable String id,
                         @RequestParam(required = false) String comment,
                         HttpSession session) {
        approvalService.reject(id, SessionUtil.getLoginUser(session).getId(), comment);
        return "redirect:/portal/approval/" + id;
    }

    @PostMapping("/portal/approval/{id}/resubmit")
    public String resubmit(@PathVariable String id, HttpSession session) {
        approvalService.resubmit(id, SessionUtil.getLoginUser(session).getId());
        return "redirect:/portal/approval/" + id;
    }
}