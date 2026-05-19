<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Admin Furnizor - CFM</title></head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Panou Administrare Baze Sportive</h2>

    <c:if test="${not empty param.success}">
        <p style="color: green; font-weight: bold;">✅ ${param.success}</p>
    </c:if>
    <c:if test="${not empty param.info}">
        <p style="color: blue; font-weight: bold;">ℹ️ ${param.info}</p>
    </c:if>

    <div style="display: flex; gap: 40px;">
        <div style="flex: 1; border: 1px solid #ddd; padding: 20px; border-radius: 8px;">
            <h3>➕ Configurează Disponibilitate</h3>
            <form action="/add-timeslot" method="post">
                <label>Alege Terenul:</label><br>
                <select name="pitchId" required style="width: 100%; padding: 5px;">
                    <c:forEach var="p" items="${pitches}">
                        <option value="${p.id}">${p.name}</option>
                    </c:forEach>
                </select><br><br>
                
                <label>Data:</label><br>
                <input type="date" name="date" required style="width: 100%; padding: 5px;"><br><br>
                
                <label>Interval (Start - Final):</label><br>
                <input type="time" name="start" required> - <input type="time" name="end" required><br><br>
                
                <button type="submit" style="background: #28a745; color: white; border: none; padding: 10px; width: 100%; border-radius: 5px; cursor: pointer;">
                    Adaugă Interval Liber
                </button>
            </form>
        </div>

        <div style="flex: 2; border: 1px solid #ddd; padding: 20px; border-radius: 8px;">
            <h3>📋 Solicitări de Rezervare</h3>
            <table border="1" cellpadding="10" style="width: 100%; border-collapse: collapse;">
                <tr style="background: #f2f2f2;">
                    <th>Jucător</th>
                    <th>Teren / Dată</th>
                    <th>Interval</th>
                    <th>Status</th>
                    <th>Acțiuni</th>
                </tr>
                <c:forEach var="r" items="${requests}">
                    <tr>
                        <td>${r.player.username}</td>
                        <td><strong>${r.timeSlot.pitch.name}</strong><br><small>${r.timeSlot.slotDate}</small></td>
                        <td>${r.timeSlot.startTime} - ${r.timeSlot.endTime}</td>
                        <td>
                            <span style="color: ${r.status == 'CONFIRMED' ? 'green' : (r.status == 'REJECTED' ? 'red' : 'orange')}; font-weight: bold;">
                                ${r.status}
                            </span>
                            <c:if test="${not empty r.rejectionReason}">
                                <br><small>Motiv: ${r.rejectionReason}</small>
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${r.status == 'PENDING'}">
                                <form action="/confirm-reservation" method="post" style="display:inline; margin-right: 5px;">
                                    <input type="hidden" name="reservationId" value="${r.id}">
                                    <button type="submit" style="background: #28a745; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 3px;">Confirmă</button>
                                </form>
                                <form action="/reject-reservation" method="post" style="display:inline;">
                                    <input type="hidden" name="reservationId" value="${r.id}">
                                    <input type="text" name="reason" placeholder="Motiv respingere..." required style="padding: 4px;">
                                    <button type="submit" style="background: #dc3545; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 3px;">Respinge</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <br><a href="/profile">Înapoi la profil</a>
</body>
</html>