<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Adăugare Teren Nou - CF Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-warning shadow-sm">
    <div class="container">
        <a class="navbar-brand text-dark fw-bold" href="/provider-dashboard"><i class="bi bi-building"></i> Panou Furnizor</a>
        <a href="/profile" class="btn btn-outline-dark btn-sm fw-bold">Înapoi la Profil</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h4 class="mb-0 text-center"><i class="bi bi-plus-circle-fill text-warning"></i> Înregistrează un Teren Nou</h4>
                </div>
                <div class="card-body p-4 p-md-5">
                    
                    <% if (request.getAttribute("success") != null) { %>
                        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                            <i class="bi bi-check-circle-fill"></i> <%= request.getAttribute("success") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    <% } %>

                    <p class="text-muted text-center mb-4">Completează detaliile de mai jos pentru a adăuga un nou teren în baza ta sportivă.</p>

                    <form action="/add-pitch" method="post">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="name" name="name" placeholder="ex: Arena Sintetic" required>
                            <label for="name">Nume Teren (ex: Arena Sintetic)</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="address" name="address" placeholder="Adresa completă" required>
                            <label for="address">Adresa completă</label>
                        </div>

                        <div class="form-floating mb-4">
                            <input type="number" class="form-control" id="pricePerHour" name="pricePerHour" step="0.5" placeholder="Preț pe Oră (RON)" required>
                            <label for="pricePerHour">Preț pe Oră (RON)</label>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-warning btn-lg fw-bold text-dark shadow-sm">
                                <i class="bi bi-save"></i> Salvează Terenul
                            </button>
                            <a href="/provider-dashboard" class="btn btn-outline-secondary">
                                Anulează și întoarce-te
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