<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.entities.Seance" %>
<%@ page import="com.entities.Film" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Détails du Film</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Styles généraux */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', sans-serif;
        }

        body {
            background-color: #f4f4f4;
            color: #333;
        }

        h1 {
            text-align: center;
            color: #ff6f00;
            margin-top: 20px;
            font-size: 2.5rem;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin: 20px auto;
            width: 90%;
        }

        .film-details {
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 30%;
            text-align: center;
        }

        .film-details img {
            max-width: 100%;
            height: auto;
            max-height: 400px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .film-details h2 {
            font-size: 24px;
            color: #ff6f00;
        }

        .film-details p {
            font-size: 16px;
            color: #555;
            margin: 10px 0;
        }

        .film-actions {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-like, .btn-love {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 16px;
        }

        .btn-like {
            background-color: #ff6f00;
            color: white;
        }

        .btn-like.active {
            background-color: #e65c00; /* Couleur plus foncée */
        }

        .btn-love {
            background-color: #ff1493;
            color: white;
        }

        .btn-love.active {
            background-color: #c71585; /* Couleur plus foncée */
        }

        .seances-list {
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 65%;
        }

        .seance-card {
            margin-bottom: 15px;
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }

        .seance-card:last-child {
            border-bottom: none;
        }

        .seance-card h3 {
            font-size: 18px;
            color: #ff6f00;
            margin-bottom: 10px;
        }

        .seance-card p {
            font-size: 14px;
            color: #555;
            margin: 5px 0;
        }

        .btn-reserve {
            padding: 10px 20px;
            background-color: #ff6f00;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }

        .btn-reserve:hover {
            background-color: #e65c00;
        }

        .no-seances {
            text-align: center;
            color: #ff6f00;
            font-size: 18px;
            margin: 20px 0;
        }

        /* Media Queries for responsiveness */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .film-details, .seances-list {
                width: 100%;
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<%-- Récupération de l'identifiant du film --%>
<%
    String filmId = request.getParameter("filmId");
    Film film = (Film) request.getAttribute("film");
%>


<div class="container">
    <%-- Colonne de gauche : Affiche et informations du film --%>
    <div class="film-details">
        <img src="<%= film.getPicture() %>" alt="<%= film.getTitle() %>">
        <h2><%= film.getTitle() %></h2>
        <p><strong>Description:</strong> <%= film.getDescription() != null ? film.getDescription() : "Aucune description disponible." %></p>
        <p><strong>Réalisateur:</strong> <%= film.getDirector() %></p>
        <p><strong>Type:</strong> <%= film.getType() %></p>
        <p><strong>Durée:</strong> <%= film.getDuration() %> min</p>
        <p><strong>Date de sortie:</strong> <%= new java.text.SimpleDateFormat("dd MMM yyyy").format(film.getDate()) %></p>
        
        <!-- Boutons Like et J'adore -->
        <div class="film-actions">
            <button id="btn-like" class="btn-like"><i class="fas fa-thumbs-up"></i> Like</button>
            <button id="btn-love" class="btn-love"><i class="fas fa-heart"></i> J'adore</button>
        </div>
    </div>

    <%-- Colonne de droite : Liste des séances --%>
    <div class="seances-list">
        <h2>Séances disponibles</h2>
        <%-- Vérification si des séances existent --%>
        <%
            List<Seance> seances = (List<Seance>) request.getAttribute("seances");
            if (seances != null && !seances.isEmpty()) {
                for (Seance seance : seances) {
                    String salleName = (seance.salle != null && seance.salle.salle != null) ? seance.salle.salle.getName() : "Salle inconnue";
                    String cinemaName = (seance.salle != null && seance.salle.salle != null) ? seance.salle.salle.cinema.getName() : "Salle inconnue";
        %>
            <div class="seance-card">
                <h3><%= seance.getDate() %></h3>
                <p><strong>Horaire:</strong> <%= seance.getHoraire() %></p>
                <p><strong>Salle:</strong> <%= salleName %></p>
                <p><strong>Cinéma:</strong> <%= cinemaName %></p>
                <form action="reservation" method="GET">
                    <input type="hidden" name="seance_id" value="<%= seance.getId() %>">
                    <button class="btn-reserve" type="submit">Réserver</button>
                </form>
            </div>
        <%
                }
            } else {
        %>
            <p class="no-seances">Aucune séance n'est disponible pour ce film.</p>
        <%
            }
        %>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    // Récupérer les boutons
    const btnLike = document.getElementById('btn-like');
    const btnLove = document.getElementById('btn-love');

    // Gestionnaire d'événement pour le bouton "Like"
    btnLike.addEventListener('click', function() {
        // Basculer la classe active
        btnLike.classList.toggle('active');
    });

    // Gestionnaire d'événement pour le bouton "J'adore"
    btnLove.addEventListener('click', function() {
        // Basculer la classe active
        btnLove.classList.toggle('active');
    });
</script>

</body>
</html>