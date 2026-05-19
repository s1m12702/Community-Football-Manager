<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Profilul Meu - CFM</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px; background-color: #f4f7f6;">
    <div style="max-width: 800px; margin: auto; background: white; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1);">
        <h2>Salut, ${user.username}! ⚽</h2>
        <p><strong>Email:</strong> ${user.email} | <strong>Rol:</strong> ${user.role}</p>
        
        <hr>

        <h3 style="color: #2c3e50;">📊 Statisticile Tale Individuale</h3>
        <c:choose>
            <c:when test="${user.matchesPlayed > 0}">
                <div style="display: flex; gap: 20px; margin-bottom: 20px;">
                    <div style="background: #e8f4fd; padding: 15px; border-radius: 8px; flex: 1; text-align: center;">
                        <span style="font-size: 24px; font-weight: bold; color: #007bff;">${user.matchesPlayed}</span><br>
                        Meciuri Jucate
                    </div>
                    <div style="background: #e9f7ef; padding: 15px; border-radius: 8px; flex: 1; text-align: center;">
                        <span style="font-size: 24px; font-weight: bold; color: #28a745;">${user.victories}</span><br>
                        Victorii
                    </div>
                    <div style="background: #fff9e6; padding: 15px; border-radius: 8px; flex: 1; text-align: center;">
                        <span style="font-size: 24px; font-weight: bold; color: #f39c12;">${user.goalsScored}</span><br>
                        Goluri Marcate
                    </div>
                </div>
                
                <p><strong>Rata de victorie:</strong> 
                    <c:set var="winRate" value="${(user.victories / user.matchesPlayed) * 100}" />
                    <span style="color: #28a745; font-weight: bold;">
                        ${String.format("%.1f", winRate)}%
                    </span>
                </p>
            </c:when>
            <c:otherwise>
                <div style="padding: 20px; background-color: #fff3cd; color: #856404; border-radius: 8px;">
                    Nu ai niciun meci înregistrat încă. Înscrie-te la prima ta partidă pentru a începe să-ți construiești statisticile! 🚀
                </div>
            </c:otherwise>
        </c:choose>
<h3 style="color: #2c3e50;">🌟 Reputație Comunitate</h3>
        <div style="display: flex; gap: 15px; margin-bottom: 20px;">
            <div style="background: #f8f9fa; padding: 10px; border: 1px solid #ddd; border-radius: 5px; flex: 1; text-align: center;">
                <span style="font-size: 20px;">🤝</span><br>
                <strong>${user.fairPlayVotes}</strong><br><small>Fair-Play</small>
            </div>
            <div style="background: #f8f9fa; padding: 10px; border: 1px solid #ddd; border-radius: 5px; flex: 1; text-align: center;">
                <span style="font-size: 20px;">🔥</span><br>
                <strong>${user.skillVotes}</strong><br><small>Skill</small>
            </div>
            <div style="background: #f8f9fa; padding: 10px; border: 1px solid #ddd; border-radius: 5px; flex: 1; text-align: center;">
                <span style="font-size: 20px;">⏰</span><br>
                <strong>${user.punctualityVotes}</strong><br><small>Punctualitate</small>
            </div>
        </div>
        <hr>

        <h3>Organizare și Comunitate</h3>
        <p><a href="/create-match">➕ Creare Meci Nou</a></p>
        <p><a href="/matches">⚽ Vezi Meciuri Disponibile</a></p>
        <p><a href="/my-organized-matches">📋 Meciurile mele (Finalizare)</a></p>
        <p><a href="/view-pitches">🏟️ Vezi Terenuri</a></p>
        <p><a href="/community" style="color: #17a2b8; font-weight: bold;">🌟 Vezi Comunitatea și Rating-uri</a></p>

        <hr>
        <h3>⚽ Activitatea Mea</h3>
        <div style="background-color: #f8f9fa; padding: 15px; border-radius: 8px; border: 1px solid #dee2e6;">
            <p>Vizualizează meciurile la care ai participat și evaluează performanța colegilor tăi.</p>
            <a href="/my-history" style="display: inline-block; background-color: #17a2b8; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-weight: bold;">
                🌟 Vezi Istoric Meciuri & Feedback
            </a>
        </div>

        <c:if test="${user.role == 'PITCH_PROVIDER'}">
            <h3 style="color: #d9534f;">Administrare Furnizor</h3>
            <hr>
            <c:if test="${user.role == 'PITCH_PROVIDER'}">
                <h3 style="color: #28a745;">🏢 Administrare Furnizor</h3>
                <div style="background-color: #e9f7ef; padding: 15px; border-radius: 8px; border: 1px solid #c3e6cb;">
                    <p>Ești înregistrat ca Furnizor de Terenuri. De aici poți gestiona intervalele orare și rezervările primite.</p>
                    <a href="/provider-dashboard" style="display: inline-block; background-color: #28a745; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-weight: bold;">
                        🏟️ Mergi la Panou Administrare
                    </a>
                </div>
                <br>
            </c:if>
            <p><a href="/add-pitch">🏢 Înregistrează Teren Nou</a></p>
        </c:if>

        <c:if test="${user.role == 'ADMIN'}">
            <h3 style="color: #dc3545;">🛡️ Administrare Sistem</h3>
            <div style="background-color: #f8d7da; padding: 15px; border-radius: 8px; border: 1px solid #f5c6cb;">
                <p>Ești logat ca Administrator. Ai acces la moderarea conținutului și a utilizatorilor.</p>
                <a href="/admin-dashboard" style="display: inline-block; background-color: #dc3545; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-weight: bold;">
                    🚀 Deschide Panou Control
                </a>
            </div>
        </c:if>

        <hr>
        <h3>Setări Cont</h3>
        <p><a href="/change-password">Schimbă parola</a></p>
        <p><a href="/logout" style="color: #dc3545;">Deconectare</a></p>
    </div>
</body>
</html>