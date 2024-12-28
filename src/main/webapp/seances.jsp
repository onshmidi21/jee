<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.entities.Seance" %>
<%@ page import="com.entities.Film" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Seances du Film</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            color: #e50914;
            margin-top: 20px;
        }

        .film-info {
            background-color: #fff;
            margin: 20px auto;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 80%;
            border-radius: 8px;
        }

        .film-info img {
            max-width: 100%;
            height: auto;
            max-height: 400px;
            border-radius: 8px;
            display: block;
            margin: 0 auto;
        }

        .film-info h2 {
            font-size: 24px;
            color: #e50914;
        }

        .film-info p {
            font-size: 16px;
            color: #333;
            margin: 5px 0;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #e50914;
            color: white;
            font-size: 16px;
        }

        td {
            font-size: 14px;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .no-seances {
            text-align: center;
            color: #e50914;
            font-size: 18px;
        }

        .btn-reserve {
            padding: 5px 10px;
            background-color: #e50914;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-reserve:hover {
            background-color: #c40712;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<%-- Récupération du film --%>
<%
    Film film = (Film) request.getAttribute("film");
%>

<%-- Affichage des informations du film --%>
<div class="film-info">
    <h1><%= film.getTitle() %></h1>
    <div class="film-info img">
        <img src="<%= film.getPicture() %>" alt="<%= film.getTitle() %>">
    </div>
    <p><strong>Description:</strong> <%= film.getDescription() != null ? film.getDescription() : "Aucune description disponible." %></p>
    <p><strong>Réalisateur:</strong> <%= film.getDirector() %></p>
    <p><strong>Type:</strong> <%= film.getType() %></p>
    <p><strong>Durée:</strong> <%= film.getDuration() %> min</p>
    <p><strong>Date de sortie:</strong> <%= new java.text.SimpleDateFormat("dd MMM yyyy").format(film.getDate()) %></p>
</div>

<h1>Seances du Film</h1>

<%-- Vérification si des séances existent --%>
<%
    List<Seance> seances = (List<Seance>) request.getAttribute("seances");
    if (seances != null && !seances.isEmpty()) {
%>
    <table>
        <thead>
            <tr>
                <th>Date</th>
                <th>Horaire</th>
                <th>Salle</th>
                <th>Cinema</th>
                <th>Réserver</th>
            </tr>
        </thead>
        <tbody>
            <%-- Affichage de chaque séance --%>
            <% 
                for (Seance seance : seances) {
                    String salleName = (seance.salle != null && seance.salle.salle != null) ? seance.salle.salle.getName() : "Salle inconnue";
                    String cinemaName = (seance.salle != null && seance.salle.salle != null) ? seance.salle.salle.cinema.getName() : "Salle inconnue";
            %>
                <tr>
                    <td><%= seance.getDate() %></td>
                    <td><%= seance.getHoraire() %></td>
                    <td><%= salleName %></td>
                    <td><%= cinemaName %></td>
                    <td>
                        <<form action="reservation" method="GET">
    <input type="hidden" name="seance_id" value="<%= seance.getId() %>">
    <button class="btn-reserve" type="submit">Réserver</button>
</form>

                    </td>
                </tr>
            <% 
                }
            %>
        </tbody>
    </table>
<%-- Si aucune séance n'est trouvée --%>
<%
    } else {	
%>
    <p class="no-seances">Aucune séance n'est disponible pour ce film.</p>
<%
    }
%>

<%@ include file="footer.jsp" %>

</body>
</html>
