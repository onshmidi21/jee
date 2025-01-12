<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entities.Place, com.entities.Seance" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Paiement </title>
</head>
<body>
    <div class="container">
        <h1>Confirmation de paiement</h1>
        <%
            Place place = (Place) request.getAttribute("place");
            Seance seance = (Seance) request.getAttribute("seance");

            if (place == null || seance == null) {
                out.println("<p style='color: red;'>Erreur : Place ou séance non trouvée.</p>");
            } else {
        %>
                <p>Place: <%= place.getRow() %>-<%= place.getCol() %></p>
                <p>Séance: <%= seance.getSalle().getFilm().getTitle() %></p>
                <p>Prix: <%= seance.getTarif() %> €</p>

                
        <%
            }
        %>
    </div>

   
</body>
</html>