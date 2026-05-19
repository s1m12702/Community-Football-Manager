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

import java.util.List;

@Controller
public class ProviderController {

    @Autowired
    private PitchRepository pitchRepository;

    @Autowired
    private TimeSlotRepository timeSlotRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    // UC9: Panoul principal al furnizorului - vede terenurile proprii și cererile
    @GetMapping("/provider-dashboard")
    public String providerDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() != UserRole.PITCH_PROVIDER) {
            return "redirect:/login";
        }

        // Găsim terenurile adăugate de acest furnizor
        List<Pitch> myPitches = pitchRepository.findByProviderId(user.getId());
        model.addAttribute("pitches", myPitches);

        // Găsim toate rezervările primite pentru terenurile acestui furnizor 
        List<Reservation> requests = reservationRepository.findByTimeSlotPitchProviderId(user.getId());
        model.addAttribute("requests", requests);

        return "provider-dashboard";
    }

    // UC9: Adăugarea unui interval orar nou (Configurare disponibilitate) 
    @PostMapping("/add-timeslot")
    public String addTimeSlot(@RequestParam Long pitchId,
                              @RequestParam String date,
                              @RequestParam String start,
                              @RequestParam String end,
                              HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() != UserRole.PITCH_PROVIDER) return "redirect:/login";

        Pitch pitch = pitchRepository.findById(pitchId).orElseThrow();
        
        TimeSlot slot = new TimeSlot();
        slot.setPitch(pitch);
        slot.setSlotDate(date);
        slot.setStartTime(start);
        slot.setEndTime(end);
        slot.setAvailable(true); // Implicit este disponibil [cite: 140]

        timeSlotRepository.save(slot);
        return "redirect:/provider-dashboard?success=Interval adaugat";
    }

    // UC9: Confirmarea unei rezervări [cite: 144]
    @PostMapping("/confirm-reservation")
    public String confirmReservation(@RequestParam Long reservationId, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() != UserRole.PITCH_PROVIDER) return "redirect:/login";

        Reservation res = reservationRepository.findById(reservationId).orElseThrow();
        res.setStatus("CONFIRMED");
        
        // Când confirmăm, intervalul respectiv devine indisponibil pentru alții [cite: 146, 147]
        TimeSlot slot = res.getTimeSlot();
        slot.setAvailable(false);
        
        timeSlotRepository.save(slot);
        reservationRepository.save(res);

        return "redirect:/provider-dashboard?success=Rezervare confirmata";
    }

    // UC9: Respingerea unei rezervări cu motiv 
    @PostMapping("/reject-reservation")
    public String rejectReservation(@RequestParam Long reservationId, 
                                    @RequestParam String reason, 
                                    HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() != UserRole.PITCH_PROVIDER) return "redirect:/login";

        Reservation res = reservationRepository.findById(reservationId).orElseThrow();
        res.setStatus("REJECTED");
        res.setRejectionReason(reason); // Adăugăm motivul respingerii [cite: 145]

        reservationRepository.save(res);
        return "redirect:/provider-dashboard?info=Rezervare respinsa";
    }
}