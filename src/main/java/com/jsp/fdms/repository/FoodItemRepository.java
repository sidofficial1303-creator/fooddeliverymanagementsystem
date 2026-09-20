package com.jsp.fdms.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jsp.fdms.entity.FoodItem;

public interface FoodItemRepository extends JpaRepository<FoodItem, Integer>
{
  List<FoodItem> findByRestaurantId(int restaurantId );
}
