<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Înregistrare - CF Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light d-flex align-items-center py-5" style="min-height: 100vh;">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-lg border-0 rounded-lg">
                <div class="card-header bg-success text-white text-center py-3">
                    <h3 class="font-weight-light my-2"><i class="bi bi-person-plus-fill"></i> Înregistrare Cont</h3>
                </div>
                <div class="card-body p-4 p-md-5">

                    <%-- Mesaje de eroare / succes --%>
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger" role="alert"><i class="bi bi-exclamation-triangle"></i> <%= request.getAttribute("error") %></div>
                    <% } %>
                    <% if (request.getAttribute("success") != null) { %>
                        <div class="alert alert-success" role="alert"><i class="bi bi-check-circle"></i> <%= request.getAttribute("success") %></div>
                    <% } %>

                    <form action="/register" method="post">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
                            <label for="username">Username</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                            <label for="email">Adresa de Email</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Parolă" required>
                            <label for="password">Parolă</label>
                        </div>
                        <div class="form-floating mb-4">
                            <select class="form-select" id="role" name="role" required>
                                <option value="PLAYER">⚽ Jucător</option>
                                <option value="PITCH_PROVIDER">🏢 Furnizor de Terenuri</option>
                            </select>
                            <label for="role">Alege Rolul tău</label>
                        </div>

                        <div class="d-grid gap-2 mt-4 mb-0">
                            <button type="submit" class="btn btn-success btn-lg fw-bold">Creează Contul</button>
                        </div>
                    </form>
                </div>
                <div class="card-footer text-center py-3">
                    <div class="small"><a href="/login" class="text-success text-decoration-none fw-bold">Ai deja un cont? Autentifică-te!</a></div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>