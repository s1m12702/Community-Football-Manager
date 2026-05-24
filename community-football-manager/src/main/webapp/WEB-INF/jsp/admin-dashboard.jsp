<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Panou Admin - CF Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/profile"><i class="bi bi-shield-lock"></i> Admin Dashboard</a>
        <a href="/profile" class="btn btn-outline-light btn-sm">Înapoi la Profil</a>
    </div>
</nav>

<div class="container mt-5">
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill"></i> ${param.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row">
        <div class="col-12 mb-5">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-secondary text-white">
                    <h5 class="mb-0"><i class="bi bi-people"></i> Gestiune Utilizatori</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Rol</th>
                                    <th>Status</th>
                                    <th>Acțiuni</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="u" items="${users}">
                                    <tr>
                                        <td><strong>${u.username}</strong></td>
                                        <td>${u.email}</td>
                                        <td>
                                            <span class="badge ${u.role.name() == 'ADMIN' ? 'bg-danger' : (u.role.name() == 'PROVIDER' ? 'bg-warning text-dark' : 'bg-primary')}">
                                                ${u.role}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="badge ${u.suspended ? 'bg-danger' : 'bg-success'}">
                                                ${u.suspended ? 'SUSPENDAT' : 'ACTIV'}
                                            </span>
                                        </td>
                                        <td>
                                            <c:if test="${u.role.name() != 'ADMIN'}">
                                                <c:choose>
                                                    <c:when test="${u.suspended}">
                                                        <form action="/admin/unsuspend-user" method="post" class="d-inline m-0">
                                                            <input type="hidden" name="userId" value="${u.id}">
                                                            <button type="submit" class="btn btn-sm btn-outline-success">
                                                                <i class="bi bi-unlock"></i> Ridică Suspendarea
                                                            </button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form action="/admin/suspend-user" method="post" class="row g-2 align-items-center m-0">
                                                            <input type="hidden" name="userId" value="${u.id}">
                                                            <div class="col-auto">
                                                                <input type="text" name="reason" class="form-control form-control-sm" placeholder="Motiv suspendare" required>
                                                            </div>
                                                            <div class="col-auto">
                                                                <button type="submit" class="btn btn-sm btn-danger">
                                                                    <i class="bi bi-slash-circle"></i> Suspendă
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white">
                    <h5 class="mb-0"><i class="bi bi-trophy"></i> Gestiune Meciuri Active</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Locație / Teren</th>
                                    <th>Dată & Oră</th>
                                    <th>Acțiuni</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="m" items="${matches}">
                                    <tr>
                                        <td>#${m.id}</td>
                                        <td><strong>${m.pitch.name}</strong></td>
                                        <td><i class="bi bi-calendar2-event"></i> ${m.matchDate} la ${m.matchTime}</td>
                                        <td>
                                            <form action="/admin/delete-match" method="post" class="m-0">
                                                <input type="hidden" name="matchId" value="${m.id}">
                                                <button type="submit" onclick="return confirm('Sigur ștergi acest meci neconform?')" class="btn btn-sm btn-outline-danger">
                                                    <i class="bi bi-trash"></i> Șterge Meci
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
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