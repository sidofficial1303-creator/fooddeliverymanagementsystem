package com.jsp.fdms.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jsp.fdms.entity.FoodItem;
import com.jsp.fdms.entity.Order;
import com.jsp.fdms.entity.OrderItem;
import com.jsp.fdms.repository.FoodItemRepository;
import com.jsp.fdms.repository.OrderItemRepository;
import com.jsp.fdms.repository.OrderRepository;

@Service
public class OrderService {

	@Autowired
    private OrderRepository orderRepo;

    @Autowired
    private OrderItemRepository itemRepo;

    @Autowired
    private FoodItemRepository foodRepo;
	
    @Transactional
    public void placeOrder(Map<Integer, Integer> cart, int userId, String paymentMode) {

        double total = 0;

        Order order = new Order();
        order.setUserId(userId);
        order.setStatus("PLACED");
        order.setPaymentMode(paymentMode);
        order.setOrderDate(LocalDateTime.now());

        order = orderRepo.save(order);
    
        for (Integer foodId : cart.keySet()) {

            FoodItem food = foodRepo.findById(foodId).orElse(null);

            int qty = cart.get(foodId);

            if (food != null) {

                OrderItem item = new OrderItem();
                item.setOrderId(order.getId());
                item.setFoodName(food.getName());
                item.setPrice(food.getPrice());
                item.setQuantity(qty);

                total += food.getPrice() * qty;

                itemRepo.save(item);
            }
        }
        order.setTotalAmount(total);
        orderRepo.save(order);
    }
	
    public List<Order> getOrdersByUser(int userId) {
        return orderRepo.findByUserId(userId);
    }
    
    public List<OrderItem> getItems(int orderId) {
        return itemRepo.findByOrderId(orderId);
    }
    
}
