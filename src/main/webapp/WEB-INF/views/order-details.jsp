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
<h1>Order Details</h1>
<div class="grid">
<%
java.util.List<com.jsp.fdms.entity.OrderItem> list =
    (java.util.List<com.jsp.fdms.entity.OrderItem>) request.getAttribute("items");

if(list != null && !list.isEmpty()) {
    for(com.jsp.fdms.entity.OrderItem i : list) {
%>
    <div class="card">
        <h3><%= i.getFoodName() %></h3>
        <p>Price: ₹<%= i.getPrice() %></p>
        <p>Quantity: <%= i.getQuantity() %></p>
        <p>Subtotal: ₹<%= i.getPrice() * i.getQuantity() %></p>
    </div>
<%
    }
} else {
%>
    <div class="empty"><h3>No items found for this order.</h3></div>
<% } %>
</div>
<a class="btn secondary" href="${pageContext.request.contextPath}/orders">Back to Orders</a>
</div>
<div class="footer">Food Delivery Management System • Spring Boot + JSP + JPA + Spring Security</div>
</body>
</html>
