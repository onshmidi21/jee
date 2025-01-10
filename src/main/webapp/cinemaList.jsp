<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Cinémas</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #ffffff; /* Fond blanc */
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #ff8c42; /* Orange moderne */
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(255, 140, 66, 0.3); /* Ombre textuelle */
        }
        a {
            color: #ff8c42; /* Orange moderne */
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s ease; /* Transition fluide */
        }
        a:hover {
            color: #ff6b1a; /* Orange plus vif au survol */
        }
        .button {
            display: inline-block;
            background-color: #ff8c42; /* Orange moderne */
            color: #fff;
            padding: 10px 20px;
            border-radius: 25px; /* Coins arrondis */
            text-align: center;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(255, 140, 66, 0.2); /* Ombre portée */
            transition: background-color 0.3s ease, transform 0.3s ease;
            margin-right: 10px; /* Espacement entre les boutons */
        }
        .button:hover {
            background-color: #ff6b1a; /* Orange plus vif au survol */
            transform: translateY(-2px); /* Effet de levée */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #ffffff; /* Fond blanc */
            border-radius: 10px; /* Coins arrondis */
            overflow: hidden; /* Pour que les coins arrondis fonctionnent */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3); /* Ombre portée */
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd; /* Bordure grise claire */
        }
        th {
            background-color: #ff8c42; /* Orange moderne pour l'en-tête */
            color: #fff;
            font-weight: bold;
            text-transform: uppercase; /* Texte en majuscules */
        }
        tr:hover {
            background-color: #f1f1f1; /* Fond gris très clair au survol */
        }
        .actions a {
            margin-right: 10px;
            padding: 5px 10px;
            border-radius: 15px; /* Coins arrondis */
            background-color: #ffffff; /* Fond blanc */
            color: #ff8c42; /* Orange moderne */
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .actions a:hover {
            background-color: #ff8c42; /* Orange moderne */
            color: #fff; /* Texte blanc au survol */
        }
    </style>
</head>
<body>
    <%@ include file="headerAdmin.jsp" %>

    <h1>Liste des Cinémas</h1>
    <div>
        <a href="cinemaAdmin?action=add" class="button">Ajouter un Cinéma</a>
    </div>
    <table>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Adresse</th>
            <th>Actions</th>
        </tr>
        <%
            // Récupérer la liste des cinémas depuis les attributs de requête ou session
            List<Cinema> cinemas = (List<Cinema>) request.getAttribute("cinemas");
            if (cinemas != null) {
                for (Cinema cinema : cinemas) {
        %>
        <tr>
            <td><%= cinema.getId() %></td>
            <td><%= cinema.getName() %></td>
            <td><%= cinema.getAdress() %></td>
            <td class="actions">
                <a href="cinemaAdmin?action=edit&id=<%= cinema.getId() %>">Modifier</a>
                <a href="cinemaAdmin?action=delete&id=<%= cinema.getId() %>">Supprimer</a>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
    <%@ include file="footerAdmin.jsp" %>
</body>
</html>