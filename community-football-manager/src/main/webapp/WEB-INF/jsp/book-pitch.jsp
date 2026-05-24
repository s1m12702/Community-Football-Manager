<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Rezervă Teren - CF Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-success shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/view-pitches"><i class="bi bi-arrow-left-short fs-4"></i> Înapoi la Terenuri</a>
        <a href="/profile" class="btn btn-outline-light btn-sm">Profilul Meu</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h4 class="mb-0 text-center"><i class="bi bi-clock-history text-success"></i> Solicită Rezervare Interval</h4>
                </div>
                <div class="card-body p-4 p-md-5">

                    <%-- Alerte de eroare sau succes --%>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger shadow-sm" role="alert">
                            <i class="bi bi-exclamation-triangle-fill"></i> ${error}
                        </div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success shadow-sm" role="alert">
                            <i class="bi bi-check-circle-fill"></i> ${success}
                        </div>
                    </c:if>

                    <div class="alert alert-info border-0 mb-4 text-center" role="alert">
                        <span class="small text-secondary d-block">Ai selectat terenul:</span>
                        <strong class="fs-4 text-dark d-block my-1">${pitch.name}</strong>
                        <small class="text-muted"><i class="bi bi-geo-alt"></i> ${pitch.address} | <i class="bi bi-tags"></i> ${pitch.pricePerHour} RON/oră</small>
                    </div>

                    <form action="/request-reservation" method="post">
                        <input type="hidden" name="pitchId" value="${pitch.id}">

                        <div class="form-floating mb-4">
                            <select class="form-select" id="slotId" name="slotId" required>
                                <option value="" disabled selected>Alege intervalul orar (Dată și Oră)...</option>
                                <c:forEach var="slot" items="${slots}">
                                    <option value="${slot.id}">${slot.slotDate} | ${slot.startTime} - ${slot.endTime}</option>
                                </c:forEach>
                            </select>
                            <label for="slotId">Intervale Orare Disponibile</label>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success btn-lg fw-bold shadow-sm">
                                <i class="bi bi-send-check"></i> Trimite Cererea de Rezervare
                            </button>
                            <a href="/view-pitches" class="btn btn-outline-secondary">
                                Întoarce-te la listă
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