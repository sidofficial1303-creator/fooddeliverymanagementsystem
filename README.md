# Food Delivery Management System (FDMS)

## Technology
- Java 17
- Spring Boot 4
- Spring MVC
- Spring Data JPA / Hibernate
- PostgreSQL
- JSP
- Spring Security
- BCrypt password hashing
- Maven

## Main flow

User Registration
-> UserService
-> BCryptPasswordEncoder
-> UserRepository
-> PostgreSQL

User Login
-> Spring Security
-> CustomUserDetailsService
-> UserRepository
-> BCrypt password verification
-> Role based redirect

Food Ordering
-> RestaurantController
-> Session Cart
-> Checkout
-> OrderController
-> OrderService
-> OrderRepository + OrderItemRepository

Admin
-> AdminController
-> Manage users/restaurants/orders
-> Update order status

## Demo credentials

Admin:
- Email: admin@fdms.com
- Password: admin123

Restaurant:
- Email: restaurant@fdms.com
- Password: restaurant123

These users are created automatically by `DataInitializer`. The passwords are NOT stored as plain text in the database. They are encoded using BCrypt at application startup.

## BCrypt examples

If you need to insert the demo users manually, BCrypt hashes can look like:

admin123:
`$2a$10$yBZrJ4B8teX0zOARd/2GEu1OagNUdlqeHWgzu5dVoQxZrTCt2EU9y`

restaurant123:
`$2a$10$03NZb3UotQUKYps9LAvcOeyZGM9paQW4tX/5psAAsadjTUaUigxPO`

A BCrypt hash is intentionally different each time because BCrypt uses a salt. Therefore, do not compare the plain password with the database value using `equals()`. Spring Security uses the PasswordEncoder to verify it.

## Security configuration

`SecurityConfig` provides:
1. BCrypt password encoder.
2. Role based URL protection.
3. Custom login page.
4. Login processing through Spring Security.
5. Logout and session invalidation.
6. CSRF tokens in POST forms.

Roles:
- USER -> ordering pages
- ADMIN -> `/admin/**`
- RESTAURANT -> `/restaurant/**`

## Important interview explanation

### Why BCrypt?
Passwords should never be stored as plain text. BCrypt is a one-way password hashing algorithm with a salt. During login, Spring Security checks the entered password against the stored BCrypt hash.

### Why UserDetailsService?
Spring Security needs a standard way to load a user from the database. `CustomUserDetailsService` reads the email, password hash and role from `Users` and returns a `UserDetails` object.

### Why SecurityFilterChain?
It defines which URLs are public and which URLs require authentication or a specific role.

### Why session cart?
For a simple JSP-based project, the cart is stored in the HTTP session. The key is the food ID and the value is the quantity.

### Why Order and OrderItem are separate?
`Order` stores order-level information such as user, total, status, payment mode and date. `OrderItem` stores each food item belonging to an order.

### Why @Transactional?
Placing an order writes the order and multiple order items. `@Transactional` makes these database operations part of one transaction.

## Run

1. Start PostgreSQL.
2. Create database `fdms`.
3. Check username/password in `application.properties`.
4. Import the project into Eclipse as an existing Maven project.
5. Run `FooddeliverymanagementsystemApplication`.
6. Open `http://localhost:8080/fooddeliverymanagementsystem/` if deployed with a context path, or `http://localhost:8080/` when running directly from Spring Boot.

`spring.jpa.hibernate.ddl-auto=update` creates/updates the required tables automatically.

## Note
The project was updated while keeping the original package structure and simple controller -> service -> repository approach. JSP pages use one shared CSS file so the UI is easier to explain in an interview.
