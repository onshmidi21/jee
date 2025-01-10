<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.entities.Film"%>
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
        }

        h1 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }

        a {
            text-decoration: none;
            color: #ff8c42; /* Orange */
            transition: color 0.3s ease;
        }

        a:hover {
            color: #e67332; /* Orange plus foncé au survol */
        }

        /* Tableau */
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #333;
            color: #fff;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        /* Image */
        img {
            max-width: 100px;
            height: auto;
            border-radius: 5px;
        }

        /* Boutons d'action */
        .actions a {
            margin-right: 10px;
            padding: 5px 10px;
            background-color: #ff8c42; /* Orange */
            color: #fff;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .actions a:hover {
            background-color: #e67332; /* Orange plus foncé au survol */
        }

        /* Bouton "Ajouter un Film" */
        .add-film {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px;
            background-color: #ff8c42; /* Orange */
            color: #fff;
            text-align: center;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .add-film:hover {
            background-color: #e67332; /* Orange plus foncé au survol */
        }

        /* Bouton "Voir un film aléatoire" */
        .random-film {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px;
            background-color: #333; /* Noir */
            color: #fff;
            text-align: center;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .random-film:hover {
            background-color: #555; /* Gris foncé au survol */
        }
    </style>
</head>
<body>
    <%@ include file="headerAdmin.jsp" %>

    <h1>Liste des Films</h1>
    <a href="filmAdmin?action=add" class="add-film">Ajouter un Film</a>
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
                        <img src="<%= film.getPicture() %>" alt="<%= film.getTitle() %>">
                    <% } else { %>
                        Pas d'image
                    <% } %>
                </td>
                <td><%= film.getDate() %></td>
                <td><%= film.getDescription() %></td>
                <td class="actions">
                    <a href="filmAdmin?action=edit&id=<%= film.getId() %>">Modifier</a>
                    <a href="filmAdmin?action=delete&id=<%= film.getId() %>">Supprimer</a>
                </td>
            </tr>
        <% } %>
    </table>
        <%@ include file="footerAdmin.jsp" %>
    
</body>

</html>