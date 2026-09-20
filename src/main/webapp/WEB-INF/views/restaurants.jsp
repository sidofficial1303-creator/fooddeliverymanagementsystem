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
<h1>Restaurants</h1>
<p>Choose a restaurant to view its menu.</p>
<div class="grid">
<%
java.util.List<com.jsp.fdms.entity.Restaurant> list =
    (java.util.List<com.jsp.fdms.entity.Restaurant>) request.getAttribute("restaurants");

if (list != null && !list.isEmpty()) {
    for(com.jsp.fdms.entity.Restaurant r : list) {
%>
    <div class="card">
        <h3>🍽️ <%= r.getName() %></h3>
        <p>📍 <%= r.getLocation() %></p>
        <p>⭐ <%= r.getRating() %> / 5</p>
        <a class="btn" href="${pageContext.request.contextPath}/menu/<%= r.getId() %>">View Menu</a>
    </div>
<%
    }
} else {
%>
    <div class="empty"><h3>No restaurants available.</h3></div>
<% } %>
</div>
</div>
<div class="footer">Food Delivery Management System • Spring Boot + JSP + JPA + Spring Security</div>
</body>
</html>
