<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Recuperare Parolă - CF Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light d-flex align-items-center py-5" style="min-height: 100vh;">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-lg border-0 rounded-lg">
                <div class="card-header bg-warning text-dark text-center py-3">
                    <h3 class="font-weight-light my-2 fw-bold"><i class="bi bi-envelope-at"></i> Recuperare Cont</h3>
                </div>
                <div class="card-body p-4 p-md-5">

                    <p class="text-muted text-center mb-4">Introdu adresa de email asociată contului tău, iar noi îți vom genera și trimite o parolă nouă în cel mai scurt timp.</p>
                    
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger" role="alert"><i class="bi bi-exclamation-triangle"></i> <%= request.getAttribute("error") %></div>
                    <% } %>
                    <% if (request.getAttribute("success") != null) { %>
                        <div class="alert alert-success" role="alert"><i class="bi bi-check-circle"></i> <%= request.getAttribute("success") %></div>
                    <% } %>

                    <form action="/forgot-password" method="post">
                        <div class="form-floating mb-4">
                            <input type="email" class="form-control" id="email" name="email" placeholder="Introdu email-ul" required>
                            <label for="email">Adresa de Email</label>
                        </div>

                        <div class="d-grid gap-2 mt-4 mb-0">
                            <button type="submit" class="btn btn-warning btn-lg fw-bold text-dark"><i class="bi bi-send"></i> Resetează Parola</button>
                        </div>
                    </form>
                </div>
                <div class="card-footer text-center py-3">
                    <div class="small"><a href="/login" class="text-secondary text-decoration-none fw-bold">Înapoi la Autentificare</a></div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>