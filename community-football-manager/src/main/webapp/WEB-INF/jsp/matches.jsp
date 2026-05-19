<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Meciuri Disponibile</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Meciuri Active în Comunitate</h2>
    
    <c:if test="${not empty error}">
        <p style="color: red; font-weight: bold;">❌ ${error}</p>
    </c:if>
    <c:if test="${not empty success}">
        <p style="color: green; font-weight: bold;">✅ ${success}</p>
    </c:if>

    <table border="1" cellpadding="10" style="width: 100%; border-collapse: collapse;">
        <thead>
            <tr style="background-color: #f2f2f2;">
                <th>Data și Ora</th>
                <th>Teren (Locație)</th>
                <th>Organizator</th>
                <th>Locuri Ocupate</th>
                <th>Acțiune</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="m" items="${matches}">
                <tr>
                    <td>${m.matchDate} la ${m.matchTime}</td>
                    <td><strong>${m.pitch.name}</strong><br><small>${m.pitch.address}</small></td>
                    <td>${m.organizer.username}</td>
                    <td>
                        <span style="color: ${m.participants.size() == m.maxParticipants ? 'red' : 'green'}; font-weight: bold;">
                            ${m.participants.size()} / ${m.maxParticipants}
                        </span>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${m.participants.size() < m.maxParticipants}">
                                <form action="/join-match" method="post" style="margin: 0;">
                                    <input type="hidden" name="matchId" value="${m.id}">
                                    <button type="submit" style="background-color: #28a745; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 3px;">
                                        Înscrie-te
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <span style="color: red; font-weight: bold;">Complet</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
    <a href="/profile">Înapoi la Profil</a>
</body>
</html>