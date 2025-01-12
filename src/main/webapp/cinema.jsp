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

        /* Header */
        header {
            background-color: #000; /* Noir */
            color: #fff;
            padding: 10px 20px; /* Padding réduit pour un header plus petit */
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        header h1 {
            margin: 0;
            font-size: 24px; /* Taille de police légèrement réduite */
            font-weight: bold;
        }

        /* Conteneur de la liste des cinémas */
        .cinema-scrollable-list-container {
            position: relative;
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #1a1a1a; /* Fond sombre */
            border-radius: 10px;
            overflow: hidden; /* Empêche l'apparition de la barre de défilement */
        }

        .cinema-scrollable-list {
            display: flex;
            overflow-x: auto; /* Permet le défilement horizontal */
            gap: 15px; /* Espace entre les cartes */
            scroll-behavior: smooth; /* Défilement fluide */
            padding: 10px;
            -ms-overflow-style: none; /* Masquer la barre de défilement pour IE et Edge */
            scrollbar-width: none; /* Masquer la barre de défilement pour Firefox */
        }

        .cinema-scrollable-list::-webkit-scrollbar {
            display: none; /* Masquer la barre de défilement pour Chrome, Safari et Opera */
        }

        /* Style de chaque carte de cinéma */
        .cinema-card {
            background-color: #FFA500;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            min-width: 200px; /* Largeur minimale pour chaque carte */
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
            cursor: pointer;
        }

        .cinema-card:hover {
            transform: translateY(-5px);
        }

        .cinema-card h3 {
            font-size: 1.5em; /* Taille de police plus grande */
            margin: 0 0 10px;
            color: #333;
        }

        .cinema-card p {
            margin: 10px 0;
            font-size: 1em; /* Taille de police plus grande */
            color: #666;
        }

        /* Flèches de défilement */
        .scroll-arrow {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(255, 255, 255, 0.8);
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: #000;
            z-index: 1;
            transition: background-color 0.3s ease;
        }

        .scroll-arrow:hover {
            background-color: rgba(255, 255, 255, 1);
        }

        .scroll-arrow.left {
            left: -20px;
        }

        .scroll-arrow.right {
            right: -20px;
        }

        /* Section des films */
        .film-section {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #1a1a1a; /* Fond sombre */
            border-radius: 10px;
            overflow: hidden; /* Empêche l'apparition de la barre de défilement */
        }

        /* Conteneur de la liste des films avec flèches */
        .film-scrollable-list-container {
            position: relative;
            width: 100%;
            margin-top: 20px;
        }

        .film-scrollable-list {
            display: flex;
            overflow-x: auto; /* Permet le défilement horizontal */
            gap: 20px;
            padding: 20px;
            scroll-behavior: smooth; /* Défilement fluide */
            -ms-overflow-style: none; /* Masquer la barre de défilement pour IE et Edge */
            scrollbar-width: none; /* Masquer la barre de défilement pour Firefox */
        }

        .film-scrollable-list::-webkit-scrollbar {
            display: none; /* Masquer la barre de défilement pour Chrome, Safari et Opera */
        }

        /* Style de chaque carte de film */
        .film {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            min-width: 150px; /* Largeur minimale réduite */
            max-width: 200px; /* Largeur maximale réduite */
            flex: 1 1 calc(20% - 20px); /* Flex pour une disposition flexible */
            text-align: center;
            transition: transform 0.3s ease;
            margin: 5px; /* Marge réduite autour des cartes */
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
            font-size: 1.1em; /* Taille de police réduite */
            margin: 8px 0; /* Marge réduite */
            color: #333;
        }

        .film p {
            margin: 4px 0; /* Marge réduite */
            font-size: 0.8em; /* Taille de police réduite */
            color: #666;
            padding: 0 8px; /* Padding réduit */
        }

        .film p strong {
            color: #333;
        }

        /* Responsive design pour les films */
        @media (max-width: 768px) {
            .film {
                min-width: 120px; /* Largeur minimale réduite pour les petits écrans */
                max-width: 150px; /* Largeur maximale réduite pour les petits écrans */
                flex: 1 1 calc(33.33% - 10px); /* Trois cartes par ligne sur les petits écrans */
            }

            .film h3 {
                font-size: 1em; /* Taille de police réduite */
            }

            .film p {
                font-size: 0.7em; /* Taille de police réduite */
            }
        }

        @media (max-width: 480px) {
            .film {
                flex: 1 1 calc(50% - 10px); /* Deux cartes par ligne sur les très petits écrans */
            }
        }

        /* Message lorsqu'aucun film n'est trouvé */
        .message {
            text-align: center;
            font-size: 1.2em;
            color: #666;
            margin: 20px 0;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<h1>Liste des Cinémas</h1>

<!-- Liste glissante des cinémas avec flèches -->
<div class="cinema-scrollable-list-container">
    <button class="scroll-arrow left" onclick="scrollCinemas(-200)">&#10094;</button>
    <button class="scroll-arrow right" onclick="scrollCinemas(200)">&#10095;</button>

    <div class="cinema-scrollable-list" id="cinema-scrollable-list">
        <%
            List<Cinema> cinemas = (List<Cinema>) request.getAttribute("cinemas");
            String selectedCinemaId = request.getParameter("cinemaId");
            Cinema defaultCinema = null;

            if (cinemas != null && !cinemas.isEmpty()) {
                // Définir le premier cinéma comme cinéma par défaut
                defaultCinema = cinemas.get(0);

                for (Cinema cinema : cinemas) {
        %>
            <div class="cinema-card" onclick="window.location.href='?cinemaId=<%= cinema.getId() %>'">
                <h3><%= cinema.getName() %></h3>
                <p><%= cinema.getAdress() %></p>
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

<!-- Section des films -->
<div class="film-section">
    <%
        // Si aucun cinéma n'est sélectionné, utilisez le cinéma par défaut
        if (selectedCinemaId == null && defaultCinema != null) {
            selectedCinemaId = String.valueOf(defaultCinema.getId());
        }

        if (selectedCinemaId != null) {
            List<Film> films = (List<Film>) request.getAttribute("films");
            if (films != null && !films.isEmpty()) {
    %>
        <h2>Films disponibles dans ce cinéma</h2>
        <div class="film-scrollable-list-container">
            <button class="scroll-arrow left" onclick="scrollFilms(-200)">&#10094;</button>
            <button class="scroll-arrow right" onclick="scrollFilms(200)">&#10095;</button>

            <div class="film-scrollable-list" id="film-scrollable-list">
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

<%@ include file="footer.jsp" %>

<script>
    // Fonction pour faire défiler la liste des cinémas
    function scrollCinemas(scrollAmount) {
        const cinemaList = document.getElementById('cinema-scrollable-list');
        cinemaList.scrollBy({ left: scrollAmount, behavior: 'smooth' });
    }

    // Fonction pour faire défiler la liste des films
    function scrollFilms(scrollAmount) {
        const filmList = document.getElementById('film-scrollable-list');
        filmList.scrollBy({ left: scrollAmount, behavior: 'smooth' });
    }
</script>
</body>
</html>