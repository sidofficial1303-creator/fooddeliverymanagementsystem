package com.jsp.fdms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.jsp.fdms.entity.Users;
import com.jsp.fdms.repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository repo;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public boolean register(Users user) {

        String email = user.getEmail() == null ? "" : user.getEmail().trim();
        user.setEmail(email);

        if (repo.existsByEmailIgnoreCase(email)) {
            return false;
        }

        user.setPassword(passwordEncoder.encode(user.getPassword()));
        repo.save(user);
        return true;
    }

    public Users findByEmail(String email) {
        return repo.findByEmailIgnoreCase(email == null ? "" : email.trim());
    }
}
