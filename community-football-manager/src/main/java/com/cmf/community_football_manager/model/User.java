package com.cmf.community_football_manager.model;

import jakarta.persistence.*;

@Entity
@Table(name = "users") 
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private UserRole role;

    @Column(name = "is_confirmed")
    private boolean isConfirmed = false;

    // --- Câmpuri pentru Rating General (Comunitate) ---
    @Column(nullable = false)
    private int ratingSum = 0; // Suma tuturor stelelor primite

    @Column(nullable = false)
    private int ratingCount = 0; // De câte ori a fost votat

    // --- Câmpuri pentru Statistici (UC10) ---
    @Column(nullable = false)
    private int matchesPlayed = 0; 

    @Column(nullable = false)
    private int victories = 0; 

    @Column(nullable = false)
    private int goalsScored = 0; 

    // --- Câmpuri pentru Reputație Specifică Meci (UC11) ---
    @Column(nullable = false)
    private int fairPlayVotes = 0;

    @Column(nullable = false)
    private int skillVotes = 0;

    @Column(nullable = false)
    private int punctualityVotes = 0;

    @Column(nullable = false)
    private boolean isSuspended = false;

    @Column
    private String suspensionReason;

    // --- Constructori ---
    public User() {}

    public User(String username, String email, String password, UserRole role) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.role = role;
        this.isConfirmed = false;
    }

    public boolean isSuspended() {
        return isSuspended;
    }

    public void setSuspended(boolean isSuspended) {
        this.isSuspended = isSuspended;
    }

    public String getSuspensionReason() {
        return suspensionReason;
    }

    public void setSuspensionReason(String suspensionReason) {
        this.suspensionReason = suspensionReason;
    }

    // --- Metodă inteligentă de calcul rating ---
    public double getAverageRating() {
        if (ratingCount == 0) return 0.0;
        return Math.round(((double) ratingSum / ratingCount) * 10.0) / 10.0; 
    }

    // --- Getteri și Setteri ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public UserRole getRole() { return role; }
    public void setRole(UserRole role) { this.role = role; }

    public boolean isConfirmed() { return isConfirmed; }
    public void setConfirmed(boolean isConfirmed) { this.isConfirmed = isConfirmed; }

    public int getRatingSum() { return ratingSum; }
    public void setRatingSum(int ratingSum) { this.ratingSum = ratingSum; }

    public int getRatingCount() { return ratingCount; }
    public void setRatingCount(int ratingCount) { this.ratingCount = ratingCount; }

    public int getMatchesPlayed() { return matchesPlayed; }
    public void setMatchesPlayed(int matchesPlayed) { this.matchesPlayed = matchesPlayed; }

    public int getVictories() { return victories; }
    public void setVictories(int victories) { this.victories = victories; }

    public int getGoalsScored() { return goalsScored; }
    public void setGoalsScored(int goalsScored) { this.goalsScored = goalsScored; }

    public int getFairPlayVotes() { return fairPlayVotes; }
    public void setFairPlayVotes(int fairPlayVotes) { this.fairPlayVotes = fairPlayVotes; }

    public int getSkillVotes() { return skillVotes; }
    public void setSkillVotes(int skillVotes) { this.skillVotes = skillVotes; }

    public int getPunctualityVotes() { return punctualityVotes; }
    public void setPunctualityVotes(int punctualityVotes) { this.punctualityVotes = punctualityVotes; }
}