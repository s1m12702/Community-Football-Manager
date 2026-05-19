package com.cmf.community_football_manager.repository;

import com.cmf.community_football_manager.model.FeedbackVote;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FeedbackVoteRepository extends JpaRepository<FeedbackVote, Long> {
    boolean existsByEvaluatorIdAndTargetUserIdAndMatchId(Long evaluatorId, Long targetUserId, Long matchId);
}