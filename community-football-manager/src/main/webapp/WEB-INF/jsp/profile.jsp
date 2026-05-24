<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Profilul Meu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-success shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/profile"><i class="bi bi-dribbble"></i> CF Manager</a>
        <div class="d-flex">
            <span class="navbar-text me-3 text-white">Salut, <strong>${loggedInUser.username}</strong>!</span>
            <a href="/logout" class="btn btn-outline-light btn-sm">Deconectare</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white">
                    <h5 class="mb-0">⚙️ Acțiuni Rapide</h5>
                </div>
                <div class="list-group list-group-flush">
                    <a href="/view-pitches" class="list-group-item list-group-item-action"><i class="bi bi-calendar-check"></i> Rezervă Teren </a>
                    <a href="/matches" class="list-group-item list-group-item-action"><i class="bi bi-dribbble text-success"></i> Meciuri Disponibile</a>
                    <a href="/my-matches" class="list-group-item list-group-item-action fw-bold"><i class="bi bi-card-list text-primary"></i> Meciurile Mele</a>
                    <a href="/create-match" class="list-group-item list-group-item-action"><i class="bi bi-plus-circle"></i> Creează Meci </a>
                    <a href="/my-history" class="list-group-item list-group-item-action list-group-item-info"><i class="bi bi-star"></i> Istoricul Meu </a>
                    <a href="/change-password" class="list-group-item list-group-item-action text-secondary"><i class="bi bi-key"></i> Schimbă Parola</a>
                    
                    <c:if test="${loggedInUser.role.name() == 'ADMIN'}">
                        <a href="/admin-dashboard" class="list-group-item list-group-item-action list-group-item-danger"><i class="bi bi-shield-lock"></i> Panou Admin</a>
                    </c:if>
                    <c:if test="${loggedInUser.role.name() == 'PITCH_PROVIDER'}">
                        <a href="/provider-dashboard" class="list-group-item list-group-item-action list-group-item-warning"><i class="bi bi-building"></i> Panou Terenuri</a>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-body">
                    <h3 class="card-title text-success">Performanțele tale 🏆</h3>
                    <hr>
                    <div class="row text-center mt-4">
                        <div class="col-4">
                            <h2 class="display-5 text-primary">${loggedInUser.matchesPlayed}</h2>
                            <p class="text-muted">Meciuri Jucate</p>
                        </div>
                        <div class="col-4">
                            <h2 class="display-5 text-success">${loggedInUser.victories}</h2>
                            <p class="text-muted">Victorii</p>
                        </div>
                        <div class="col-4">
                            <h2 class="display-5 text-danger">${loggedInUser.goalsScored}</h2>
                            <p class="text-muted">Goluri Marcate</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card shadow-sm border-0">
                <div class="card-body">
                    <h4 class="card-title text-info">Reputație & Feedback 🌟</h4>
                    <p class="text-muted">Insignele primite de la alți jucători:</p>
                    
                    <button class="btn btn-outline-secondary me-2 mb-2">
                        🤝 Fair-Play <span class="badge bg-secondary ms-1">${loggedInUser.fairPlayVotes}</span>
                    </button>
                    <button class="btn btn-outline-primary me-2 mb-2">
                        🔥 Skill <span class="badge bg-primary ms-1">${loggedInUser.skillVotes}</span>
                    </button>
                    <button class="btn btn-outline-warning mb-2">
                        ⏰ Punctualitate <span class="badge bg-warning text-dark ms-1">${loggedInUser.punctualityVotes}</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>