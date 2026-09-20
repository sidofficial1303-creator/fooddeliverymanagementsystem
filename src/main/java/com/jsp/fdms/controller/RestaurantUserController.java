package com.jsp.fdms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.jsp.fdms.entity.FoodItem;
import com.jsp.fdms.service.RestaurantService;

@Controller
public class RestaurantUserController {

    private final RestaurantService service;

    public RestaurantUserController(RestaurantService service) {
        this.service = service;
    }

    @GetMapping("/restaurant/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("restaurants", service.getAllRestaurants());
        return "restaurant-dashboard";
    }

    @GetMapping("/restaurant/add-food")
    public String addFoodPage(Model model) {
        model.addAttribute("restaurants", service.getAllRestaurants());
        return "add-food";
    }

    @PostMapping("/restaurant/add-food")
    public String addFood(FoodItem food, int restaurantId) {
        service.addFoodItem(food, restaurantId);
        return "redirect:/restaurant/dashboard";
    }
}
