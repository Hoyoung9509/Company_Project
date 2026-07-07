package com.company.homepage.controller.portal;

import com.company.homepage.common.util.SessionUtil;
import com.company.homepage.service.UserService;
import com.company.homepage.vo.UserVo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
public class ProfileController {

    private final UserService userService;

    @GetMapping("/portal/profile")
    public String profile(HttpSession session, Model model) {
        UserVo loginUser = SessionUtil.getLoginUser(session);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("user", userService.getUserById(loginUser.getId()));
        return "portal/profile";
    }

    @PostMapping("/portal/profile")
    public String update(@ModelAttribute UserVo form, HttpSession session) {
        UserVo loginUser = SessionUtil.getLoginUser(session);
        form.setId(loginUser.getId());
        userService.updateProfile(form);
        UserVo updated = userService.getUserById(loginUser.getId());
        updated.setPasswordHash(null);
        session.setAttribute("loginUser", updated);
        return "redirect:/portal/profile?updated=1";
    }
}