<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Acordă Feedback - CF Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-success shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/profile"><i class="bi bi-star-half"></i> Evaluare Participanți</a>
        <a href="/my-history" class="btn btn-outline-light btn-sm">Înapoi la Istoric</a>
    </div>
</nav>

<div class="container mt-5" style="max-width: 800px;">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white py-3">
            <h4 class="mb-0 text-success text-center">Meci din data: ${match.matchDate}</h4>
        </div>
        <div class="card-body p-4">
            
            <% if (request.getParameter("success") != null) { %>
                <div class="alert alert-success" role="alert">
                    <i class="bi bi-check-circle"></i> <%= request.getParameter("success") %>
                </div>
            <% } %>
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger" role="alert">
                    <i class="bi bi-exclamation-triangle"></i> ${param.error}
                </div>
            </c:if>

            <p class="text-muted text-center mb-4">Alege tipul de apreciere meritat de fiecare participant în parte:</p>

            <div class="list-group">
                <c:forEach var="player" items="${match.participants}">
                    <div class="list-group-item d-flex justify-content-between align-items-center py-3">
                        <div>
                            <i class="bi bi-person-fill text-secondary me-2"></i>
                            <span class="fw-bold fs-5">${player.username}</span>
                        </div>
                        
                        <div>
                            <c:choose>
                                <c:when test="${player.id == myId}">
                                    <span class="text-muted shadow-none bg-light px-3 py-2 rounded">
                                        <i class="bi bi-person-x"></i> Nu te poți autoevalua
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <form action="/submit-feedback" method="post" class="row g-2 align-items-center m-0">
                                        <input type="hidden" name="targetUserId" value="${player.id}">
                                        <input type="hidden" name="matchId" value="${match.id}">
                                        
                                        <div class="col-auto">
                                            <select name="type" class="form-select form-select-sm" required>
                                                <option value="" disabled selected>Alege insigna...</option>
                                                <option value="fairplay">🤝 Fair-Play</option>
                                                <option value="skill">🔥 Abilitate (Skill)</option>
                                                <option value="punctuality">⏰ Punctualitate</option>
                                            </select>
                                        </div>
                                        <div class="col-auto">
                                            <button type="submit" class="btn btn-sm btn-warning fw-bold text-dark px-3">
                                                Trimite
                                            </button>
                                        </div>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>