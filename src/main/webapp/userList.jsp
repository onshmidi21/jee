<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.entities.*" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Utilisateurs</title>
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
        .add-user {
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
        .add-user:hover {
            background-color: #ff6b1a; /* Orange plus vif au survol */
            transform: translateY(-2px); /* Effet de levée */
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

    <h1>Liste des Utilisateurs</h1>
    <a class="add-user" href="userAdmin?action=add">Ajouter un Utilisateur</a>
    <table>
        <tr>
            <th>ID</th>
            <th>Login</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Email</th>
            <th>Adresse</th>
            <th>Actions</th>
        </tr>
        <% 
            List<User> users = (List<User>) request.getAttribute("users");
            if (users != null && !users.isEmpty()) {
                for (User user : users) {
        %>
                    <tr>
                        <td><%= user.getId() %></td>
                        <td><%= user.getLogin() %></td>
                        <td><%= user.getName() %></td>
                        <td><%= user.getFirstname() %></td>
                        <td><%= user.getEmail() %></td>
                        <td><%= user.getAdress() %></td>
                        <td class="actions">
                            <a href="userAdmin?action=edit&id=<%= user.getId() %>">Modifier</a>
                            <a href="userAdmin?action=delete&id=<%= user.getId() %>" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet utilisateur ?')">Supprimer</a>
                        </td>
                    </tr>
        <%  
                }
            } else {
        %>
                <tr>
                    <td colspan="7" class="no-data">Aucun utilisateur disponible</td>
                </tr>
        <%
            }
        %>
    </table>
    <%@ include file="footerAdmin.jsp" %>
</body>
</html>