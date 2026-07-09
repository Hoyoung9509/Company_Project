package com.company.homepage.controller.admin;

import com.company.homepage.service.ContactService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/contacts")
@RequiredArgsConstructor
public class AdminContactController {

    private final ContactService contactService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("contactList", contactService.findAll());
        return "admin/contact/list";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        model.addAttribute("contact", contactService.findById(id));
        return "admin/contact/detail";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) {
        contactService.delete(id);
        return "redirect:/admin/contacts";
    }
}
