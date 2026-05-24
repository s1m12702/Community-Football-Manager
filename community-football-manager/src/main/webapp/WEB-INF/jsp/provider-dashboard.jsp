<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Panou Furnizor - CF Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-warning shadow-sm">
    <div class="container">
        <a class="navbar-brand text-dark fw-bold" href="/profile"><i class="bi bi-building"></i> Panou Manager Terenuri</a>
        <a href="/profile" class="btn btn-outline-dark btn-sm fw-bold">Înapoi la Profil</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="text-dark mb-1">Baza ta Sportivă 🏟️</h2>
            <p class="text-muted mb-0">Gestionează terenurile pe care le deții și configurează disponibilitatea.</p>
        </div>
        <a href="/add-pitch" class="btn btn-warning btn-lg shadow-sm fw-bold text-dark">
            <i class="bi bi-plus-circle-fill"></i> Adăugă Teren Nou
        </a>
    </div>

    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill"></i> ${param.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty param.info}">
        <div class="alert alert-info alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-info-circle-fill"></i> ${param.info}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row g-4">
        
        <div class="col-12 col-xl-5">
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0"><i class="bi bi-card-checklist"></i> Terenurile Tale</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Nume</th>
                                    <th>Locație</th>
                                    <th>Preț</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${pitches}">
                                    <tr>
                                        <td><strong>${p.name}</strong></td>
                                        <td><i class="bi bi-geo-alt text-danger"></i> ${p.address}</td>
                                        <td><span class="text-success fw-bold">${p.pricePerHour} RON</span></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty pitches}">
                                    <tr>
                                        <td colspan="3" class="text-center text-muted py-4">Nu ai adăugat niciun teren încă.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="card shadow-sm border-0 border-top border-success border-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 text-success"><i class="bi bi-clock-history"></i> Pune la dispoziție un interval</h5>
                </div>
                <div class="card-body p-4">
                    <form action="/add-timeslot" method="post">
                        <div class="form-floating mb-3">
                            <select class="form-select" id="pitchId" name="pitchId" required>
                                <option value="" disabled selected>Selectează un teren...</option>
                                <c:forEach var="p" items="${pitches}">
                                    <option value="${p.id}">${p.name}</option>
                                </c:forEach>
                            </select>
                            <label for="pitchId">Pentru care teren?</label>
                        </div>
                        
                        <div class="form-floating mb-3">
                            <input type="date" class="form-control" id="date" name="date" required>
                            <label for="date">Data (ex: Mâine)</label>
                        </div>

                        <div class="row g-2 mb-4">
                            <div class="col-6 form-floating">
                                <input type="time" class="form-control" id="start" name="start" required>
                                <label for="start">De la ora...</label>
                            </div>
                            <div class="col-6 form-floating">
                                <input type="time" class="form-control" id="end" name="end" required>
                                <label for="end">Până la ora...</label>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-success w-100 fw-bold">
                            <i class="bi bi-calendar-plus"></i> Salvează Disponibilitatea
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-12 col-xl-7">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-secondary text-white py-3">
                    <h5 class="mb-0"><i class="bi bi-calendar-event"></i> Cereri de Rezervare Primite</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Teren & Data</th>
                                    <th>Client</th>
                                    <th>Status</th>
                                    <th class="text-center">Acțiuni (Aprobă/Respinge)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="r" items="${requests}">
                                    <tr>
                                        <td>
                                            <strong>${r.timeSlot.pitch.name}</strong><br>
                                            <small class="text-dark fw-bold"><i class="bi bi-calendar3"></i> ${r.timeSlot.slotDate}</small><br>
                                            <small class="text-muted"><i class="bi bi-clock"></i> ${r.timeSlot.startTime} - ${r.timeSlot.endTime}</small>
                                        </td>
                                        <td>${r.player.username}</td>
                                        <td>
                                            <span class="badge ${r.status == 'CONFIRMED' ? 'bg-success' : (r.status == 'REJECTED' ? 'bg-danger' : 'bg-warning text-dark')}">
                                                ${r.status}
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <c:if test="${r.status == 'PENDING'}">
                                                <div class="d-flex flex-column gap-2 align-items-center">
                                                    <form action="/confirm-reservation" method="post" class="m-0 w-100">
                                                        <input type="hidden" name="reservationId" value="${r.id}">
                                                        <button type="submit" class="btn btn-sm btn-success w-100 fw-bold">
                                                            <i class="bi bi-check-lg"></i> Aprobă
                                                        </button>
                                                    </form>

                                                    <form action="/reject-reservation" method="post" class="m-0 w-100 d-flex gap-1">
                                                        <input type="hidden" name="reservationId" value="${r.id}">
                                                        <input type="text" name="reason" class="form-control form-control-sm" placeholder="Motiv" required>
                                                        <button type="submit" class="btn btn-sm btn-danger fw-bold">
                                                            <i class="bi bi-x-lg"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </c:if>
                                            <c:if test="${r.status != 'PENDING'}">
                                                <span class="text-muted small">Procesat</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty requests}">
                                    <tr>
                                        <td colspan="4" class="text-center text-muted py-5">Nu există nicio cerere de rezervare în acest moment.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>