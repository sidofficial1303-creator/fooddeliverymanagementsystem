package com.jsp.fdms.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.jsp.fdms.dto.CartItem;
import com.jsp.fdms.entity.FoodItem;
import com.jsp.fdms.repository.FoodItemRepository;
import com.jsp.fdms.service.RestaurantService;

import jakarta.servlet.http.HttpSession;

@Controller
public class RestaurantController {

	@Autowired
	private RestaurantService service;

	@Autowired
    private FoodItemRepository foodRepo;
	
	@GetMapping("/restaurants")
	public String showRestaurants(Model model) {

		service.addSampleData(); 

		model.addAttribute("restaurants", service.getAllRestaurants());
		return "restaurants";
	}
	
	@GetMapping("/menu/{id}")
    public String showMenu(@PathVariable int id, Model model) {

        model.addAttribute("menu", service.getMenuByRestaurant(id));
        return "menu";
    }
	
    @PostMapping("/add-to-cart/{id}")
    public String addToCart(@PathVariable int id, HttpSession session) {

        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
        }

        cart.put(id, cart.getOrDefault(id, 0) + 1);

        session.setAttribute("cart", cart);

        return "redirect:/cart";
    }
    
    @GetMapping("/cart")
    public String viewCart(HttpSession session, Model model) {

        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute("cart");

        List<CartItem> cartItems = new ArrayList<>();
        double total = 0;

        if (cart != null) {
            for (Integer id : cart.keySet()) {

                FoodItem food = foodRepo.findById(id).orElse(null);

                if (food != null) {

                    int qty = cart.get(id);

                    CartItem item = new CartItem();
                    item.setId(food.getId());
                    item.setName(food.getName());
                    item.setPrice(food.getPrice());
                    item.setQuantity(qty);
                    item.setSubtotal(food.getPrice() * qty);

                    total += item.getSubtotal();

                    cartItems.add(item);
                }
            }
        }

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("total", total);

        return "cart";
    }    
    @PostMapping("/remove/{id}")
    public String removeItem(@PathVariable int id, HttpSession session) {

        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart != null) {
            cart.remove(id);
        }

        return "redirect:/cart";
    }
	

}
