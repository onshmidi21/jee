<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.entities.Salle" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Salles</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #ffff; /* Fond noir légèrement plus clair */
            color: #fff; /* Texte blanc */
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #ff8c42; /* Orange moderne */
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(255, 140, 66, 0.3); /* Ombre textuelle */
        }
        a {
            color: #ff8c42; /* Orange moderne */
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s ease; /* Transition fluide */
        }
        a:hover {
            color: #ff6b1a; /* Orange plus vif au survol */
        }
        .add-button {
            display: inline-block;
            background-color: #ff8c42; /* Orange moderne */
            color: #fff;
            padding: 10px 20px;
            border-radius: 25px; /* Coins arrondis */
            text-align: center;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(255, 140, 66, 0.2); /* Ombre portée */
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .add-button:hover {
            background-color: #ff6b1a; /* Orange plus vif au survol */
            transform: translateY(-2px); /* Effet de levée */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #2a2a2a; /* Fond gris très foncé */
            border-radius: 10px; /* Coins arrondis */
            overflow: hidden; /* Pour que les coins arrondis fonctionnent */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3); /* Ombre portée */
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #444; /* Bordure grise */
        }
        th {
            background-color: #ff8c42; /* Orange moderne pour l'en-tête */
            color: #fff;
            font-weight: bold;
            text-transform: uppercase; /* Texte en majuscules */
        }
        tr:hover {
            background-color: #333; /* Fond gris foncé au survol */
        }
        .actions a {
            margin-right: 10px;
            padding: 5px 10px;
            border-radius: 15px; /* Coins arrondis */
            background-color: #444; /* Fond gris foncé */
            color: #ff8c42; /* Orange moderne */
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .actions a:hover {
            background-color: #ff8c42; /* Orange moderne */
            color: #fff; /* Texte blanc au survol */
        }
        .no-data {
            text-align: center;
            color: #ff8c42; /* Orange moderne */
            font-weight: bold;
            padding: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="headerAdmin.jsp" %>

    <h1>Liste des Salles</h1>
    <a href="salleAdmin?action=add" class="add-button">Ajouter une Salle</a>
    <table>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Capacité</th>
            <th>Cinéma</th> <!-- Nouvelle colonne pour afficher le cinéma -->
            <th>Actions</th>
        </tr>
        
        <% 
        // Récupérer la liste des salles depuis l'attribut de requête
        List<Salle> salles = (List<Salle>) request.getAttribute("salles");
        
        // Vérifier si la liste des salles n'est pas vide
        if (salles != null && !salles.isEmpty()) {
            for (Salle salle : salles) {
        %>
                <tr>
                    <td><%= salle.getId() %></td>
                    <td><%= salle.getName() %></td>
                    <td><%= salle.getCapacite() %></td>
                    <td>
                        <% if (salle.getCinema() != null) { %>
                            <%= salle.getCinema().getName() %> <!-- Afficher le nom du cinéma -->
                        <% } else { %>
                            Aucun cinéma associé
                        <% } %>
                    </td>
                    <td class="actions">
                        <a href="salleAdmin?action=edit&id=<%= salle.getId() %>">Modifier</a>
                        <a href="salleAdmin?action=delete&id=<%= salle.getId() %>" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette salle ?')">Supprimer</a>
                    </td>
                </tr>
        <%  
            }
        } else {
        %>
            <tr>
                <td colspan="5" class="no-data">Aucune salle disponible</td> <!-- colspan mis à jour à 5 -->
            </tr>
        <%
        }
        %>
    </table>
    <%@ include file="footerAdmin.jsp" %>
</body>
</html>