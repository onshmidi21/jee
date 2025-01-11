<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entities.Place, com.entities.Seance" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmation de paiement</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        h1 {
            color: #333;
        }
        p {
            color: #555;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
        }
        .btn-confirm {
            background-color: #28a745;
            color: #fff;
        }
        .btn-cancel {
            background-color: #dc3545;
            color: #fff;
        }
    </style>
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
                <p><strong>Place :</strong> <%= place.getRow() %>-<%= place.getCol() %></p>
                <p><strong>Film :</strong> <%= seance.getSalle().getFilm().getTitle() %></p>
                <p><strong>Date :</strong> <%= seance.getDate() %></p>
                <p><strong>Prix :</strong> <%= seance.getTarif() %> €</p>

    <form action="validerPaiement" method="post">
    <input type="hidden" name="placeId" value="<%= place.getIdPlace() %>">
    <input type="hidden" name="seanceId" value="<%= seance.getId() %>">
    <button type="submit" class="btn btn-confirm">Confirmer le paiement</button>
</form>


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

                <a href="${pageContext.request.contextPath}/reservation" class="btn btn-cancel">Annuler</a>
        <%
            }
        %>
    </div>
</body>
</html>