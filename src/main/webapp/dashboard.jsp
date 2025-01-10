<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entities.Admin" %>

<!DOCTYPE html>
<%
    // Vérifier si l'admin est connecté
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/loginAdmin.jsp");
        return;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord Admin</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css">
    <style>
        /* Styles généraux */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }

        .dashboard-links {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .dashboard-links ul {
            list-style-type: none;
            padding: 0;
        }

        .dashboard-links ul li {
            margin: 15px 0;
        }

        .dashboard-links ul li a {
            display: block;
            padding: 15px;
            background-color: #ff8c42; /* Orange vif */
            color: #fff;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .dashboard-links ul li a:hover {
            background-color: #e67332; /* Orange plus foncé au survol */
        }

        /* Header et Footer */
        header, footer {
            background-color: #333;
            color: #fff;
            padding: 10px 0;
            text-align: center;
        }

        header a, footer a {
            color: #fff;
            text-decoration: none;
        }

        header a:hover, footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <%@ include file="headerAdmin.jsp" %>

    <h1>Tableau de Bord Admin</h1>
    <div class="dashboard-links">
        <ul>
            <li><a href="${pageContext.request.contextPath}/admin/filmAdmin">Gérer les Films</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/userAdmin">Gérer les Utilisateurs</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/cinemaAdmin">Gérer les Cinémas</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/seanceAdmin">Gérer les Séances</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/salleAdmin">Gérer les Salles</a></li>
        </ul>
    </div>

    <%@ include file="footerAdmin.jsp" %>
</body>
</html>