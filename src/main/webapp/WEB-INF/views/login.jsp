<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - FDMS</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="form-card">
    <h1>🍴 FDMS Login</h1>
    <p>Login to order food and manage your account.</p>

    <% if ("true".equals(request.getParameter("error"))) { %>
        <div class="alert">Invalid email or password.</div>
    <% } %>

    <p style="color:green">${msg}</p>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" required>
        </div>

        <button class="btn" type="submit">Login</button>
        <a class="btn light" href="${pageContext.request.contextPath}/register">Register</a>
    </form>

    <hr>
    <p><b>Demo Admin:</b> admin@fdms.com / admin123</p>
    <p><b>Demo Restaurant:</b> restaurant@fdms.com / restaurant123</p>
</div>
</body>
</html>
