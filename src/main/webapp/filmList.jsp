<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.entities.Seance" %>
<%@ page import="com.entities.Film" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Films</title>
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

        /* Bouton "Ajouter un Film" */
        .add-film {
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

        .add-film:hover {
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
            display: block; /* Afficher les boutons en bloc (l'un sous l'autre) */
            margin-bottom: 10px; /* Espace entre les boutons */
            padding: 5px 10px;
            border-radius: 15px; /* Coins arrondis */
            background-color: #ff8c42; /* Orange moderne */
            color: #fff; /* Texte blanc */
            text-decoration: none;
            transition: transform 0.3s ease; /* Transition fluide */
            text-align: center; /* Centrer le texte dans les boutons */
        }

        .actions a:hover {
            transform: translateY(-2px); /* Effet de levée */
        }

        /* Message "Aucun film disponible" */
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
        <h1>Liste des Films</h1>
        
        <!-- Conteneur pour le bouton -->
        <div class="button-container">
            <a href="filmAdmin?action=add" class="add-film">Ajouter un Film</a>
        </div>

        <table>
            <tr>
                <th>ID</th>
                <th>Titre</th>
                <th>Réalisateur</th>
                <th>Type</th>
                <th>Acteurs</th>
                <th>Durée</th>
                <th>Image</th>
                <th>Date</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
            <% 
                List<Film> films = (List<Film>) request.getAttribute("films");
                if (films != null && !films.isEmpty()) {
                    for (Film film : films) {
            %>
                        <tr>
                            <td><%= film.getId() %></td>
                            <td><%= film.getTitle() %></td>
                            <td><%= film.getDirector() %></td>
                            <td><%= film.getType() %></td>
                            <td><%= film.getActors() %></td>
                            <td><%= film.getDuration() %></td>
                            <td>
                                <% if (film.getPicture() != null && !film.getPicture().isEmpty()) { %>
                                    <img src="<%= film.getPicture() %>" alt="<%= film.getTitle() %>" style="max-width: 100px; height: auto;">
                                <% } else { %>
                                    Pas d'image
                                <% } %>
                            </td>
                            <td><%= film.getDate() %></td>
                            <td><%= film.getDescription() %></td>
                            <td class="actions">
                                <a href="filmAdmin?action=edit&id=<%= film.getId() %>">Modifier</a>
                                <a href="filmAdmin?action=delete&id=<%= film.getId() %>" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce film ?')">Supprimer</a>
                            </td>
                        </tr>
            <%  
                    }
                } else {
            %>
                    <tr>
                        <td colspan="10" class="no-data">Aucun film disponible</td>
                    </tr>
            <%
                }
            %>
        </table>
    </div>

    <%@ include file="footerAdmin.jsp" %>
</body>
</html>