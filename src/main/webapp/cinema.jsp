<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.entities.Cinema" %>
<%@ page import="com.entities.Film" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Cinémas</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Styles généraux */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        
        body {
            background: #000000;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        h1, h2 {
            color: #e50914;
            text-align: center;
            font-size: 2em;
        }

        /* Conteneur de la liste des cinémas */
        .cinema-list-container {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #1a1a1a; /* Fond sombre pour le conteneur */
            border-radius: 10px;
        }

        /* Liste des cinémas en vertical */
        .cinema-list {
            display: flex;
            flex-direction: column; /* Afficher en vertical */
            gap: 20px; /* Espace entre les cartes */
        }

        /* Style de chaque carte de cinéma */
        .cinema-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%; /* Prendre toute la largeur */
            padding: 30px; /* Augmenter le padding pour une carte plus grande */
            text-align: center;
            transition: transform 0.3s ease;
        }

        .cinema-card:hover {
            transform: translateY(-5px);
        }

        .cinema-card h3 {
            font-size: 2em; /* Taille de police plus grande */
            margin: 0 0 15px;
            color: #333;
        }

        .cinema-card p {
            margin: 10px 0;
            font-size: 1.2em; /* Taille de police plus grande */
            color: #666;
        }

        /* Styles pour la liste des films */
        .film-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            padding: 20px;
            justify-content: center;
        }

        /* Style de chaque carte de film */
        .film {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 250px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .film:hover {
            transform: translateY(-5px);
        }

        .film img {
            width: 100%;
            height: auto;
            border-bottom: 1px solid #ddd;
        }

        .film h3 {
            font-size: 1.4em;
            margin: 10px 0;
            color: #333;
        }

        .film p {
            margin: 5px 0;
            font-size: 0.9em;
            color: #666;
            padding: 0 10px;
        }

        .film p strong {
            color: #333;
        }

        /* Message lorsqu'aucun film n'est trouvé */
        .message {
            text-align: center;
            font-size: 1.2em;
            color: #666;
            margin: 20px 0;
        }

        /* Responsive design pour les films */
        @media (max-width: 768px) {
            .film {
                width: 200px;
            }

            .film h3 {
                font-size: 1.2em;
            }

            .film p {
                font-size: 0.8em;
            }
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<h1>Liste des Cinémas</h1>

<div class="cinema-list-container">
    <div class="cinema-list">
        <%
            List<Cinema> cinemas = (List<Cinema>) request.getAttribute("cinemas");
            String selectedCinemaId = request.getParameter("cinemaId");
            if (cinemas != null && !cinemas.isEmpty()) {
                for (Cinema cinema : cinemas) {
        %>
            <div class="cinema-card">
                <h3><%= cinema.getName() %></h3>
                <p><%= cinema.getAdress() %></p>
                <a href="?cinemaId=<%= cinema.getId() %>" class="button">Voir les films</a>

                <%
                    // Afficher les films uniquement pour le cinéma sélectionné
                    if (selectedCinemaId != null && selectedCinemaId.equals(String.valueOf(cinema.getId()))) {
                        List<Film> films = (List<Film>) request.getAttribute("films");
                        if (films != null && !films.isEmpty()) {
                %>
                    <h2>Films disponibles dans ce cinéma</h2>
                    <div class="film-list">
                        <%
                            for (Film film : films) {
                        %>
                            <div class="film">
                                <img src="<%= film.getPicture() %>" alt="<%= film.getTitle() %>">
                                <h3><%= film.getTitle() %></h3>
                                <p><strong>Description :</strong> <%= film.getDescription() != null ? film.getDescription() : "Non spécifiée." %></p>
                                <p><strong>Réalisateur :</strong> <%= film.getDirector() %></p>
                                <p><strong>Durée :</strong> <%= film.getDuration() %> minutes</p>
                            </div>
                        <%
                            }
                        %>
                    </div>
                <%
                        } else {
                %>
                    <p class="message">Aucun film trouvé pour ce cinéma.</p>
                <%
                        }
                    }
                %>
            </div>
        <%
                }
            } else {
        %>
            <div class="no-cinemas">
                Aucun cinéma disponible.
            </div>
        <%
            }
        %>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>