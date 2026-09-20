package com.jsp.fdms.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jsp.fdms.entity.Order;
import com.jsp.fdms.entity.Users;
import com.jsp.fdms.repository.OrderRepository;
import com.jsp.fdms.service.OrderService;

import jakarta.servlet.http.HttpSession;

@Controller
public class OrderController {

    @Autowired
    private OrderService service;

    @Autowired
    private OrderRepository orderRepo;

    @GetMapping("/checkout")
    public String checkout(HttpSession session) {
        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            return "redirect:/cart";
        }

        return "checkout";
    }

    @PostMapping("/place-order")
    public String placeOrder(
            @RequestParam(defaultValue = "COD") String payment,
            HttpSession session) {

        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute("cart");

        Users user = (Users) session.getAttribute("user");

        if (cart != null && !cart.isEmpty() && user != null) {
            service.placeOrder(cart, user.getId(), payment);
            session.removeAttribute("cart");
        }

        return "redirect:/orders";
    }

    @GetMapping("/orders")
    public String orders(HttpSession session, Model model) {

        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            return "redirect:/";
        }

        model.addAttribute("orders",
                service.getOrdersByUser(user.getId()));

        return "orders";
    }

    @GetMapping("/order-details/{id}")
    public String orderDetails(
            @PathVariable int id,
            HttpSession session,
            Model model) {

        Users user = (Users) session.getAttribute("user");
        Order order = orderRepo.findById(id).orElse(null);

      
        if (user == null || order == null ||
                order.getUserId() != user.getId()) {
            return "redirect:/orders";
        }

        model.addAttribute("items", service.getItems(id));
        return "order-details";
    }
}
