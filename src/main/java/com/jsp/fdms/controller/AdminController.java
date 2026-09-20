package com.jsp.fdms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jsp.fdms.entity.Order;
import com.jsp.fdms.entity.Restaurant;
import com.jsp.fdms.repository.OrderRepository;
import com.jsp.fdms.repository.RestaurantRepository;
import com.jsp.fdms.repository.UserRepository;
import com.jsp.fdms.service.OrderService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	 @Autowired
	    private UserRepository userRepo;

	    @Autowired
	    private RestaurantRepository restaurantRepo;

	    @Autowired
	    private OrderRepository orderRepo;

	    @Autowired
	    private OrderService orderService;
	
	    @GetMapping("/dashboard")
	    public String dashboard() {
	        return "admin-dashboard";
	    }

	    @GetMapping("/users")
	    public String users(Model model) {
	        model.addAttribute("users", userRepo.findAll());
	        return "admin-users";
	    }
	    
	    @GetMapping("/add-restaurant")
	    public String addRestaurantPage() {
	        return "add-restaurant";
	    }

	    @PostMapping("/add-restaurant")
	    public String saveRestaurant(Restaurant r) {
	        restaurantRepo.save(r);
	        return "redirect:/admin/restaurants";
	    }
	    
	    @PostMapping("/update-status/{id}/{status}")
	    public String updateStatus(@PathVariable int id, @PathVariable String status) {

	        Order order = orderRepo.findById(id).orElse(null);

	        if (order != null) {
	            order.setStatus(status);
	            orderRepo.save(order);
	        }

	        
	        return "redirect:/admin/orders";
	    }

	    @GetMapping("/restaurants")
	    public String restaurants(Model model) {
	        model.addAttribute("restaurants", restaurantRepo.findAll());
	        return "admin-restaurants";
	    }

	    @GetMapping("/orders")
	    public String orders(Model model) {
	        model.addAttribute("orders", orderRepo.findAll());
	        return "admin-orders";
	    }
	    
	    @PostMapping("/delete-restaurant/{id}")
	    public String deleteRestaurant(@PathVariable int id) {
	        restaurantRepo.deleteById(id);
	        return "redirect:/admin/restaurants";
	    }
	    
	    
	    @GetMapping("/edit-restaurant/{id}")
	    public String editRestaurant(@PathVariable int id, Model model) {

	        Restaurant r = restaurantRepo.findById(id).orElse(null);
	        model.addAttribute("restaurant", r);

	        return "edit-restaurant";
	    }

	    @PostMapping("/update-restaurant")
	    public String updateRestaurant(Restaurant r) {
	        restaurantRepo.save(r);
	        return "redirect:/admin/restaurants";
	    }
	    
	    @GetMapping("/order-details/{id}")
	    public String orderDetails(@PathVariable int id, Model model) {

	        model.addAttribute("items", orderService.getItems(id));

	        return "order-details";
	    }
	    
	    
	    
	    
	
	
}
