<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Raport Meci - CF Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-success shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/my-organized-matches"><i class="bi bi-arrow-left-short fs-4"></i> Meciurile Mele</a>
    </div>
</nav>

<div class="container mt-5" style="max-width: 800px;">
    
    <div class="card shadow-sm border-0">
        <div class="card-header bg-dark text-white text-center py-4">
            <h3 class="mb-0">Finalizare Meci</h3>
            <p class="mb-0 fw-light"><i class="bi bi-calendar"></i> ${match.matchDate} | <i class="bi bi-geo-alt"></i> ${match.pitch.name}</p>
        </div>
        <div class="card-body p-4 p-md-5">

            <c:if test="${not empty error}">
                <div class="alert alert-danger shadow-sm" role="alert">
                    <i class="bi bi-exclamation-triangle-fill"></i> ${error}
                </div>
            </c:if>

            <form action="/finish-match" method="post">
                <input type="hidden" name="matchId" value="${match.id}">
                
                <h5 class="text-success mb-3"><i class="bi bi-1-circle-fill"></i> Scorul Final</h5>
                <div class="row align-items-center justify-content-center mb-5 bg-light p-4 rounded-3 border">
                    <div class="col-auto">
                        <div class="form-floating">
                            <input type="number" class="form-control text-center fs-4 fw-bold" id="scoreA" name="scoreA" placeholder="0" min="0" required style="width: 100px;">
                            <label for="scoreA">Echipa A</label>
                        </div>
                    </div>
                    <div class="col-auto">
                        <h2 class="text-muted mb-0">-</h2>
                    </div>
                    <div class="col-auto">
                        <div class="form-floating">
                            <input type="number" class="form-control text-center fs-4 fw-bold" id="scoreB" name="scoreB" placeholder="0" min="0" required style="width: 100px;">
                            <label for="scoreB">Echipa B</label>
                        </div>
                    </div>
                </div>
                
                <h5 class="text-success mb-3"><i class="bi bi-2-circle-fill"></i> Statistici Jucători (Participanți: ${match.participants.size()})</h5>
                <div class="table-responsive mb-4">
                    <table class="table table-bordered table-hover align-middle">
                        <thead class="table-light text-center">
                            <tr>
                                <th class="text-start">Nume Jucător</th>
                                <th>Goluri Marcate</th>
                                <th>Echipa Câștigătoare?</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="player" items="${match.participants}">
                                <tr>
                                    <td><i class="bi bi-person-circle text-secondary me-2"></i> <strong>${player.username}</strong></td>
                                    <td class="text-center">
                                        <input type="number" class="form-control form-control-sm mx-auto text-center" name="goals_${player.id}" min="0" value="0" style="width: 80px;">
                                    </td>
                                    <td class="text-center">
                                        <div class="form-check form-switch d-flex justify-content-center">
                                            <input class="form-check-input fs-5" type="checkbox" name="won_${player.id}" value="yes" id="won_${player.id}">
                                            <label class="form-check-label ms-2 d-none" for="won_${player.id}">Da</label>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="d-grid mt-5">
                    <button type="submit" class="btn btn-success btn-lg fw-bold shadow-sm">
                        <i class="bi bi-check-circle"></i> Salvează Rezultatele și Finalizează
                    </button>
                </div>
            </form>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>