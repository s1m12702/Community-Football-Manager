package com.cmf.community_football_manager.repository;

import com.cmf.community_football_manager.model.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    List<Reservation> findByTimeSlotPitchProviderId(Long providerId); // Aduce toate cererile pentru un furnizor [cite: 143]
}