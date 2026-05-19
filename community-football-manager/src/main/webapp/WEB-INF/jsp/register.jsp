<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Înregistrare - Community Football Manager</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">

    <h2>Înregistrare Membru Nou</h2>
    
    <%-- Afișăm erorile dacă există --%>
    <% if (request.getAttribute("error") != null) { %>
        <p style="color: red; font-weight: bold;"><%= request.getAttribute("error") %></p>
    <% } %>

    <%-- Afișăm mesajul de succes dacă există --%>
    <% if (request.getAttribute("success") != null) { %>
        <p style="color: green; font-weight: bold;"><%= request.getAttribute("success") %></p>
    <% } %>

    <form action="/register" method="post" style="max-width: 300px;">
        <label for="username">Username:</label><br>
        <input type="text" id="username" name="username" required style="width: 100%; padding: 5px;"><br><br>

        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" required style="width: 100%; padding: 5px;"><br><br>

        <label for="password">Parolă:</label><br>
        <input type="password" id="password" name="password" required style="width: 100%; padding: 5px;"><br><br>

        <label for="role">Rol:</label><br>
        <select id="role" name="role" style="width: 100%; padding: 5px;">
            <option value="PLAYER">Jucător</option>
            <option value="PITCH_PROVIDER">Furnizor de Terenuri</option>
        </select><br><br>

        <button type="submit" style="padding: 10px 20px; background-color: #28a745; color: white; border: none; cursor: pointer;">
            Înregistrează-te
        </button>
    </form>

</body>
</html>