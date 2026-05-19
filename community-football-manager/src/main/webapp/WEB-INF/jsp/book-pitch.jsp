<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Rezervare Teren</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>📅 Rezervare pentru: <span style="color: #007bff;">${pitch.name}</span></h2>
    <p>Adresa: ${pitch.address}</p>
    <hr>

    <h3>Intervale Libere:</h3>
    
    <c:choose>
        <c:when test="${empty slots}">
            <div style="background-color: #f8d7da; color: #721c24; padding: 15px; border-radius: 5px; border: 1px solid #f5c6cb; width: 50%;">
                Ne pare rău, dar furnizorul nu a adăugat intervale libere pentru acest teren momentan. 
            </div>
        </c:when>
        <c:otherwise>
            <table border="1" cellpadding="10" style="width: 60%; border-collapse: collapse;">
                <thead>
                    <tr style="background-color: #f2f2f2;">
                        <th>Data</th>
                        <th>Interval Orar</th>
                        <th>Acțiune</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="slot" items="${slots}">
                        <tr>
                            <td><strong>${slot.slotDate}</strong></td>
                            <td>${slot.startTime} - ${slot.endTime}</td>
                            <td style="text-align: center;">
                                <form action="/request-reservation" method="post" style="margin: 0;">
                                    <input type="hidden" name="slotId" value="${slot.id}">
                                    <button type="submit" style="background-color: #28a745; color: white; border: none; padding: 8px 15px; border-radius: 4px; cursor: pointer; font-weight: bold;">
                                        Trimite Cerere
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

    <br><br>
    <a href="/view-pitches" style="text-decoration: none; color: #007bff;">⬅ Înapoi la lista de terenuri</a>
</body>
</html>