package com.cmf.community_football_manager.model;

import jakarta.persistence.*;

@Entity
public class FeedbackVote {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long evaluatorId; // Cine votează
    private Long targetUserId; // Cine primește
    private Long matchId; // În ce meci

    public FeedbackVote() {}
    public FeedbackVote(Long evaluatorId, Long targetUserId, Long matchId) {
        this.evaluatorId = evaluatorId;
        this.targetUserId = targetUserId;
        this.matchId = matchId;
    }
    // Getteri și Setteri...
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public Long getEvaluatorId() {
        return evaluatorId;
    }
    public void setEvaluatorId(Long evaluatorId) {
        this.evaluatorId = evaluatorId;
    }
    public Long getTargetUserId() {
        return targetUserId;
    }
    public void setTargetUserId(Long targetUserId) {
        this.targetUserId = targetUserId;
    }
    public Long getMatchId() {
        return matchId;
    }
    public void setMatchId(Long matchId) {
        this.matchId = matchId;
    }
}