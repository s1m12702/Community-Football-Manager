package com.cmf.community_football_manager.controller;

import com.cmf.community_football_manager.model.User;
import com.cmf.community_football_manager.model.UserRole;
import com.cmf.community_football_manager.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpSession;
import java.util.Optional;
import java.util.UUID;

@Controller
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private com.cmf.community_football_manager.service.EmailService emailService;

    @GetMapping("/register")
    public String showRegistrationForm() {
        return "register"; 
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String email,
                            @RequestParam String password,
                            HttpSession session,
                            Model model) {
        
        Optional<User> userOpt = userRepository.findByEmail(email);

        if (userOpt.isPresent()) {
            User user = userOpt.get();

            if (user.getPassword().equals(password)) {
                
                if (user.isSuspended()) {
                        model.addAttribute("error", "Contul tău a fost suspendat de un administrator! Motiv: " + user.getSuspensionReason());
                        return "login"; 
                    }

                if (!user.isConfirmed()) {
                    model.addAttribute("error", "Contul nu este confirmat! Te rugăm să verifici email-ul.");
                    return "login";
                }

                session.setAttribute("loggedInUser", user);
                return "redirect:/profile"; 
                
            } else {
                model.addAttribute("error", "Parolă incorectă!");
            }
        } else {
            model.addAttribute("error", "Nu există niciun cont cu acest email!");
        }

        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); 
        return "redirect:/login";
    }

    // AICI AM SECURIZAT METODA DE ÎNREGISTRARE
    @PostMapping("/register")
    public String registerUser(@RequestParam String username,
                               @RequestParam String email,
                               @RequestParam String password,
                               @RequestParam(required = false) String role, // Preluăm rolul din formular
                               Model model) {
        
        // 1. BLOCAJ DE SECURITATE: Interzicem crearea conturilor de tip ADMIN [cite: 164]
        if ("ADMIN".equalsIgnoreCase(role)) {
            model.addAttribute("error", "Eroare de securitate: Crearea de conturi cu rolul ADMIN este interzisă!");
            return "register"; 
        }

        if (userRepository.existsByUsername(username)) {
            model.addAttribute("error", "Acest username este deja folosit. Te rugăm să alegi altul.");
            return "register"; 
        }

        if (userRepository.existsByEmail(email)) {
            model.addAttribute("error", "Există deja un cont înregistrat cu acest email.");
            return "register"; 
        }

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(password);
        
        // 2. SETĂM ROLUL CORECT (Doar Player sau Pitch_Provider) [cite: 46, 47, 48]
        if ("PITCH_PROVIDER".equalsIgnoreCase(role)) {
            newUser.setRole(UserRole.PITCH_PROVIDER);
        } else {
            newUser.setRole(UserRole.PLAYER); // Dacă nu s-a trimis nimic, punem Jucător implicit
        }

        userRepository.save(newUser);

        emailService.sendConfirmationEmail(newUser.getEmail());

        model.addAttribute("success", "Cont creat! Verifică-ți email-ul pentru confirmare.");
        return "register";
    }

    @GetMapping("/confirm")
    public String confirmEmail(@RequestParam String email, Model model) {
        Optional<User> userOpt = userRepository.findByEmail(email);

        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (!user.isConfirmed()) {
                user.setConfirmed(true); 
                userRepository.save(user); 
                model.addAttribute("success", "Contul a fost confirmat cu succes! Te poți autentifica.");
            } else {
                model.addAttribute("error", "Contul este deja confirmat.");
            }
        } else {
            model.addAttribute("error", "Link invalid sau utilizator inexistent.");
        }
        return "login"; 
    }

    @GetMapping("/forgot-password")
    public String showForgotPasswordForm() {
        return "forgot-password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam String email, Model model) {
        Optional<User> userOpt = userRepository.findByEmail(email);

        if (userOpt.isPresent()) {
            User user = userOpt.get();
            
            String newPassword = UUID.randomUUID().toString().substring(0, 8);
            user.setPassword(newPassword);
            userRepository.save(user);

            emailService.sendPasswordResetEmail(email, newPassword);
            
            model.addAttribute("success", "O parolă nouă a fost trimisă pe email-ul tău!");
        } else {
            model.addAttribute("error", "Nu există niciun cont înregistrat cu acest email.");
        }
        return "forgot-password";
    }
}