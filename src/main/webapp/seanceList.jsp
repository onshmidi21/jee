<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.entities.Seance" %>
<%@ page import="com.entities.Film" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Séances</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #ffff; /* Fond noir légèrement plus clair */
            color: #fff; /* Texte blanc */
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
        .add-button {
            display: inline-block;
            background-color: #ff8c42; /* Orange moderne */
            color: #fff;
            padding: 10px 20px;
            border-radius: 25px; /* Coins arrondis */
            text-align: center;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(255, 140, 66, 0.2); /* Ombre portée */
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .add-button:hover {
            background-color: #ff6b1a; /* Orange plus vif au survol */
            transform: translateY(-2px); /* Effet de levée */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #2a2a2a; /* Fond gris très foncé */
            border-radius: 10px; /* Coins arrondis */
            overflow: hidden; /* Pour que les coins arrondis fonctionnent */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3); /* Ombre portée */
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #444; /* Bordure grise */
        }
        th {
            background-color: #ff8c42; /* Orange moderne pour l'en-tête */
            color: #fff;
            font-weight: bold;
            text-transform: uppercase; /* Texte en majuscules */
        }
        tr:hover {
            background-color: #333; /* Fond gris foncé au survol */
        }
        .actions a {
            margin-right: 10px;
            padding: 5px 10px;
            border-radius: 15px; /* Coins arrondis */
            background-color: #444; /* Fond gris foncé */
            color: #ff8c42; /* Orange moderne */
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .actions a:hover {
            background-color: #ff8c42; /* Orange moderne */
            color: #fff; /* Texte blanc au survol */
        }
        .no-data {
            text-align: center;
            color: #ff8c42; /* Orange moderne */
            font-weight: bold;
            padding: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="headerAdmin.jsp" %>

    <h1>Liste des Séances</h1>
    <a href="seanceAdmin?action=add" class="add-button">Ajouter une Séance</a>
    <table>
        <tr>
            <th>ID</th>
            <th>Date</th>
            <th>Horaire</th>
            <th>Tarif</th>
            <th>Salle</th>
            <th>Actions</th>
        </tr>
        <% 
            List<Seance> seances = (List<Seance>) request.getAttribute("seances");
            if (seances != null && !seances.isEmpty()) {
                for (Seance seance : seances) {
        %>
            <tr>
                <td><%= seance.getId() %></td>
                <td><%= seance.getDate() %></td>
                <td><%= seance.getHoraire() %></td>
                <td><%= seance.getTarif() %></td>
                <td><%= seance.salle.salle.getName() %></td>
                <td class="actions">
                    <a href="seanceAdmin?action=edit&id=<%= seance.getId() %>">Modifier</a>
                    <a href="seanceAdmin?action=delete&id=<%= seance.getId() %>" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette séance ?')">Supprimer</a>
                </td>
            </tr>
        <% 
                }
            } else { 
        %>
            <tr>
                <td colspan="6" class="no-data">Aucune séance disponible.</td>
            </tr>
        <% 
            } 
        %>
    </table>
    <%@ include file="footerAdmin.jsp" %>
</body>
</html>