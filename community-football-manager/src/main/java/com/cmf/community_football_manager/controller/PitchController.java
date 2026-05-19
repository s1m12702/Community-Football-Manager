package com.cmf.community_football_manager.controller;

import com.cmf.community_football_manager.model.Pitch;
import com.cmf.community_football_manager.model.User;
import com.cmf.community_football_manager.repository.PitchRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PitchController {

    @Autowired
    private PitchRepository pitchRepository;

    // Afișează formularul DOAR pentru furnizori
    @GetMapping("/add-pitch")
    public String showAddPitchForm(HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        // Dacă nu e logat SAU nu are rolul corect, îl trimitem la profil
        if (loggedInUser == null || !loggedInUser.getRole().name().equals("PITCH_PROVIDER")) {
            return "redirect:/profile"; 
        }
        return "add-pitch";
    }

    // Procesează datele terenului
    @PostMapping("/add-pitch")
    public String addPitch(@RequestParam String name,
                           @RequestParam String address,
                           @RequestParam double pricePerHour,
                           HttpSession session,
                           Model model) {
        User provider = (User) session.getAttribute("loggedInUser");
        
        if (provider != null && provider.getRole().name().equals("PITCH_PROVIDER")) {
            Pitch newPitch = new Pitch(name, address, pricePerHour, provider);
            pitchRepository.save(newPitch);
            model.addAttribute("success", "Terenul a fost adăugat cu succes în platformă!");
        }
        
        return "add-pitch";
    }

    // Afișează lista tuturor terenurilor pentru toți utilizatorii
    @GetMapping("/view-pitches")
    public String viewPitches(Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        
        // Luăm toate terenurile din DB
        model.addAttribute("pitches", pitchRepository.findAll());
        return "view-pitches";
}
}