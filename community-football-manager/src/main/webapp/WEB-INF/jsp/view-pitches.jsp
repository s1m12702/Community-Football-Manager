<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Terenuri Disponibile</title></head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Baza de Date Terenuri</h2>
    <p>Iată terenurile înregistrate în comunitatea noastră:</p>

    <table border="1" cellpadding="10" style="width: 100%; border-collapse: collapse;">
        <thead>
            <tr style="background-color: #f2f2f2;">
                <th>Nume Teren</th>
                <th>Adresă</th>
                <th>Preț / Oră</th>
                <th>Proprietar (Furnizor)</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="p" items="${pitches}">
                <tr>
                    <td><strong>${p.name}</strong></td>
                    <td>${p.address}</td>
                    <td>${p.pricePerHour} RON</td>
                    <td>${p.provider.username}</td>
                    <td>
                        <a href="/book-pitch?pitchId=${p.id}" 
                        style="background-color: #007bff; color: white; padding: 8px 15px; text-decoration: none; border-radius: 5px; font-weight: bold;">
                        📅 Vezi Ore Libere & Rezervă
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
    <a href="/profile">Înapoi la Profil</a>
</body>
</html>