package com.cmf.community_football_manager.repository;

import com.cmf.community_football_manager.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    // Spring va ști automat să genereze query-ul SQL pentru a căuta după email
    Optional<User> findByEmail(String email);
    
    // O vom folosi la validarea din UC1 pentru a vedea dacă username-ul e luat
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
}