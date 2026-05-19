<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Schimbare Parolă</title></head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Schimbă Parola</h2>
    <% if (request.getAttribute("error") != null) { %> <p style="color: red;"><%= request.getAttribute("error") %></p> <% } %>
    <% if (request.getAttribute("success") != null) { %> <p style="color: green;"><%= request.getAttribute("success") %></p> <% } %>
    
    <form action="/change-password" method="post">
        <label>Parola curentă (veche):</label><br>
        <input type="password" name="oldPassword" required style="padding: 5px;"><br><br>
        
        <label>Parola nouă:</label><br>
        <input type="password" name="newPassword" required style="padding: 5px;"><br><br>
        
        <button type="submit" style="padding: 10px; background-color: #17a2b8; color: white;">Salvează modificarea</button>
    </form>
    <a href="/profile">Înapoi la Profil</a>
</body>
</html>