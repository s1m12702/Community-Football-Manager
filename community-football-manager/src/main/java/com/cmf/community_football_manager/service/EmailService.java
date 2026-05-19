package com.cmf.community_football_manager.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendConfirmationEmail(String toEmail) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject("Confirmare Cont - Community Football Manager");
        
        // Generăm linkul de confirmare
        String confirmationLink = "http://localhost:8080/confirm?email=" + toEmail;
        
        message.setText("Salut,\n\nBine ai venit în Community Football Manager!\n"
                + "Te rugăm să dai click pe linkul de mai jos pentru a-ți confirma contul:\n"
                + confirmationLink + "\n\nSpor la joc!");

        mailSender.send(message);
    }

    // Metodă nouă pentru UC3: Resetare parolă
    public void sendPasswordResetEmail(String toEmail, String newPassword) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject("Resetare Parolă - Community Football Manager");
        
        message.setText("Salut,\n\nAi solicitat resetarea parolei.\n"
                + "Noua ta parolă temporară este: " + newPassword + "\n\n"
                + "Te poți autentifica folosind această parolă și îți recomandăm să o schimbi din secțiunea 'Contul meu'.\n\nSpor la joc!");

        mailSender.send(message);
    }
}