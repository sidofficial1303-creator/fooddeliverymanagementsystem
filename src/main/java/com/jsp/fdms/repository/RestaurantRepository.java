package com.jsp.fdms.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jsp.fdms.entity.Restaurant;

public interface RestaurantRepository extends JpaRepository<Restaurant, Integer>
{

}
