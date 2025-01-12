<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entities.Place, com.entities.Seance" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmation de paiement</title>
     <%
            Place place = (Place) request.getAttribute("place");
            Seance seance = (Seance) request.getAttribute("seance");

            if (place == null || seance == null) {
                out.println("<p class='error-message'>Erreur : Place ou séance non trouvée.</p>");
            } else {
        %>
    <style>
      
        body {
            font-family: Arial, sans-serif;
            background-color: #121212; /* Fond noir par défaut */
            color: #ffffff; /* Texte blanc */
            padding: 20px;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('<%= seance.getSalle().getFilm().getPicture() %>'); /* Image de fond */
            background-size: cover; /* Couvre toute la page */
            background-position: center; /* Centre l'image */
            background-blend-mode: overlay; /* Mélange l'image avec le fond noir */
            background-color: rgba(18, 18, 18, 0.8); /* Fond semi-transparent pour améliorer la lisibilité */}
        
        .container {
            background-color: rgba(30, 30, 30, 0.9); /* Fond gris très foncé semi-transparent */
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(255, 0, 0, 0.3); /* Ombre rouge */
            max-width: 600px;
            width: 100%;
            text-align: center;
        }
        h1 {
            color: #FFA500; /* Rouge vif */
            margin-bottom: 20px;
            font-size: 2em;
        }
        p {
            color: #ffffff; /* Texte blanc */
            font-size: 1.1em;
            margin: 10px 0;
        }
        strong {
            color: #FFA500; /* Rouge vif */
        }
        .btn {
            display: inline-block;
            padding: 12px 24px;
            margin: 10px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .btn-confirm {
            background-color: #FFA500; 
            color: #ffffff; /* Texte blanc */
        }
        .btn-confirm:hover {
            background-color: #FFA500; 
            transform: scale(1.05);
        }
        .btn-cancel {
            background-color: #333333; /* Gris foncé */
            color: #ffffff; /* Texte blanc */
        }
        .btn-cancel:hover {
            background-color: #555555; /* Gris plus clair au survol */
            transform: scale(1.05);
        }
        .error-message {
            color: #FFA500; /* Rouge vif */
            font-weight: bold;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Confirmation de paiement</h1>
     
                <p><strong>Place :</strong> <%= place.getRow() %>-<%= place.getCol() %></p>
                <p><strong>Film :</strong> <%= seance.getSalle().getFilm().getTitle() %></p>
                <p><strong>Date :</strong> <%= seance.getDate() %></p>
                <p><strong>Prix :</strong> <%= seance.getTarif() %> €</p>

                <form action="validerPaiement" method="post" onsubmit="return verifierFormulaire()">
                    <input type="hidden" name="placeId" value="<%= place.getIdPlace() %>">
                    <input type="hidden" name="seanceId" value="<%= seance.getId() %>">
                    <button type="submit" class="btn btn-confirm">Confirmer le paiement</button>
                </form>

                <a href="${pageContext.request.contextPath}/films" class="btn btn-cancel">Annuler</a>
        <%
            }
        %>
    </div>

    <script>
        function verifierFormulaire() {
            const placeId = document.querySelector('input[name="placeId"]').value;
            const seanceId = document.querySelector('input[name="seanceId"]').value;

            console.log("placeId:", placeId);
            console.log("seanceId:", seanceId);

            alert("placeId: " + placeId + "\nseanceId: " + seanceId);

            return true; // Autorise la soumission du formulaire
        }
    </script>
</body>
</html>