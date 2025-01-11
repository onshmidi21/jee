<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="com.entities.Film"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Films </title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Styles généraux */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        h1 {
            color: #444;
            text-align: center;
            font-size: 2.5rem;
            margin-top: 20px;
        }

        /* Conteneur de la liste des films avec flèches */
        .film-list-container {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            position: relative;
            overflow: hidden;
        }

        /* Masquer la barre de défilement */
        .film-list-container::-webkit-scrollbar {
            display: none;
        }

        .film-list-container {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }

        /* Flèches de défilement */
        .scroll-arrow {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            z-index: 1;
            border-radius: 50%;
            transition: background-color 0.3s ease;
        }

        .scroll-arrow:hover {
            background-color: rgba(0, 0, 0, 0.8);
        }

        .scroll-arrow.left {
            left: 10px;
        }

        .scroll-arrow.right {
            right: 10px;
        }

        /* Liste des films */
        .film-list {
            display: flex;
            gap: 20px;
            padding: 10px;
            overflow-x: hidden;
            scroll-behavior: smooth;
        }

        /* Style de chaque film */
        .film-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            position: relative;
            min-width: 250px;
            flex: 0 0 auto;
            margin-right: 20px;
        }

        /* Image du film */
        .film-card img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            display: block;
        }

        /* Contenu superposé sur l'image */
        .film-card .card-content {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 15px;
            transform: translateY(100%);
            transition: transform 0.3s ease;
        }

        /* Effet de survol pour afficher le contenu */
        .film-card:hover .card-content {
            transform: translateY(0);
        }

        /* Style du texte */
        .film-card h3 {
            font-size: 1.4em;
            margin: 0 0 10px;
        }

        .film-card p {
            margin: 5px 0;
            font-size: 1em;
        }

        .film-card .btn-details {
            background-color: #f39c12;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }

        .film-card .btn-details:hover {
            background-color: #e67e22;
        }

        /* Media Queries for responsiveness */
        @media (max-width: 768px) {
            .film-card {
                min-width: 200px;
            }
        }
    </style>
</head>

<body>
    <%@ include file="header.jsp" %>

    <!-- Film aléatoire -->
    <%@ include file="filmRandom.jsp" %>

    <!-- Liste des films -->
    <h1>Liste des Films</h1>

    <div class="film-list-container">
        <button class="scroll-arrow left" onclick="scrollFilms(-1)"><i class="fas fa-chevron-left"></i></button>
        <button class="scroll-arrow right" onclick="scrollFilms(1)"><i class="fas fa-chevron-right"></i></button>
        <div class="film-list">
            <% 
                List<Film> films = (List<Film>) request.getAttribute("ListFilms");
                if (films != null && !films.isEmpty()) {
                    for (Film film : films) {
            %>
                <div class="film-card">
                    <img src="<%= film.getPicture() %>" alt="<%= film.getTitle() %>">
                    <div class="card-content">
                      
                        <p><strong>Type:</strong> <%= film.getType() %></p>
                        <p><strong>Réalisateur:</strong> <%= film.getDirector() %></p>
                        <p><strong>Durée:</strong> <%= film.getDuration() %> min</p>
                        <p><strong>Date de sortie:</strong> <%= new SimpleDateFormat("dd MMM yyyy").format(film.getDate()) %></p>
                        <p class="description"><%= film.getDescription() != null ? film.getDescription() : "Aucune description disponible." %></p>
                        <a href="seances?filmId=<%= film.getId() %>" class="btn-details">Voir Séances</a>
                    </div>
                </div>
            <% 
                    }
                } else {
            %>
                <div class="no-films">
                    Aucun film disponible.
                </div>
            <% 
                }
            %>
        </div>
    </div>

    <script>
        function scrollFilms(direction) {
            const filmList = document.querySelector('.film-list');
            const scrollAmount = 300; // Ajustez cette valeur pour contrôler la distance de défilement
            filmList.scrollBy({
                left: direction * scrollAmount,
                behavior: 'smooth'
            });
        }
    </script>

    <%@ include file="footer.jsp" %>
</body>
</html>