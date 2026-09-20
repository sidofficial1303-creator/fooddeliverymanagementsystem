package com.jsp.fdms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.jsp.fdms.entity.Users;
import com.jsp.fdms.service.UserService;

@Controller
public class UserController {

    @Autowired
    private UserService service;

    @GetMapping("/")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(Users user, Model model) {

        user.setRole("USER");

        if (service.register(user)) {
            model.addAttribute("msg", "Registration successful. Please login.");
        } else {
            model.addAttribute("msg", "Email already registered. Please use another email.");
        }

        return "login";
    }

    @GetMapping("/home")
    public String home() {
        return "home";
    }
}
