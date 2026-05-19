<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Istoric Meciuri</title></head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Istoricul Meciurilor Mele</h2>
    <p>Meciurile finalizate la care ai participat. Apasă pe "Evaluează Jucători" pentru a acorda insigne de reputație.</p>

    <table border="1" cellpadding="10" style="width: 100%; border-collapse: collapse;">
        <tr style="background-color: #f2f2f2;">
            <th>Data</th>
            <th>Teren</th>
            <th>Scor Final</th>
            <th>Acțiune</th>
        </tr>
        <c:forEach var="m" items="${pastMatches}">
            <tr>
                <td>${m.matchDate}</td>
                <td>${m.pitch.name}</td>
                <td><strong>${m.scoreA} - ${m.scoreB}</strong></td>
                <td>
                    <a href="/feedback?matchId=${m.id}" style="background-color: #17a2b8; color: white; padding: 5px 10px; text-decoration: none; border-radius: 3px;">🌟 Evaluează Jucători</a>
                </td>
            </tr>
        </c:forEach>
    </table>
    <br><a href="/profile">Înapoi la Profil</a>
</body>
</html>