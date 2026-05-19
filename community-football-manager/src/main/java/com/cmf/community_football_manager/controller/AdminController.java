package com.cmf.community_football_manager.controller;

import com.cmf.community_football_manager.model.*;
import com.cmf.community_football_manager.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private MatchRepository matchRepository;

    // UC12: Vizualizare panou administrator
    @GetMapping("/admin-dashboard")
    public String showAdminDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        // Securitate: Doar ADMIN-ul are acces [cite: 49]
        if (user == null || user.getRole() != UserRole.ADMIN) return "redirect:/login";

        model.addAttribute("users", userRepository.findAll());
        model.addAttribute("matches", matchRepository.findAll());
        return "admin-dashboard";
    }

    // UC12: Suspendare utilizator [cite: 168]
    @PostMapping("/admin/suspend-user")
    public String suspendUser(@RequestParam Long userId, @RequestParam String reason, HttpSession session) {
        User admin = (User) session.getAttribute("loggedInUser");
        if (admin == null || admin.getRole() != UserRole.ADMIN) return "redirect:/login";

        User target = userRepository.findById(userId).orElseThrow();
        target.setSuspended(true);
        target.setSuspensionReason(reason);
        userRepository.save(target);

        // Modificare aici: Fără spații (folosim plus sau underscore) și fără diacritice
        return "redirect:/admin-dashboard?success=Utilizatorul+a+fost+suspendat";
    }

    // UC12: Ridicarea suspendării unui utilizator
    @PostMapping("/admin/unsuspend-user")
    public String unsuspendUser(@RequestParam Long userId, HttpSession session) {
        User admin = (User) session.getAttribute("loggedInUser");
        if (admin == null || admin.getRole() != UserRole.ADMIN) return "redirect:/login";

        User target = userRepository.findById(userId).orElseThrow();
        target.setSuspended(false); 
        target.setSuspensionReason(null); 
        
        userRepository.save(target);

        // Modificare aici: Fără spații și diacritice în URL
        return "redirect:/admin-dashboard?success=Suspendarea+a+fost+ridicata";
    }

    // UC12: Ștergere meci neconform [cite: 168]
    @PostMapping("/admin/delete-match")
    public String deleteMatch(@RequestParam Long matchId, HttpSession session) {
        User admin = (User) session.getAttribute("loggedInUser");
        if (admin == null || admin.getRole() != UserRole.ADMIN) return "redirect:/login";

        matchRepository.deleteById(matchId);
        return "redirect:/admin-dashboard?info=Meci sters din sistem";
    }
}