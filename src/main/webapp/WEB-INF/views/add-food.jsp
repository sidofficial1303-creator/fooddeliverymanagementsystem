<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FDMS</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
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
<div class="form-card" style="margin-top:0;">
<h1>Add Food Item</h1>
<form action="${pageContext.request.contextPath}/restaurant/add-food" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
<div class="form-group"><label>Food Name</label><input type="text" name="name" required></div>
<div class="form-group"><label>Price</label><input type="number" name="price" min="1" step="0.01" required></div>
<div class="form-group"><label>Category</label><input type="text" name="category" placeholder="Veg / Non-Veg / Dessert" required></div>
<div class="form-group"><label>Restaurant</label>
<select name="restaurantId" required>
<%
java.util.List<com.jsp.fdms.entity.Restaurant> list =
    (java.util.List<com.jsp.fdms.entity.Restaurant>) request.getAttribute("restaurants");
for(com.jsp.fdms.entity.Restaurant r : list) {
%>
<option value="<%= r.getId() %>"><%= r.getName() %></option>
<% } %>
</select>
</div>
<button class="btn" type="submit">Add Food</button>
<a class="btn secondary" href="${pageContext.request.contextPath}/restaurant/dashboard">Cancel</a>
</form>
</div>
</div>
<div class="footer">Food Delivery Management System • Spring Boot + JSP + JPA + Spring Security</div>
</body>
</html>
