package com.cmf.community_football_manager.repository;

import com.cmf.community_football_manager.model.Match;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MatchRepository extends JpaRepository<Match, Long> {
    // Va fi util mai târziu pentru a afișa lista de meciuri disponibile
    List<Match> findByStatus(String status);

    // Validare UC5: Verifică dacă terenul e ocupat la acea dată și oră
    boolean existsByPitchIdAndMatchDateAndMatchTime(Long pitchId, java.time.LocalDate matchDate, java.time.LocalTime matchTime);
}