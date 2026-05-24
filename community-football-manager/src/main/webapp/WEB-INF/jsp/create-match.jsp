<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Creează Meci - CF Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-success shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/profile"><i class="bi bi-dribbble"></i> Organizați Meci</a>
        <a href="/profile" class="btn btn-outline-light btn-sm">Înapoi la Profil</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h4 class="mb-0 text-center"><i class="bi bi-plus-circle-fill text-success"></i> Organizează un Meci Nou</h4>
                </div>
                <div class="card-body p-4 p-md-5">

                    <%-- Mesaje de eroare / succes --%>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="bi bi-exclamation-triangle"></i> ${error}
                        </div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success" role="alert">
                            <i class="bi bi-check-circle"></i> ${success}
                        </div>
                    </c:if>

                    <p class="text-muted text-center mb-4">Setează detaliile evenimentului sportiv pentru ca alți membri ai comunității să se poată înscrie.</p>

                    <form action="/create-match" method="post">
                        <div class="form-floating mb-3">
                            <select class="form-select" id="pitchId" name="pitchId" required>
                                <option value="" disabled selected>Alege locația...</option>
                                <c:forEach var="p" items="${pitches}">
                                    <option value="${p.id}">${p.name} (${p.address})</option>
                                </c:forEach>
                            </select>
                            <label for="pitchId">Teren disponibil</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="date" class="form-control" id="matchDate" name="matchDate" required>
                            <label for="matchDate">Data meciului</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="time" class="form-control" id="matchTime" name="matchTime" required>
                            <label for="matchTime">Ora de începere</label>
                        </div>

                        <div class="form-floating mb-4">
                            <input type="number" class="form-control" id="maxParticipants" name="maxParticipants" min="2" placeholder="Număr maxim de jucători" required>
                            <label for="maxParticipants">Număr maxim de jucători (ex: 10, 12, 14)</label>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success btn-lg fw-bold shadow-sm">
                                <i class="bi bi-calendar-plus"></i> Publică Evenimentul
                            </button>
                            <a href="/profile" class="btn btn-outline-secondary">
                                Revino la profil
                            </a>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>