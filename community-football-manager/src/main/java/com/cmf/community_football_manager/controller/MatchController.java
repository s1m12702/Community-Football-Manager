package com.cmf.community_football_manager.controller;

import com.cmf.community_football_manager.model.FeedbackVote;
import com.cmf.community_football_manager.model.Match;
import com.cmf.community_football_manager.model.Pitch;
import com.cmf.community_football_manager.model.User;
import com.cmf.community_football_manager.repository.FeedbackVoteRepository;
import com.cmf.community_football_manager.repository.MatchRepository;
import com.cmf.community_football_manager.repository.PitchRepository;
import com.cmf.community_football_manager.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpServletRequest;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Controller
public class MatchController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private MatchRepository matchRepository;

    @Autowired
    private PitchRepository pitchRepository;
    @Autowired 
    private FeedbackVoteRepository feedbackVoteRepository;


    // UC5: Afișează formularul de creare meci cu lista de terenuri
    @GetMapping("/create-match")
    public String showCreateMatchForm(HttpSession session, Model model) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        // Trimitem lista de terenuri pentru dropdown
        model.addAttribute("pitches", pitchRepository.findAll());
        return "create-match";
    }

    // UC5: Procesează crearea meciului
    @PostMapping("/create-match")
    public String createMatch(@RequestParam String matchDate,
                              @RequestParam String matchTime,
                              @RequestParam Long pitchId,
                              @RequestParam int maxParticipants,
                              HttpSession session,
                              Model model) {
        
        User organizer = (User) session.getAttribute("loggedInUser");
        if (organizer == null) return "redirect:/login";

        LocalDate date = LocalDate.parse(matchDate);
        LocalTime time = LocalTime.parse(matchTime);

        // --- VALIDARE UC5: Verificăm dacă terenul este ocupat ---
        if (matchRepository.existsByPitchIdAndMatchDateAndMatchTime(pitchId, date, time)) {
            model.addAttribute("error", "Terenul selectat este deja rezervat la această dată și oră! Te rugăm să alegi alt interval orar sau alt teren.");
            model.addAttribute("pitches", pitchRepository.findAll()); // Reîncărcăm terenurile pentru dropdown
            return "create-match"; // Îl oprim aici și îl punem să modifice datele
        }

        // Dacă trece de validare, continuăm salvarea:
        Pitch selectedPitch = pitchRepository.findById(pitchId).orElseThrow();
        Match newMatch = new Match(date, time, selectedPitch, maxParticipants, organizer);
        matchRepository.save(newMatch);

        model.addAttribute("success", "Meciul a fost creat cu succes la " + selectedPitch.getName() + "!");
        model.addAttribute("pitches", pitchRepository.findAll());
        return "create-match";
    }

    // UC6: Afișează toate meciurile active
    @GetMapping("/matches")
    public String listMatches(Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) return "redirect:/login";
        
        List<Match> matches = matchRepository.findByStatus("ACTIVE");
        model.addAttribute("matches", matches);
        return "matches";
    }

    // UC6: Procesează înscrierea la un meci 
    @PostMapping("/join-match")
    public String joinMatch(@RequestParam Long matchId, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Match match = matchRepository.findById(matchId).orElseThrow();
        
        // Verificăm dacă jucătorul este deja în listă comparând ID-urile
        boolean alreadyJoined = match.getParticipants().stream()
                .anyMatch(p -> p.getId().equals(loggedInUser.getId()));

        if (match.getParticipants().size() >= match.getMaxParticipants()) {
            model.addAttribute("error", "Meci complet!");
        } else if (alreadyJoined) {
            model.addAttribute("error", "Ești deja înscris la acest meci!");
        } else {
            // Dacă totul e ok, îl adăugăm pe baza contului proaspăt din DB, ca să evităm probleme de sesiune
            match.getParticipants().add(loggedInUser);
            matchRepository.save(match);
            model.addAttribute("success", "Te-ai înscris cu succes!");
        }

        model.addAttribute("matches", matchRepository.findByStatus("ACTIVE"));
        return "matches";
    }

    // UC7: Afișează meciurile organizate de mine
    @GetMapping("/my-organized-matches")
    public String myMatches(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/login";

        List<Match> myMatches = matchRepository.findAll().stream()
                .filter(m -> m.getOrganizer().getId().equals(loggedInUser.getId()))
                .toList();

        model.addAttribute("myMatches", myMatches);
        return "my-matches";
    }

    // UC7: Procesează introducerea scorului și finalizarea
    // UC7: Afișează pagina detaliată pentru finalizarea unui meci
    @GetMapping("/finish-match-form")
    public String showFinishMatchForm(@RequestParam Long matchId, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/login";

        Match match = matchRepository.findById(matchId).orElseThrow();
        
        // Verificăm dacă e organizatorul
        if (!match.getOrganizer().getId().equals(loggedInUser.getId())) {
            return "redirect:/my-organized-matches";
        }

        model.addAttribute("match", match);
        return "finish-match";
    }

    // UC11: Afișează istoricul meciurilor la care am participat
    @GetMapping("/my-history")
    public String myHistory(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/login";

        // Găsim meciurile FINALIZATE în care utilizatorul curent se află în lista de participanți
        List<Match> pastMatches = matchRepository.findAll().stream()
                .filter(m -> m.getStatus().equals("FINISHED"))
                .filter(m -> m.getParticipants().stream().anyMatch(p -> p.getId().equals(loggedInUser.getId())))
                .toList();

        model.addAttribute("pastMatches", pastMatches);
        return "my-history";
    }

    // UC11: Afișează pagina unde acordăm aprecieri jucătorilor din acel meci
    @GetMapping("/feedback")
    public String showFeedbackForm(@RequestParam Long matchId, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/login";

        Match match = matchRepository.findById(matchId).orElseThrow();
        
        model.addAttribute("match", match);
        model.addAttribute("myId", loggedInUser.getId()); // Trimitem ID-ul nostru pentru a bloca auto-votul
        return "feedback";
    }

    // UC11: Procesează votul și actualizează reputația
   @PostMapping("/submit-feedback")
    public String submitFeedback(@RequestParam Long targetUserId, 
                             @RequestParam String type, 
                             @RequestParam Long matchId,
                             HttpSession session,
                             Model model) {
    
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if (loggedInUser == null) return "redirect:/login";

    // 1. Verificare Auto-Vot (UC11) 
    if (loggedInUser.getId().equals(targetUserId)) {
        return "redirect:/feedback?matchId=" + matchId + "&error=Nu te poti vota singur!";
    }

    // 2. Verificare Vot Multiplu
    if (feedbackVoteRepository.existsByEvaluatorIdAndTargetUserIdAndMatchId(loggedInUser.getId(), targetUserId, matchId)) {
        return "redirect:/feedback?matchId=" + matchId + "&error=Ai acordat deja feedback acestui jucator pentru acest meci!";
    }

    // Dacă trece de verificări, salvăm votul în istoric
    User target = userRepository.findById(targetUserId).orElseThrow();
    if (type.equals("fairplay")) target.setFairPlayVotes(target.getFairPlayVotes() + 1);
    else if (type.equals("skill")) target.setSkillVotes(target.getSkillVotes() + 1);
    else if (type.equals("punctuality")) target.setPunctualityVotes(target.getPunctualityVotes() + 1);

    userRepository.save(target);
    feedbackVoteRepository.save(new FeedbackVote(loggedInUser.getId(), targetUserId, matchId));
    
    return "redirect:/feedback?matchId=" + matchId + "&success=Feedback salvat cu succes!";
}

    // UC7: Procesează finalizarea și actualizează statisticile
    @PostMapping("/finish-match")
    public String processFinishMatch(@RequestParam Long matchId,
                                     @RequestParam Integer scoreA,
                                     @RequestParam Integer scoreB,
                                     HttpServletRequest request,
                                     HttpSession session,
                                     Model model) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        Match match = matchRepository.findById(matchId).orElseThrow();

        if (loggedInUser == null || !match.getOrganizer().getId().equals(loggedInUser.getId())) {
            return "redirect:/login";
        }

        int totalMatchGoals = scoreA + scoreB;
        int sumPlayerGoals = 0;

        // Calculăm suma golurilor introduse pentru toți jucătorii
        for (User player : match.getParticipants()) {
            String goalsStr = request.getParameter("goals_" + player.getId());
            if (goalsStr != null && !goalsStr.isEmpty()) {
                sumPlayerGoals += Integer.parseInt(goalsStr);
            }
        }

        // VALIDARE UC7: Verificăm dacă datele sunt contradictorii 
        if (sumPlayerGoals > totalMatchGoals) {
            model.addAttribute("error", "Eroare: Numărul total de goluri atribuite jucătorilor (" + sumPlayerGoals + ") este mai mare decât scorul total al meciului (" + totalMatchGoals + ")!");
            model.addAttribute("match", match);
            return "finish-match"; // Îl întoarcem să corecteze
        }

        // Dacă e corect, actualizăm jucătorii 
        for (User player : match.getParticipants()) {
            player.setMatchesPlayed(player.getMatchesPlayed() + 1); // +1 meci jucat
            
            // Verificăm golurile
            String goalsStr = request.getParameter("goals_" + player.getId());
            if (goalsStr != null && !goalsStr.isEmpty()) {
                player.setGoalsScored(player.getGoalsScored() + Integer.parseInt(goalsStr));
            }

            // Verificăm dacă organizatorul a bifat că acest jucător a câștigat
            String wonStr = request.getParameter("won_" + player.getId());
            if (wonStr != null && wonStr.equals("yes")) {
                player.setVictories(player.getVictories() + 1); // +1 victorie
            }

            // *Notă: ar trebui să avem un userRepository (dacă nu-l ai injectat în MatchController, fă-o!)*
            // Dacă ai eroare aici, adaugă sus: @Autowired private com.cmf.community_football_manager.repository.UserRepository userRepository;
            // userRepository.save(player); 
        }

        // Salvăm meciul ca finalizat [cite: 111, 115]
        match.setScoreA(scoreA);
        match.setScoreB(scoreB);
        match.setStatus("FINISHED");
        matchRepository.save(match);

        return "redirect:/my-organized-matches";
    }

    @GetMapping("/my-matches")
    public String showMyMatches(HttpSession session, Model model) {
        // 1. Verificăm dacă userul este logat
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login"; // Dacă nu e logat, îl trimitem la login
        }

        // 2. Aducem din baza de date meciurile pe care le-a creat acest user
        List<Match> myMatches = matchRepository.findByOrganizer(loggedInUser);
        
        // 3. Trimitem lista către fișierul my-matches.jsp sub numele "myMatches"
        model.addAttribute("myMatches", myMatches);

        // 4. Returnăm numele fișierului JSP (fără extensia .jsp)
        return "my-matches";
}

    
}