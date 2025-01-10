<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entities.Ticket" %>
<%@ page import="com.entities.Seance" %>
<%@ page import="com.entities.Place" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket de réservation</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            color: #333;
        }
        .ticket {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            width: 400px;
            margin: 50px auto;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .ticket h1 {
            text-align: center;
        }
        .ticket-info {
            margin-top: 20px;
        }
        .ticket-info div {
            margin-bottom: 10px;
        }
        .ticket-footer {
            text-align: center;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="ticket">
    
        <h1>Réservation Confirmée</h1>
        <div class="ticket-info">
            <% 
                Ticket ticket = (Ticket) request.getAttribute("ticket");
                Seance seance = (Seance) request.getAttribute("seance");
                Place place = (Place) request.getAttribute("place");

                if (ticket != null && seance != null && place != null) {
            %>
                <div><strong>Ticket ID :</strong> <%= ticket.getId() %></div>
                <div><strong>Séance :</strong> <%= seance.getDate() %></div>
                
                <div><strong>Film :</strong> <%= seance.salle.film.getTitle() %></div>
                <div><strong>Rangée :</strong> <%= place.getRow() %></div>
                <div><strong>Colonne :</strong> <%= place.getCol() %></div>
                <div><strong>Prix :</strong> <%= seance.getTarif() %> €</div>
                <div><strong>Statut :</strong> Réservée</div>
            <% 
                } else {
            %>
                <div>Erreur : Informations manquantes pour afficher le ticket.</div>
            <% 
                }
            %>
            
        </div>
        <div class="ticket-footer">
            <button onclick="window.print()">Imprimer le ticket</button>
            <!-- Bouton de redirection vers la phase de paiement -->
            <!-- Avant le formulaire, ajoutez cette vérification -->
<% if (ticket != null) { %>
    <form action="paiement" method="get">
    <input type="hidden" name="ticketId" value="<%= ticket.getId() %>">
    <button type="submit">Passer à la phase de paiement</button>
</form>

<% } else { %>
    <p class="error">Erreur: Ticket non disponible</p>
<% } %>
        </div>
    </div>
</body>
<jsp:include page="footer.jsp"/>

</html>