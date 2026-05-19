package com.cmf.community_football_manager.repository;

import com.cmf.community_football_manager.model.Pitch;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PitchRepository extends JpaRepository<Pitch, Long> {
    // Ne va fi utilă pentru a găsi toate terenurile unui anumit furnizor
    List<Pitch> findByProviderId(Long providerId);
}