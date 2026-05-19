<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Adăugare Teren Nou</title></head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Înregistrează un Teren de Fotbal</h2>
    
    <% if (request.getAttribute("success") != null) { %> 
        <p style="color: green; font-weight: bold;"><%= request.getAttribute("success") %></p> 
    <% } %>
    
    <form action="/add-pitch" method="post" style="max-width: 300px;">
        <label>Nume Teren (ex: Arena Sintetic):</label><br>
        <input type="text" name="name" required style="width: 100%; padding: 5px;"><br><br>

        <label>Adresa:</label><br>
        <input type="text" name="address" required style="width: 100%; padding: 5px;"><br><br>

        <label>Preț pe Oră (RON):</label><br>
        <input type="number" name="pricePerHour" step="0.5" required style="width: 100%; padding: 5px;"><br><br>

        <button type="submit" style="padding: 10px 20px; background-color: #007bff; color: white; border: none;">Salvează Teren</button>
    </form>
    <br>
    <a href="/profile">Înapoi la Profil</a>
</body>
</html>