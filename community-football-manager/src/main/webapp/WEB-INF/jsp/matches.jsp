<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Meciuri Disponibile - CF Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-success shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/profile"><i class="bi bi-dribbble"></i> Meciuri Active</a>
        <a href="/profile" class="btn btn-outline-light btn-sm">Înapoi la Profil</a>
    </div>
</nav>

<div class="container mt-5" style="max-width: 900px;">
    
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="text-success mb-1">Meciuri din Comunitate ⚽</h2>
            <p class="text-muted mb-0">Alătură-te unei echipe și ocupă un loc pe teren înainte de începerea partidei.</p>
        </div>
        <a href="/create-match" class="btn btn-outline-success fw-bold">
            <i class="bi bi-plus-lg"></i> Organizează Tu
        </a>
    </div>

    <%-- Alerte de succes sau eroare --%>
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill"></i> ${param.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill"></i> ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row g-4">
        <c:forEach var="m" items="${matches}">
            <div class="col-12">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-4">
                        <div class="row align-items-center">
                            
                            <div class="col-md-5">
                                <h5 class="text-dark fw-bold mb-2"><i class="bi bi-geo-alt-fill text-danger"></i> ${m.pitch.name}</h5>
                                <p class="text-muted mb-0 small"><i class="bi bi-building"></i> Adresă: ${m.pitch.address}</p>
                                <p class="text-muted mb-0 small"><i class="bi bi-calendar2-week text-primary"></i> Data: <strong>${m.matchDate}</strong></p>
                                <p class="text-muted mb-0 small"><i class="bi bi-clock text-warning"></i> Ora: <strong>${m.matchTime}</strong></p>
                            </div>
                            
                            <div class="col-md-4 my-3 my-md-0">
                                <span class="d-block text-secondary small mb-1">Locuri ocupate:</span>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="badge ${m.participants.size() >= m.maxParticipants ? 'bg-danger' : 'bg-success'} fs-6 py-2 px-3">
                                        ${m.participants.size()} / ${m.maxParticipants} Jucători
                                    </span>
                                    <c:if test="${m.participants.size() >= m.maxParticipants}">
                                        <span class="text-danger fw-bold small">Meci Complet</span>
                                    </c:if>
                                </div>
                            </div>
                            
                            <div class="col-md-3 text-md-end">
                                <form action="/join-match" method="post" class="m-0">
                                    <input type="hidden" name="matchId" value="${m.id}">
                                    <c:choose>
                                        <c:when test="${m.participants.size() >= m.maxParticipants}">
                                            <button type="submit" class="btn btn-secondary w-100 disabled" disabled>
                                                ❌ Ocupat
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="submit" class="btn btn-success w-100 shadow-sm fw-bold">
                                                <i class="bi bi-person-plus"></i> Înscrie-te
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </form>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <%-- Mesaj dacă nu există meciuri create --%>
        <c:if test="${empty matches}">
            <div class="col-12">
                <div class="card shadow-sm border-0 text-center p-5">
                    <div class="card-body">
                        <i class="bi bi-calendar-x display-1 text-muted"></i>
                        <h4 class="mt-3 text-secondary">Nu există meciuri active</h4>
                        <p class="text-muted">Fii tu cel care dă startul! Deschide un meci nou folosind butonul de mai sus.</p>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>