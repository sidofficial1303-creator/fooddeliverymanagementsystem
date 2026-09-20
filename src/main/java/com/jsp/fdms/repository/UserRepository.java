package com.jsp.fdms.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jsp.fdms.entity.Users;

public interface UserRepository extends JpaRepository<Users, Integer> {

    Users findByEmailIgnoreCase(String email);

    boolean existsByEmailIgnoreCase(String email);
}
