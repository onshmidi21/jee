<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entities.User, com.entities.Ticket, com.entities.Compte" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Paiement</title>
    <style>
        .payment-form {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
        }
        .error {
            color: red;
            margin: 10px 0;
        }
        .ticket-info {
            margin: 20px 0;
            padding: 15px;
            border: 1px solid #ddd;
        }
        button {
            padding: 10px 20px;
            cursor: pointer;
        }
        button[disabled] {
            opacity: 0.6;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <div class="payment-form">
        <%
        // Récupération des attributs
        User user = (User) session.getAttribute("user");
        Ticket ticket = (Ticket) request.getAttribute("ticket");
        Compte compte = (Compte) request.getAttribute("compte");
        String error = (String) request.getAttribute("error");
        
        // Vérification de la session utilisateur
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Affichage des erreurs
        if (error != null) {
        %>
            <p class="error"><%= error %></p>
        <%
        }
        
        // Affichage des informations de paiement
        if (ticket != null && compte != null && ticket.getSeance() != null && 
            ticket.getSeance().getSalle() != null && 
            ticket.getSeance().getSalle().getFilm() != null && 
            ticket.place != null) {
        %>
            <h2>Confirmation de paiement</h2>
            <div class="ticket-info">
                <p><strong>Film :</strong> <%= ticket.getSeance().getSalle().getFilm().getTitle() %></p>
                <p><strong>Séance :</strong> <%= ticket.getSeance().getDate() %></p>
                <p><strong>Place :</strong> <%= ticket.place.getRow() %>-<%= ticket.place.getCol() %></p>
                <p><strong>Montant à payer :</strong> <%= ticket.getSeance().getTarif() %> €</p>
                <p><strong>Votre solde :</strong> <%= compte.getSolde() %> €</p>
            </div>

            <form action="paiement" method="post">
                <input type="hidden" name="ticketId" value="<%=ticket.getId() %>">
                <button type="submit" 
                        <%= compte.getSolde() < ticket.getSeance().getTarif() ? "disabled" : "" %>>
                    Confirmer le paiement
                </button>
            </form>
        <%
        } else {
        %>
            <p>Les informations de paiement ne sont pas disponibles. Veuillez réessayer.</p>
            <a href="javascript:history.back()">Retour</a>
        <%
        }
        %>
    </div>
</body>
</html>