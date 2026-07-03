package com.company.homepage.controller.portal;

import com.company.homepage.service.LoginService;
import com.company.homepage.vo.UserVo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class LoginController {

    private final LoginService loginService;

    @GetMapping("/login")
    public String loginForm() {
        return "auth/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String employeeId,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {
        UserVo user = loginService.login(employeeId, password);
        if (user == null) {
            model.addAttribute("error", "아이디 또는 비밀번호가 틀렸습니다.");
            return "auth/login";
        }
        session.setAttribute("loginUser", user);
        return "redirect:/portal";
    }
}