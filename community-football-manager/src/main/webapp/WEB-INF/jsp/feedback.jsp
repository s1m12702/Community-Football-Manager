<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Acordare Feedback</title></head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Feedback Meci: ${match.matchDate}</h2>
    
    <% if (request.getParameter("success") != null) { %>
        <p style="color: green; font-weight: bold;"><%= request.getParameter("success") %></p>
    <% } %>

    <c:if test="${not empty param.error}">
        <p style="color: red; font-weight: bold;">❌ ${param.error}</p>
    </c:if>
    
    <table border="1" cellpadding="10" style="width: 100%; max-width: 600px; border-collapse: collapse;">
        <tr style="background-color: #f2f2f2;">
            <th>Jucător</th>
            <th>Acordă Insignă de Reputație</th>
        </tr>
        <c:forEach var="player" items="${match.participants}">
            <tr>
                <td><strong>${player.username}</strong></td>
                <td>
                    <c:choose>
                        <c:when test="${player.id == myId}">
                            <span style="color: gray;"><em>Nu te poți autoevalua</em></span>
                        </c:when>
                        <c:otherwise>
                            <form action="/submit-feedback" method="post" style="margin: 0;">
                                <input type="hidden" name="targetUserId" value="${player.id}">
                                <input type="hidden" name="matchId" value="${match.id}">
                                <select name="type" required style="padding: 5px;">
                                    <option value="" disabled selected>Alege insigna...</option>
                                    <option value="fairplay">🤝 Fair-Play</option>
                                    <option value="skill">🔥 Abilitate (Skill)</option>
                                    <option value="punctuality">⏰ Punctualitate</option>
                                </select>
                                <button type="submit" style="background-color: #ffc107; border: none; padding: 5px 10px; cursor: pointer;">Oferă</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
    <br>
    <a href="/my-history">Înapoi la Istoric</a>
</body>
</html>