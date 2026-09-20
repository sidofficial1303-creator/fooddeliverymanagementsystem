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
<h1>Admin Dashboard</h1>
<div class="stat-grid">
    <div class="stat"><strong>Admin</strong><span>Management Panel</span></div>
    <div class="stat"><strong>Users</strong><span>Manage customers</span></div>
    <div class="stat"><strong>Orders</strong><span>Update order status</span></div>
</div>
<div class="grid">
    <div class="card"><h3>👥 Users</h3><p>View registered users and roles.</p><a class="btn" href="${pageContext.request.contextPath}/admin/users">View Users</a></div>
    <div class="card"><h3>🍴 Restaurants</h3><p>Add, edit and delete restaurants.</p><a class="btn" href="${pageContext.request.contextPath}/admin/restaurants">Manage Restaurants</a></div>
    <div class="card"><h3>📦 Orders</h3><p>View all orders and update their status.</p><a class="btn" href="${pageContext.request.contextPath}/admin/orders">Manage Orders</a></div>
</div>
</div>
<div class="footer">Food Delivery Management System • Spring Boot + JSP + JPA + Spring Security</div>
</body>
</html>
