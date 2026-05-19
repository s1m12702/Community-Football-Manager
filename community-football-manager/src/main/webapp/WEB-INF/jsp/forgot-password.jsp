<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Resetare Parolă</title></head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Recuperare Cont</h2>
    <% if (request.getAttribute("error") != null) { %> <p style="color: red;"><%= request.getAttribute("error") %></p> <% } %>
    <% if (request.getAttribute("success") != null) { %> <p style="color: green;"><%= request.getAttribute("success") %></p> <% } %>
    
    <form action="/forgot-password" method="post">
        <label>Introdu email-ul contului:</label><br>
        <input type="email" name="email" required style="padding: 5px;"><br><br>
        <button type="submit" style="padding: 10px; background-color: #ffc107;">Resetează Parola</button>
    </form>
    <a href="/login">Înapoi la Autentificare</a>
</body>
</html>