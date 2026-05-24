<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Schimbare Parolă - CF Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-secondary shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/profile"><i class="bi bi-shield-lock"></i> Securitate Cont</a>
        <a href="/profile" class="btn btn-outline-light btn-sm">Înapoi la Profil</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white text-center py-3 border-bottom-0">
                    <h4 class="mb-0 text-secondary"><i class="bi bi-key"></i> Modifică Parola</h4>
                </div>
                <div class="card-body p-4 p-md-5">
                    
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger" role="alert"><i class="bi bi-exclamation-triangle"></i> <%= request.getAttribute("error") %></div>
                    <% } %>
                    <% if (request.getAttribute("success") != null) { %>
                        <div class="alert alert-success" role="alert"><i class="bi bi-check-circle"></i> <%= request.getAttribute("success") %></div>
                    <% } %>

                    <form action="/change-password" method="post">
                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" id="oldPassword" name="oldPassword" placeholder="Parola curentă" required>
                            <label for="oldPassword">Parola curentă (cea veche)</label>
                        </div>
                        <div class="form-floating mb-4">
                            <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Parola nouă" required>
                            <label for="newPassword">Parola nouă</label>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-secondary btn-lg fw-bold"><i class="bi bi-save"></i> Salvează Modificarea</button>
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