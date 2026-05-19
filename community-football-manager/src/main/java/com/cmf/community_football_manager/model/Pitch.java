package com.cmf.community_football_manager.model;

import jakarta.persistence.*;

@Entity
@Table(name = "pitches")
public class Pitch {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name; // Numele terenului (ex: Teren Sintetic Arena)

    @Column(nullable = false)
    private String address; // Adresa fizică

    @Column(nullable = false)
    private double pricePerHour; // Prețul pe oră

    // Legătura cu utilizatorul care deține terenul (PITCH_PROVIDER)
    @ManyToOne
    @JoinColumn(name = "provider_id", nullable = false)
    private User provider;

    public Pitch() {}

    public Pitch(String name, String address, double pricePerHour, User provider) {
        this.name = name;
        this.address = address;
        this.pricePerHour = pricePerHour;
        this.provider = provider;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getPricePerHour() {
        return pricePerHour;
    }

    public void setPricePerHour(double pricePerHour) {
        this.pricePerHour = pricePerHour;
    }

    public User getProvider() {
        return provider;
    }

    public void setProvider(User provider) {
        this.provider = provider;
    }

    // --- Getteri și Setteri ---
    // (Nu uita să dai click dreapta -> Source Action -> Generate Getters and Setters pentru toate câmpurile!)
}