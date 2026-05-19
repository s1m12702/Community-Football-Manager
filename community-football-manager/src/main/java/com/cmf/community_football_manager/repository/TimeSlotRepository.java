package com.cmf.community_football_manager.repository;

import com.cmf.community_football_manager.model.TimeSlot;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface TimeSlotRepository extends JpaRepository<TimeSlot, Long> {
    List<TimeSlot> findByPitchId(Long pitchId);
    List<TimeSlot> findByPitchIdAndIsAvailableTrue(Long pitchId); // Pentru UC8 (Jucătorul vede orele libere)
}