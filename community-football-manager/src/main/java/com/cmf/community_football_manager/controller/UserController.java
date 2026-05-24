package com.cmf.community_football_manager.controller;

import com.cmf.community_football_manager.model.User;
import com.cmf.community_football_manager.repository.UserRepository;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class UserController {

    @Autowired
    private UserRepository userRepository; 

    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        User sessionUser = (User) session.getAttribute("loggedInUser");
        if (sessionUser == null) {
            return "redirect:/login";
        }

        User user = userRepository.findById(sessionUser.getId()).orElse(sessionUser);
        model.addAttribute("user", user);
        
        return "profile";
    }

    @GetMapping("/change-password")
    public String showChangePasswordForm(HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) return "redirect:/login";
        return "change-password";
    }

    @PostMapping("/change-password")
    public String changePassword(@RequestParam String oldPassword,
                                 @RequestParam String newPassword,
                                 HttpSession session,
                                 Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/login";

        if (!loggedInUser.getPassword().equals(oldPassword)) {
            model.addAttribute("error", "Parola curentă (veche) este incorectă!");
            return "change-password";
        }

        loggedInUser.setPassword(newPassword);
        userRepository.save(loggedInUser);
        session.setAttribute("loggedInUser", loggedInUser);
        
        model.addAttribute("success", "Parola a fost schimbată cu succes!");
        return "change-password";
    }
}