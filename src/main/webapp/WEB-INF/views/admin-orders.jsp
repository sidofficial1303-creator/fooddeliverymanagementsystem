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
<h1>All Orders</h1>
<div class="grid">
<%
java.util.List<com.jsp.fdms.entity.Order> list =
    (java.util.List<com.jsp.fdms.entity.Order>) request.getAttribute("orders");
for(com.jsp.fdms.entity.Order o : list) {
%>
<div class="card">
    <h3>Order #<%= o.getId() %></h3>
    <p>User ID: <%= o.getUserId() %></p>
    <p>Total: ₹<%= o.getTotalAmount() %></p>
    <p>Status: <b><%= o.getStatus() %></b></p><p>Payment: <%= o.getPaymentMode() %></p>
    <p>Date: <%= o.getOrderDate() %></p>
    <div class="actions">
        <form action="${pageContext.request.contextPath}/admin/update-status/<%= o.getId() %>/PREPARING" method="post" style="display:inline;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            <button class="btn light" type="submit">Preparing</button>
        </form>
        <form action="${pageContext.request.contextPath}/admin/update-status/<%= o.getId() %>/DELIVERED" method="post" style="display:inline;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            <button class="btn" type="submit">Delivered</button>
        </form>
        <a class="btn secondary" href="${pageContext.request.contextPath}/admin/order-details/<%= o.getId() %>">Details</a>
    </div>
</div>
<% } %>
</div>
</div>
<div class="footer">Food Delivery Management System • Spring Boot + JSP + JPA + Spring Security</div>
</body>
</html>
