package com.jsp.fdms.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jsp.fdms.entity.Order;

public interface OrderRepository  extends JpaRepository<Order, Integer>
{

	List<Order> findByUserId(int userId);
	
}
