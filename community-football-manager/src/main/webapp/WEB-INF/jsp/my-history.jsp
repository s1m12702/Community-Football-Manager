<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Istoric Meciuri - CF Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-success shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/profile"><i class="bi bi-clock-history"></i> Istoricul Meu</a>
        <a href="/profile" class="btn btn-outline-light btn-sm">Înapoi la Profil</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="card shadow-sm border-0">
        <div class="card-body p-5">
            <h3 class="text-success mb-3">⚽ Istoricul Meciurilor Mele</h3>
            <p class="text-muted">Aici găsești toate meciurile finalizate la care ai participat. Apasă pe butonul albastru pentru a evalua comportamentul și abilitățile colegilor tăi.</p>
            <hr class="mb-4">

            <div class="table-responsive">
                <table class="table table-striped align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>Data Meciului</th>
                            <th>Teren / Locație</th>
                            <th>Scor Final</th>
                            <th class="text-center">Acțiune</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="m" items="${pastMatches}">
                            <tr>
                                <td><i class="bi bi-calendar-check"></i> ${m.matchDate}</td>
                                <td><strong>${m.pitch.name}</strong></td>
                                <td>
                                    <span class="badge bg-secondary fs-6 px-3 py-2">
                                        ${m.scoreA} - ${m.scoreB}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <a href="/feedback?matchId=${m.id}" class="btn btn-primary btn-sm px-3 shadow-sm">
                                        <i class="bi bi-star-fill"></i> Evaluează Jucători
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty pastMatches}">
                            <tr>
                                <td colspan="4" class="text-center text-muted py-4">Nu ai participat la niciun meci finalizat până acum.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>