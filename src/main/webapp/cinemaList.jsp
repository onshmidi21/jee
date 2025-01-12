<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Cinémas</title>
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

        /* Bouton "Ajouter un Cinéma" */
        .add-button {
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

        .add-button:hover {
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

        /* Message "Aucun cinéma disponible" */
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
        <h1>Liste des Cinémas</h1>
        
        <!-- Conteneur pour le bouton -->
        <div class="button-container">
            <a class="add-button" href="cinemaAdmin?action=add">Ajouter un Cinéma</a>
        </div>

        <table>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Adresse</th>
                <th>Actions</th>
            </tr>
            <% 
                List<Cinema> cinemas = (List<Cinema>) request.getAttribute("cinemas");
                if (cinemas != null && !cinemas.isEmpty()) {
                    for (Cinema cinema : cinemas) {
            %>
                        <tr>
                            <td><%= cinema.getId() %></td>
                            <td><%= cinema.getName() %></td>
                            <td><%= cinema.getAdress() %></td>
                            <td class="actions">
                                <a href="cinemaAdmin?action=edit&id=<%= cinema.getId() %>">Modifier</a>
                                <a href="cinemaAdmin?action=delete&id=<%= cinema.getId() %>" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce cinéma ?')">Supprimer</a>
                            </td>
                        </tr>
            <%  
                    }
                } else {
            %>
                    <tr>
                        <td colspan="4" class="no-data">Aucun cinéma disponible</td>
                    </tr>
            <%
                }
            %>
        </table>
    </div>

    <%@ include file="footerAdmin.jsp" %>
</body>
</html>