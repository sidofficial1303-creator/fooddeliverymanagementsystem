<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FDMS</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%
com.jsp.fdms.entity.Users navUser =
    (com.jsp.fdms.entity.Users) session.getAttribute("user");
%>
<div class="navbar">
    <a class="brand" href="${pageContext.request.contextPath}/home">🍴 FDMS</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/restaurants">Restaurants</a>
        <% if (navUser != null && "USER".equals(navUser.getRole())) { %>
            <a href="${pageContext.request.contextPath}/cart">Cart</a>
            <a href="${pageContext.request.contextPath}/orders">Orders</a>
        <% } %>
        <% if (navUser != null && "ADMIN".equals(navUser.getRole())) { %>
            <a href="${pageContext.request.contextPath}/admin/dashboard">Admin</a>
        <% } %>
        <% if (navUser != null && "RESTAURANT".equals(navUser.getRole())) { %>
            <a href="${pageContext.request.contextPath}/restaurant/dashboard">Restaurant</a>
        <% } %>
        <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            <button class="btn secondary" type="submit">Logout</button>
        </form>
    </div>
</div>
<div class="container">
<section class="hero">
    <h1>Welcome to Food Delivery Management System</h1>
    <p>Browse restaurants, choose your favourite food, add items to your cart and place an order easily.</p>
    <a class="btn" href="${pageContext.request.contextPath}/restaurants">Browse Restaurants</a>
</section>

<h2>How it works</h2>
<div class="grid">
    <div class="card"><h3>1. Choose Restaurant</h3><p>View available restaurants and ratings.</p></div>
    <div class="card"><h3>2. Select Food</h3><p>Open the menu and add food items to your cart.</p></div>
    <div class="card"><h3>3. Place Order</h3><p>Review your cart and place the order.</p></div>
    <div class="card"><h3>4. Track Status</h3><p>View your order history and status.</p></div>
</div>
</div>
<div class="footer">Food Delivery Management System • Spring Boot + JSP + JPA + Spring Security</div>
</body>
</html>
