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
public class ReservationController {

    @Autowired
    private TimeSlotRepository timeSlotRepository;
    @Autowired
    private ReservationRepository reservationRepository;
    @Autowired
    private PitchRepository pitchRepository;

    // UC8: Jucătorul vede intervalele libere pentru un teren 
    @GetMapping("/book-pitch")
    public String showBookingPage(@RequestParam Long pitchId, Model model) {
        model.addAttribute("pitch", pitchRepository.findById(pitchId).orElseThrow());
        model.addAttribute("slots", timeSlotRepository.findByPitchIdAndIsAvailableTrue(pitchId));
        return "book-pitch";
    }

    // UC8: Trimitere solicitare rezervare [cite: 133, 136]
    @PostMapping("/request-reservation")
    public String requestReservation(@RequestParam Long slotId, HttpSession session) {
        User player = (User) session.getAttribute("loggedInUser");
        if (player == null) return "redirect:/login";

        Reservation res = new Reservation();
        res.setPlayer(player);
        res.setTimeSlot(timeSlotRepository.findById(slotId).orElseThrow());
        res.setStatus("PENDING");
        reservationRepository.save(res);

        return "redirect:/profile?success=Cerere trimisa furnizorului";
    }
}