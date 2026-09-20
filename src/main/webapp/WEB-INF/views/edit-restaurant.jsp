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
<%
com.jsp.fdms.entity.Restaurant r =
    (com.jsp.fdms.entity.Restaurant) request.getAttribute("restaurant");
%>
<div class="form-card" style="margin-top:0;">
<h1>Edit Restaurant</h1>
<form action="${pageContext.request.contextPath}/admin/update-restaurant" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
<input type="hidden" name="id" value="<%= r.getId() %>">
<div class="form-group"><label>Name</label><input type="text" name="name" value="<%= r.getName() %>" required></div>
<div class="form-group"><label>Location</label><input type="text" name="location" value="<%= r.getLocation() %>" required></div>
<div class="form-group"><label>Rating</label><input type="number" name="rating" min="0" max="5" step="0.1" value="<%= r.getRating() %>" required></div>
<button class="btn" type="submit">Update</button>
<a class="btn secondary" href="${pageContext.request.contextPath}/admin/restaurants">Cancel</a>
</form>
</div>
</div>
<div class="footer">Food Delivery Management System • Spring Boot + JSP + JPA + Spring Security</div>
</body>
</html>
