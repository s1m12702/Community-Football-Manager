<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Organizează Meci</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Creare Meci Nou</h2>
    
    <c:if test="${not empty success}">
        <p style="color: green; font-weight: bold;">${success}</p>
    </c:if>

    <c:if test="${not empty error}">
        <p style="color: red; font-weight: bold;">❌ ${error}</p>
    </c:if>

    <form action="/create-match" method="post" style="max-width: 400px;">
        <label>Data Meciului:</label><br>
        <input type="date" name="matchDate" required style="width: 100%; padding: 8px; margin-bottom: 15px;"><br>

        <label>Ora de începere:</label><br>
        <input type="time" name="matchTime" required style="width: 100%; padding: 8px; margin-bottom: 15px;"><br>

        <label>Selectează Terenul:</label><br>
        <select name="pitchId" required style="width: 100%; padding: 8px; margin-bottom: 15px;">
            <option value="" disabled selected>Alege un teren din listă...</option>
            <c:forEach var="p" items="${pitches}">
                <option value="${p.id}">
                    ${p.name} - ${p.address} (${p.pricePerHour} RON/h)
                </option>
            </c:forEach>
        </select><br>

        <label>Număr maxim de jucători:</label><br>
        <input type="number" name="maxParticipants" min="2" max="22" value="10" required style="width: 100%; padding: 8px; margin-bottom: 20px;"><br>

        <button type="submit" style="padding: 10px 20px; background-color: #28a745; color: white; border: none; cursor: pointer; width: 100%;">
            Publică Evenimentul
        </button>
    </form>

    <br>
    <a href="/profile">Înapoi la Profil</a>
</body>
</html>