<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Meciurile Mele Organizate</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Meciurile organizate de mine</h2>
    <p>Aici poți introduce rezultatele finale pentru a încheia meciurile active și a actualiza statisticile jucătorilor.</p>

    <table border="1" cellpadding="10" style="width: 100%; border-collapse: collapse;">
        <thead>
            <tr style="background-color: #f2f2f2;">
                <th>Data și Ora</th>
                <th>Teren (Locație)</th>
                <th>Status</th>
                <th>Scor Final</th>
                <th>Acțiune</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="m" items="${myMatches}">
                <tr>
                    <td>${m.matchDate} la ${m.matchTime}</td>
                    <td><strong>${m.pitch.name}</strong><br><small>${m.pitch.address}</small></td>
                    <td>
                        <span style="color: ${m.status == 'ACTIVE' ? 'green' : 'gray'}; font-weight: bold;">
                            ${m.status}
                        </span>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${m.status == 'FINISHED'}">
                                <strong>${m.scoreA} - ${m.scoreB}</strong>
                            </c:when>
                            <c:otherwise>
                                <em>În așteptare</em>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${m.status == 'ACTIVE'}">
                            <a href="/finish-match-form?matchId=${m.id}" style="background-color: #007bff; color: white; padding: 6px 12px; text-decoration: none; border-radius: 4px; font-weight: bold;">
                                Introdu Rezultate
                            </a>
                        </c:if>
                        <c:if test="${m.status == 'FINISHED'}">
                            <span style="color: #666; font-weight: bold;">✔ Meci încheiat</span>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
    <a href="/profile">Înapoi la Profil</a>
</body>
</html>