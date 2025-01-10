<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Films du Cinéma</title>
</head>
<body>
    <h1>Films du Cinéma</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Titre</th>
            <th>Réalisateur</th>
            <th>Durée</th>
        </tr>
        <%
            // Récupération de la liste des films à partir de l'attribut de requête
            List<Film> films = (List<Film>) request.getAttribute("films");
            if (films != null && !films.isEmpty()) {
                for (Film film : films) {
        %>
                    <tr>
                        <td><%= film.getId() %></td>
                        <td><%= film.getTitle() %></td>
                        <td><%= film.getDirector() %></td>
                        <td><%= film.getDuration() %> minutes</td>
                    </tr>
        <%
                }
            } else {
        %>
                <tr>
                    <td colspan="4" style="text-align: center;">Aucun film disponible</td>
                </tr>
        <%
            }
        %>
    </table>
    <a href="cinemaAdmin?action=list">Retour à la liste des cinémas</a>
</body>
</html>
