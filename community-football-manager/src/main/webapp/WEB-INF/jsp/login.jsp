<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - Community Football Manager</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">

    <h2>Autentificare</h2>

    <% if (request.getAttribute("error") != null) { %>
        <p style="color: red; font-weight: bold;"><%= request.getAttribute("error") %></p>
    <% } %>

    <form action="/login" method="post" style="max-width: 300px;">
        <label>Email:</label><br>
        <input type="email" name="email" required style="width: 100%; padding: 5px;"><br><br>

        <label>Parolă:</label><br>
        <input type="password" name="password" required style="width: 100%; padding: 5px;"><br><br>

        <button type="submit" style="padding: 10px 20px; background-color: #007bff; color: white; border: none; cursor: pointer;">
            Login
        </button>
    </form>
    
    <p>Nu ai cont? <a href="/register">Înregistrează-te aici</a></p>
    <p><a href="/forgot-password">Am uitat parola</a></p>

</body>
</html>