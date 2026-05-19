<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Comunitate Jucători</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Jucătorii din Comunitate</h2>
    <p>Aici poți vedea toți membrii și le poți acorda un rating de la 1 la 5 stele.</p>

    <c:if test="${not empty error}">
        <p style="color: red; font-weight: bold;">❌ ${error}</p>
    </c:if>
    <c:if test="${not empty success}">
        <p style="color: green; font-weight: bold;">✅ ${success}</p>
    </c:if>

    <table border="1" cellpadding="10" style="width: 100%; border-collapse: collapse;">
        <thead>
            <tr style="background-color: #f2f2f2;">
                <th>Username</th>
                <th>Rol</th>
                <th>Rating Mediu</th>
                <th>Evaluează Jucătorul</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${users}">
                <tr>
                    <td><strong>${u.username}</strong></td>
                    <td>${u.role}</td>
                    <td>
                        <c:choose>
                            <c:when test="${u.ratingCount > 0}">
                                ⭐ <strong>${u.averageRating}</strong> 
                                <span style="color: gray; font-size: 0.8em;">(din ${u.ratingCount} voturi)</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color: gray;">Fără rating încă</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${u.id == sessionScope.loggedInUser.id}">
                                <span style="color: #999; font-style: italic;">Acesta ești tu</span>
                            </c:when>
                            <c:otherwise>
                                <form action="/rate-user" method="post" style="margin: 0;">
                                    <input type="hidden" name="targetUserId" value="${u.id}">
                                    
                                    <select name="stars" required style="padding: 5px;">
                                        <option value="" disabled selected>Alege...</option>
                                        <option value="5">5 - Excelent</option>
                                        <option value="4">4 - Foarte Bun</option>
                                        <option value="3">3 - Bun</option>
                                        <option value="2">2 - Slab</option>
                                        <option value="1">1 - Foarte Slab</option>
                                    </select>
                                    <button type="submit" style="background-color: #ffc107; border: none; padding: 5px 10px; cursor: pointer;">
                                        Evaluează
                                    </button>
                                </form>
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