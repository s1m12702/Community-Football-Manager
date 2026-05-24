<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Terenuri Disponibile - CF Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-success shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/profile"><i class="bi bi-calendar-check"></i> Rezervare Terenuri</a>
        <a href="/profile" class="btn btn-outline-light btn-sm">Înapoi la Profil</a>
    </div>
</nav>

<div class="container mt-5" style="max-width: 1000px;">
    <div class="mb-4">
        <h2 class="text-success mb-1">Terenuri de Fotbal Disponibile 🏟️</h2>
        <p class="text-muted">Alege baza sportivă dorită și verifică intervalele orare libere pentru a plasa o cerere de rezervare (UC8).</p>
    </div>

    <div class="row g-4">
        <c:forEach var="p" items="${pitches}">
            <div class="col-md-6 col-lg-4">
                <div class="card h-100 shadow-sm border-0 rounded-3 overflow-hidden">
                    <div class="bg-dark text-white text-center py-4">
                        <i class="bi bi-dribbble text-success display-4"></i>
                    </div>
                    <div class="card-body p-4 d-flex flex-column">
                        <h4 class="card-title text-dark fw-bold mb-2">${p.name}</h4>
                        <p class="card-text text-muted small flex-grow-1">
                            <i class="bi bi-geo-alt-fill text-danger"></i> Adresă: ${p.address}
                        </p>
                        <div class="border-top pt-3 mt-2">
                            <span class="text-secondary small d-block">Tarif standard:</span>
                            <span class="fs-4 fw-bold text-success">${p.pricePerHour} RON <small class="text-muted fs-6 fw-normal">/ oră</small></span>
                        </div>
                    </div>
                    <div class="card-footer bg-white border-top-0 p-4 pt-0">
                        <a href="/book-pitch?pitchId=${p.id}" class="btn btn-success w-100 fw-bold shadow-sm">
                            <i class="bi bi-calendar-plus"></i> Verifică Disponibilitate
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>

        <%-- Cazul în care nu există terenuri în baza de date --%>
        <c:if test="${empty pitches}">
            <div class="col-12">
                <div class="card shadow-sm border-0 text-center p-5">
                    <div class="card-body">
                        <i class="bi bi-building-x display-1 text-muted"></i>
                        <h4 class="mt-3 text-secondary">Niciun teren înregistrat</h4>
                        <p class="text-muted">Momentan nu există baze sportive adăugate în aplicație.</p>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>