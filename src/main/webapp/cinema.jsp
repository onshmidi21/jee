<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.entities.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Cinémas</title>
    <style>
        /* General Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f8f8f8;
            color: #333;
        }

        h1, h2 {
            color: #e50914;
            text-align: center;
            font-size: 2em;
        }

        h3 {
            font-size: 1.4em;
            color: #333;
        }

        /* Cinema list styles */
        .cinema-list {
            margin: 20px auto;
            width: 90%;
            max-width: 1200px;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .cinema-card {
            display: block;
            width: 30%;
            padding: 20px;
            background-color: #fff;
            color: #333;
            text-decoration: none;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            text-align: center;
        }

        .cinema-card:hover {
            background-color: #e50914;
            color: #fff;
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .cinema-card h3 {
            font-size: 1.6em;
            margin: 0;
            color: #fff;
        }

        .cinema-card p {
            margin: 10px 0;
            font-size: 1em;
        }

        /* Film list styles */
        .film {
            background-color: #fff;
            padding: 20px;
            margin: 15px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .film:hover {
            background-color: #f1f1f1;
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .film p {
            margin: 5px 0;
            font-size: 1em;
        }

        .message {
            text-align: center;
            color: #888;
            font-size: 1.2em;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .cinema-card {
                width: 45%;
                margin-bottom: 20px;
            }

            .film {
                padding: 15px;
                font-size: 0.9em;
            }
        }

        @media (max-width: 480px) {
            .cinema-card {
                width: 100%;
            }
        }

        /* Adaptation des images */
        .film img {
            width: 100%;
            height: auto;
            max-width: 300px;
            border-radius: 10px;
            margin-bottom: 15px;
        }

    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<h1>Liste des Cinémas</h1>

<div class="cinema-list">
    <%
        List<Cinema> cinemas = (List<Cinema>) request.getAttribute("cinemas");
        if (cinemas != null && !cinemas.isEmpty()) {
            for (Cinema cinema : cinemas) {
    %>
        <a href="?cinemaId=<%= cinema.getId() %>" class="cinema-card">
            <h3><%= cinema.getName() %></h3>
            <p><%= cinema.getAdress() %></p>
        </a>
    <%
            }
        } else {
    %>
        <p class="message">Aucun cinéma disponible.</p>
    <%
        }
    %>
</div>

<%
    // Vérifier si des films sont disponibles pour un cinéma sélectionné
    List<Film> films = (List<Film>) request.getAttribute("films");
    if (films != null) {
%>
    <h2>Films disponibles dans ce cinéma</h2>
    <div class="film-list">
    <%
        if (!films.isEmpty()) {
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
        } else {
    %>
        <p class="message">Aucun film trouvé pour ce cinéma.</p>
    <%
        }
    %>
    </div>
<%
    }
%>

</body>
<%@ include file="footer.jsp" %>

</html>
