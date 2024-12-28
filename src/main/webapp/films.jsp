<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="com.entities.Film"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Films - Liste et Film Aléatoire</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        /* Styles généraux */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        header, footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 15px;
        }

        h1 {
            color: #444;
            text-align: center;
            font-size: 2.5rem;
            margin-top: 20px;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin: 20px;
        }

        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 250px;
            overflow: hidden;
            text-align: center;
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease;
            margin-bottom: 20px;
        }

        .card img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-bottom: 2px solid #ddd;
        }

        .card-content {
            padding: 15px;
        }

        .card h3 {
            font-size: 1.5rem;
            color: #333;
            margin: 10px 0;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        }

        .card p {
            color: #555;
            font-size: 1rem;
            margin-bottom: 10px;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        }

        .card .btn-details {
            background-color: #f39c12;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .card .btn-details:hover {
            background-color: #e67e22;
        }

        .description {
            max-width: 200px;
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
            margin-bottom: 15px;
        }

        .no-films {
            text-align: center;
            color: #e50914;
            font-size: 1.2rem;
            padding: 20px;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            border-radius: 5px;
        }

        /* Styles pour le film aléatoire */
        .random-film-container {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 40px 0;
        }

        .random-film-container h2 {
            font-size: 2rem;
        }

        .random-film-image img {
            max-width: 500px;
            height: auto;
            margin: 20px 0;
            border-radius: 10px;
        }

        .random-film-button {
            background-color: #ff5733;
            color: white;
            padding: 18px 40px;
            text-decoration: none;
            font-size: 1.3em;
            border-radius: 30px;
            box-shadow: 0 4px 15px rgba(255, 87, 51, 0.5);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .random-film-button:hover {
            background-color: #e04a29;
            box-shadow: 0 6px 20px rgba(255, 87, 51, 0.7);
        }

        /* Media Queries for responsiveness */
        @media (max-width: 768px) {
            .card-container {
                flex-direction: column;
                align-items: center;
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

<div class="card-container">
    <% 
        List<Film> films = (List<Film>) request.getAttribute("ListFilms");
        if (films != null && !films.isEmpty()) {
            for (Film film : films) {
    %>
    <div class="card">
        <img src="<%= film.getPicture() %>" alt="<%= film.getTitle() %>">
        <div class="card-content">
            <h3><%= film.getTitle() %></h3>
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

<%@ include file="footer.jsp" %>

</body>
</html>
