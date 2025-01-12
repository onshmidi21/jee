<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entities.Ticket, com.entities.Seance, com.entities.Place" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket de réservation</title>
    <%
        Ticket ticket = (Ticket) request.getAttribute("ticket");
        Seance seance = (Seance) request.getAttribute("seance");
        Place place = (Place) request.getAttribute("place");

        if (ticket != null && seance != null && place != null) {
            String imageUrl = seance.getSalle().getFilm().getPicture(); // URL de l'image du film
    %>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #121212; /* Fond noir */
            color: #ffffff; /* Texte blanc */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-image: url('<%= seance.getSalle().getFilm().getPicture() %>'); /* Image de fond */
            background-size: cover; /* Couvre toute la page */
            background-position: center; /* Centre l'image */
            background-blend-mode: overlay; /* Mélange l'image avec le fond noir */
            background-color: rgba(18, 18, 18, 0.8); /* Fond semi-transparent pour améliorer la lisibilité */
        }
        .ticket {
            background-color: rgba(30, 30, 30, 0.9); /* Fond gris très foncé semi-transparent */
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(255, 0, 0, 0.3); /* Ombre rouge */
            max-width: 600px;
            width: 100%;
            text-align: center;
        }
        .ticket h1 {
            color: #FFA500; /* Orange vif */
            margin-bottom: 20px;
            font-size: 2em;
        }
        .ticket img {
            max-width: 150px; /* Taille réduite pour s'adapter au format horizontal */
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px; /* Espacement sous l'image */
        }
        .ticket-info {
            margin-top: 20px;
        }
        .ticket-info div {
            margin-bottom: 15px;
            font-size: 1.1em;
            color: #ffffff; /* Texte blanc */
        }
        .ticket-info strong {
            color: #FFA500; /* Orange vif */
        }
        .ticket-footer {
            text-align: center;
            margin-top: 30px;
        }
        .ticket-footer button {
            background-color: #FFA500; /* Orange vif */
            color: #ffffff; /* Texte blanc */
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1em;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .ticket-footer button:hover {
            background-color: #cc8400; /* Orange plus foncé au survol */
            transform: scale(1.05);
        }
        .ticket-footer .error {
            color: #ff3b2f; /* Rouge vif */
            font-weight: bold;
        }

        /* Styles pour l'impression */
        @media print {
            body {
                background-color: #ffffff; /* Fond blanc pour l'impression */
                color: #000000; /* Texte noir pour l'impression */
                -webkit-print-color-adjust: exact; /* Force l'impression des couleurs */
                color-adjust: exact; /* Standard CSS pour l'impression des couleurs */
            }
            .ticket {
                background-color: #ffffff; /* Fond blanc pour l'impression */
                color: #000000; /* Texte noir pour l'impression */
                box-shadow: none; /* Supprimer l'ombre pour l'impression */
                border: 1px solid #000000; /* Ajouter une bordure pour l'impression */
            }
            .ticket h1 {
                color: #FFA500; /* Conserver la couleur orange pour le titre */
            }
            .ticket-info div {
                color: #000000; /* Texte noir pour l'impression */
            }
            .ticket-info strong {
                color: #FFA500; /* Conserver la couleur orange pour les labels */
            }
            .ticket-footer {
                display: none; /* Masquer les boutons lors de l'impression */
            }
        }
    </style>
</head>
<body>
    <div class="ticket">
        <!-- Afficher l'image du film -->
        <img src="<%= imageUrl %>" alt="Affiche du film <%= seance.getSalle().getFilm().getTitle() %>">
        
        <div class="ticket-info">
            <h1>Ticket</h1>
            <div><strong>Num de Ticket :</strong> <%= ticket.getId() %></div>
            <div><strong>Date de Séance :</strong> <%= seance.getDate() %></div>
            <div><strong>Horaire de Séance :</strong> <%= seance.getHoraire() %></div>
            <div><strong>Film :</strong> <%= seance.getSalle().getFilm().getTitle() %></div>
            <div><strong>Rangée :</strong> <%= place.getRow() %></div>
            <div><strong>Colonne :</strong> <%= place.getCol() %></div>
            <div><strong>Prix :</strong> <%= seance.getTarif() %> €</div>
            <div><strong>Statut :</strong> Réservée</div>
        </div>
        <%
            } else {
        %>
                <div class="error">Erreur : Informations manquantes pour afficher le ticket.</div>
        <%
            }
        %>
        <div class="ticket-footer">
            <button onclick="window.print()">Imprimer le ticket</button>
            <% if (ticket != null) { %>
                <form action="${pageContext.request.contextPath}/films" method="get" style="display: inline;">
                    <button type="submit">Retour à la page d'accueil</button>
                </form>
            <% } else { %>
                <p class="error">Erreur: Ticket non disponible</p>
            <% } %>
        </div>
    </div>
</body>
</html>