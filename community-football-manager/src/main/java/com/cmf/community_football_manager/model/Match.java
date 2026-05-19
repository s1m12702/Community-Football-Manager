package com.cmf.community_football_manager.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "matches")
public class Match {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private LocalDate matchDate;

    @Column(nullable = false)
    private LocalTime matchTime;

    // Legătura cu terenul (înlocuiește vechiul String location)
    @ManyToOne
    @JoinColumn(name = "pitch_id", nullable = false)
    private Pitch pitch;

    @Column(nullable = false)
    private int maxParticipants;

    @Column(nullable = false)
    private String status = "ACTIVE"; // Poate fi ACTIVE sau FINISHED

    @Column
    private Integer scoreA; // Scorul echipei A

    @Column
    private Integer scoreB; // Scorul echipei B

    // Legătura cu utilizatorul care a creat meciul (Organizatorul)
    @ManyToOne
    @JoinColumn(name = "organizer_id", nullable = false)
    private User organizer;

    // Lista de jucători înscriși (ManyToMany)
    @ManyToMany
    @JoinTable(
        name = "match_participants",
        joinColumns = @JoinColumn(name = "match_id"),
        inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private List<User> participants = new ArrayList<>();

    // --- Constructori ---
    public Match() {}

    public Match(LocalDate matchDate, LocalTime matchTime, Pitch pitch, int maxParticipants, User organizer) {
        this.matchDate = matchDate;
        this.matchTime = matchTime;
        this.pitch = pitch;
        this.maxParticipants = maxParticipants;
        this.organizer = organizer;
        this.status = "ACTIVE";
    }

    // --- Getteri și Setteri ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public LocalDate getMatchDate() { return matchDate; }
    public void setMatchDate(LocalDate matchDate) { this.matchDate = matchDate; }

    public LocalTime getMatchTime() { return matchTime; }
    public void setMatchTime(LocalTime matchTime) { this.matchTime = matchTime; }

    public Pitch getPitch() { return pitch; }
    public void setPitch(Pitch pitch) { this.pitch = pitch; }

    public int getMaxParticipants() { return maxParticipants; }
    public void setMaxParticipants(int maxParticipants) { this.maxParticipants = maxParticipants; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Integer getScoreA() { return scoreA; }
    public void setScoreA(Integer scoreA) { this.scoreA = scoreA; }

    public Integer getScoreB() { return scoreB; }
    public void setScoreB(Integer scoreB) { this.scoreB = scoreB; }

    public User getOrganizer() { return organizer; }
    public void setOrganizer(User organizer) { this.organizer = organizer; }

    public List<User> getParticipants() { return participants; }
    public void setParticipants(List<User> participants) { this.participants = participants; }
}