package com.jsp.fdms.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.jsp.fdms.entity.Users;
import com.jsp.fdms.repository.UserRepository;

@Configuration
public class DataInitializer {

    @Bean
    public CommandLineRunner createDefaultUsers(
            UserRepository userRepo,
            PasswordEncoder passwordEncoder) {

        return args -> {
            createOrFixUser(userRepo, passwordEncoder,
                    "System Admin", "admin@fdms.com", "admin123", "ADMIN");

            createOrFixUser(userRepo, passwordEncoder,
                    "Restaurant Manager", "restaurant@fdms.com", "restaurant123", "RESTAURANT");
        };
    }

    private void createOrFixUser(UserRepository userRepo,
                                 PasswordEncoder passwordEncoder,
                                 String name,
                                 String email,
                                 String plainPassword,
                                 String role) {

        Users user = userRepo.findByEmailIgnoreCase(email);

        if (user == null) {
            user = new Users();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(passwordEncoder.encode(plainPassword));
            user.setRole(role);
            userRepo.save(user);
            return;
        }

        
        
        if (user.getPassword() == null || !user.getPassword().startsWith("$2")) {
            user.setPassword(passwordEncoder.encode(plainPassword));
        }

        user.setRole(role);
        userRepo.save(user);
    }
}
