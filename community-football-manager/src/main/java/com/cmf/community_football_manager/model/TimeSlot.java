package com.cmf.community_football_manager.model;

import jakarta.persistence.*;

@Entity
public class TimeSlot {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "pitch_id", nullable = false)
    private Pitch pitch; // Terenul de care aparține

    @Column(nullable = false)
    private String slotDate; // Data (ex: 2026-05-20)

    @Column(nullable = false)
    private String startTime; // Ora de început (ex: 18:00)

    @Column(nullable = false)
    private String endTime; // Ora de final (ex: 20:00)

    @Column(nullable = false)
    private boolean isAvailable = true; // Status interval (Disponibil/Blocat) [cite: 140]

    public TimeSlot() {}

    // --- Getteri și Setteri ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Pitch getPitch() { return pitch; }
    public void setPitch(Pitch pitch) { this.pitch = pitch; }

    public String getSlotDate() { return slotDate; }
    public void setSlotDate(String slotDate) { this.slotDate = slotDate; }

    public String getStartTime() { return startTime; }
    public void setStartTime(String startTime) { this.startTime = startTime; }

    public String getEndTime() { return endTime; }
    public void setEndTime(String endTime) { this.endTime = endTime; }

    public boolean isAvailable() { return isAvailable; }
    public void setAvailable(boolean available) { isAvailable = available; }
}