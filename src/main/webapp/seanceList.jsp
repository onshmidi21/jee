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
        /* Styles généraux */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Hauteur minimale de la page */
        }

        /* Header */
        header {
            background-color: #333;
            color: #fff;
            padding: 10px 0;
            text-align: center;
        }

        header a {
            color: #fff;
            text-decoration: none;
        }

        header a:hover {
            text-decoration: underline;
        }

        /* Contenu principal */
        .main-content {
            flex: 1; /* Prend l'espace disponible */
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }

        /* Conteneur pour le bouton */
        .button-container {
            text-align: center; /* Centrer le bouton horizontalement */
            margin: 20px 0; /* Espacement autour du bouton */
        }

        /* Bouton "Ajouter une Séance" */
        .add-seance {
            display: inline-block; /* Alignement horizontal */
            background-color: #ff8c42; /* Orange moderne */
            color: #fff; /* Texte blanc */
            padding: 10px 20px;
            border-radius: 25px; /* Coins arrondis */
            text-align: center;
            box-shadow: 0 4px 6px rgba(255, 140, 66, 0.2); /* Ombre portée */
            transition: transform 0.3s ease; /* Transition fluide */
            text-decoration: none; /* Supprimer le soulignement */
        }

        .add-seance:hover {
            transform: translateY(-2px); /* Effet de levée */
        }

        /* Tableau */
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 10px; /* Coins arrondis */
            overflow: hidden; /* Pour que les coins arrondis fonctionnent */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Ombre portée */
        }

        th, td {
            padding: 12px;
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
            background-color: #f5f5f5; /* Fond gris très clair au survol */
        }

        /* Boutons d'action */
        .actions a {
            margin-right: 10px;
            padding: 5px 10px;
            border-radius: 15px; /* Coins arrondis */
            background-color: #ff8c42; /* Orange moderne */
            color: #fff; /* Texte blanc */
            text-decoration: none;
            transition: transform 0.3s ease; /* Transition fluide */
        }

        .actions a:hover {
            transform: translateY(-2px); /* Effet de levée */
        }

        /* Message "Aucune séance disponible" */
        .no-data {
            text-align: center;
            color: #ff8c42; /* Orange moderne */
            font-weight: bold;
            padding: 20px;
        }

        /* Footer */
        footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 10px 0;
            margin-top: auto; /* Coller le footer en bas */
        }

        footer a {
            color: #fff;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <%@ include file="headerAdmin.jsp" %>

    <div class="main-content">
        <h1>Liste des Séances</h1>
        
        <!-- Conteneur pour le bouton -->
        <div class="button-container">
            <a class="add-seance" href="seanceAdmin?action=add">Ajouter une Séance</a>
        </div>

        <table>
            <tr>
                <th>ID</th>
                <th>Date</th>
                <th>Horaire</th>
                <th>Tarif</th>
                <th>Salle</th>
                <th>Actions</th>
            </tr>
             <%     List<Seance> seances = (List<Seance>) request.getAttribute("seances");
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
    </div>

    <%@ include file="footerAdmin.jsp" %>
</body>
</html>