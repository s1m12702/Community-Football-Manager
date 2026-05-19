<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<body style="font-family: Arial; margin: 40px;">
    <h1>🛡️ Panou Moderare Administrator</h1>

    <c:if test="${not empty param.success}">
        <div style="background-color: #d4edda; color: #155724; padding: 10px; margin-bottom: 20px; border: 1px solid #c3e6cb; border-radius: 5px;">
            ✅ ${param.success}
        </div>
    </c:if>

    <h3>👥 Gestionare Utilizatori</h3>
    <table border="1" cellpadding="10" style="width:100%; border-collapse: collapse;">
        <tr style="background: #eee;">
            <th>Username</th><th>Email</th><th>Rol</th><th>Status</th><th>Acțiuni</th>
        </tr>
        <c:forEach var="u" items="${users}">
            <tr>
                <td>${u.username}</td>
                <td>${u.email}</td>
                <td>${u.role}</td>
                <td>${u.suspended ? '🔴 SUSPENDAT' : '🟢 ACTIV'}</td>
                <td>
                    <c:if test="${u.role != 'ADMIN'}">
                        <c:choose>
                            <c:when test="${u.suspended}">
                                <form action="/admin/unsuspend-user" method="post" style="margin:0;">
                                    <input type="hidden" name="userId" value="${u.id}">
                                    <button type="submit" style="background: #28a745; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 3px;">
                                        🔓 Ridică Suspendarea
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <form action="/admin/suspend-user" method="post" style="margin:0;">
                                    <input type="hidden" name="userId" value="${u.id}">
                                    <input type="text" name="reason" placeholder="Motiv suspendare" required style="padding: 4px;">
                                    <button type="submit" style="background: #dc3545; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 3px;">
                                        🚫 Suspendă
                                    </button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>

    <h3>⚽ Gestionare Meciuri Active</h3>
    <table border="1" cellpadding="10" style="width:100%; border-collapse: collapse; margin-top:20px;">
        <tr style="background: #eee;">
            <th>ID</th><th>Locație</th><th>Dată/Oră</th><th>Acțiuni</th>
        </tr>
        <c:forEach var="m" items="${matches}">
            <tr>
                <td>${m.id}</td>
                <td>${m.pitch.name}</td>
                <td>${m.matchDate} - ${m.matchTime}</td>
                <td>
                    <form action="/admin/delete-match" method="post" style="margin:0;">
                        <input type="hidden" name="matchId" value="${m.id}">
                        <button type="submit" onclick="return confirm('Sigur ștergi acest meci?')" style="background:orange;">Șterge Meci</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
    <br><a href="/profile">Înapoi la profil</a>
</body>
</html>