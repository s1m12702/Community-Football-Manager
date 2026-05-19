package com.cmf.community_football_manager.model;

import jakarta.persistence.*;

@Entity
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "player_id", nullable = false)
    private User player; // Jucătorul care face cererea

    @ManyToOne
    @JoinColumn(name = "time_slot_id", nullable = false)
    private TimeSlot timeSlot; // Intervalul orar dorit

    @Column(nullable = false)
    private String status = "PENDING"; // Status: PENDING, CONFIRMED, REJECTED [cite: 140]

    @Column(length = 255)
    private String rejectionReason; // Motivul respingerii (opțional) [cite: 145]

    public Reservation() {}

    // --- Getteri și Setteri ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getPlayer() { return player; }
    public void setPlayer(User player) { this.player = player; }

    public TimeSlot getTimeSlot() { return timeSlot; }
    public void setTimeSlot(TimeSlot timeSlot) { this.timeSlot = timeSlot; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getRejectionReason() { return rejectionReason; }
    public void setRejectionReason(String rejectionReason) { this.rejectionReason = rejectionReason; }
}