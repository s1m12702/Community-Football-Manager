<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Raport Meci</title></head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Finalizare Meci: ${match.matchDate} la ${match.pitch.name}</h2>
    
    <c:if test="${not empty error}">
        <p style="color: red; font-weight: bold;">❌ ${error}</p>
    </c:if>

    <form action="/finish-match" method="post">
        <input type="hidden" name="matchId" value="${match.id}">
        
        <h3>1. Scorul Final</h3>
        <input type="number" name="scoreA" placeholder="Echipa A" required style="width: 80px; padding: 5px;"> 
        - 
        <input type="number" name="scoreB" placeholder="Echipa B" required style="width: 80px; padding: 5px;">
        
        <hr>
        
        <h3>2. Statistici Jucători (Participanți: ${match.participants.size()})</h3>
        <table border="1" cellpadding="8" style="border-collapse: collapse; width: 100%; max-width: 600px;">
            <tr style="background-color: #f2f2f2;">
                <th>Jucător</th>
                <th>Goluri Marcate</th>
                <th>A fost în echipa câștigătoare?</th>
            </tr>
            <c:forEach var="player" items="${match.participants}">
                <tr>
                    <td><strong>${player.username}</strong></td>
                    <td>
                        <input type="number" name="goals_${player.id}" min="0" value="0" style="width: 60px;">
                    </td>
                    <td style="text-align: center;">
                        <input type="checkbox" name="won_${player.id}" value="yes"> Da
                    </td>
                </tr>
            </c:forEach>
        </table>

        <br><br>
        <button type="submit" style="padding: 10px 20px; background-color: #28a745; color: white; border: none; cursor: pointer;">
            Salvează Rezultatele și Finalizează Meciul
        </button>
    </form>
    
    <br>
    <a href="/my-organized-matches">Înapoi la meciurile mele</a>
</body>
</html>