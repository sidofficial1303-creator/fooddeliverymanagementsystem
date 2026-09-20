package com.jsp.fdms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jsp.fdms.entity.FoodItem;
import com.jsp.fdms.entity.Restaurant;
import com.jsp.fdms.repository.FoodItemRepository;
import com.jsp.fdms.repository.RestaurantRepository;

@Service
public class RestaurantService {

	@Autowired
    private RestaurantRepository restaurantRepo;

    @Autowired
    private FoodItemRepository foodRepo;

    public List<Restaurant> getAllRestaurants() {
        return restaurantRepo.findAll();
    }
    
    public List<FoodItem> getMenuByRestaurant(int id) {
        return foodRepo.findByRestaurantId(id);
    }

    public void addFoodItem(FoodItem food, int restaurantId) {
        Restaurant restaurant = restaurantRepo.findById(restaurantId).orElse(null);

        if (restaurant != null) {
            food.setRestaurant(restaurant);
            foodRepo.save(food);
        }
    }
    
 
    public void addSampleData() {
        if (restaurantRepo.count() == 0) {

            Restaurant r1 = new Restaurant();
            r1.setName("Pizza Hub");
            r1.setLocation("Pune");
            r1.setRating(4.5);
            restaurantRepo.save(r1);

            FoodItem f1 = new FoodItem();
            f1.setName("Margherita Pizza");
            f1.setPrice(250);
            f1.setCategory("Veg");
            f1.setRestaurant(r1);
            foodRepo.save(f1);

            FoodItem f2 = new FoodItem();
            f2.setName("Farmhouse Pizza");
            f2.setPrice(350);
            f2.setCategory("Veg");
            f2.setRestaurant(r1);
            foodRepo.save(f2);
        }
    }
    
    
    
    
	
}
