<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Meciurile Mele - CF Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/profile"><i class="bi bi-card-list"></i> Meciurile Mele Organizate</a>
        <a href="/profile" class="btn btn-outline-light btn-sm">Înapoi la Profil</a>
    </div>
</nav>

<div class="container mt-5" style="max-width: 900px;">
    <div class="mb-4 d-flex justify-content-between align-items-center">
        <div>
            <h2 class="text-primary mb-1">Meciurile Organizate de Mine 🏟️</h2>
            <p class="text-muted mb-0">Aici poți introduce rezultatele finale pentru a încheia meciurile active și a actualiza statisticile.</p>
        </div>
        <a href="/create-match" class="btn btn-primary shadow-sm"><i class="bi bi-plus-circle"></i> Meci Nou</a>
    </div>

    <div class="row g-4">
        <c:forEach var="m" items="${myMatches}">
            <div class="col-12">
                <div class="card shadow-sm border-0 border-start ${m.status == 'ACTIVE' ? 'border-success' : 'border-secondary'} border-4">
                    <div class="card-body p-4">
                        <div class="row align-items-center">
                            
                            <div class="col-md-5">
                                <h5 class="text-dark fw-bold mb-2"><i class="bi bi-geo-alt-fill text-danger"></i> ${m.pitch.name}</h5>
                                <p class="text-muted mb-1 small"><i class="bi bi-building"></i> ${m.pitch.address}</p>
                                <span class="badge bg-light text-dark border fs-6 py-1 px-2 mt-1">
                                    <i class="bi bi-calendar2-event text-primary"></i> ${m.matchDate} | <i class="bi bi-clock text-warning"></i> ${m.matchTime}
                                </span>
                            </div>
                            
                            <div class="col-md-4 text-md-center my-3 my-md-0">
                                <span class="d-block text-secondary small mb-1">Status Meci:</span>
                                <c:choose>
                                    <c:when test="${m.status == 'ACTIVE'}">
                                        <span class="badge bg-success fs-6"><i class="bi bi-play-circle"></i> ACTIV</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary fs-6 mb-1"><i class="bi bi-check2-all"></i> FINALIZAT</span>
                                        <h4 class="mb-0 text-dark fw-bold mt-1">${m.scoreA} - ${m.scoreB}</h4>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <div class="col-md-3 text-md-end">
                                <c:if test="${m.status == 'ACTIVE'}">
                                    <a href="/finish-match-form?matchId=${m.id}" class="btn btn-outline-success w-100 fw-bold shadow-sm">
                                        <i class="bi bi-pencil-square"></i> Introdu Scorul
                                    </a>
                                </c:if>
                                <c:if test="${m.status == 'FINISHED'}">
                                    <button class="btn btn-light w-100 disabled" disabled><i class="bi bi-lock"></i> Încheiat</button>
                                </c:if>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty myMatches}">
            <div class="col-12">
                <div class="card shadow-sm border-0 text-center p-5">
                    <div class="card-body">
                        <i class="bi bi-emoji-frown display-1 text-muted"></i>
                        <h4 class="mt-3 text-secondary">Nu ai organizat niciun meci</h4>
                        <p class="text-muted">Fii tu inițiatorul! Deschide un meci nou și invită jucători.</p>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>