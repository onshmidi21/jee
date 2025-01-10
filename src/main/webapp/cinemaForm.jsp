<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= (request.getAttribute("cinema") != null) ? "Modifier" : "Ajouter" %> un Cinéma</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #121212; /* Fond noir légèrement plus clair */
            color: #fff; /* Texte blanc */
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        h1 {
             color: #e67332; /* Rouge orangé moderne */
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(255, 111, 97, 0.3); /* Ombre textuelle */
        }
        form {
            background-color: #1e1e1e; /* Fond gris très foncé */
            padding: 30px;
            border-radius: 15px; /* Coins arrondis */
            box-shadow: 0 8px 16px rgba(255, 111, 97, 0.2); /* Ombre orange */
            border: 2px solid #ff6f61; /* Bordure orange */
            width: 100%;
            max-width: 600px;
            animation: fadeIn 0.5s ease-in-out; /* Animation d'apparition */
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        label {
            font-weight: bold;
            margin-top: 15px;
            display: block;
            color: #e67332 /* Rouge orangé moderne */
            font-size: 1.1em;
        }
        input[type="text"] {
            width: 100%;
            padding: 12px;
            margin-top: 8px;
            margin-bottom: 20px;
            border: 2px solid #ff6f61; /* Bordure orange */
            border-radius: 8px;
            box-sizing: border-box;
            background-color: #333; /* Fond gris foncé */
            color: #fff; /* Texte blanc */
            font-size: 1em;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        input[type="text"]:focus {
            border-color: #ff3b2f; /* Rouge plus vif au focus */
            box-shadow: 0 0 8px rgba(255, 59, 47, 0.5); /* Ombre portée au focus */
            outline: none;
        }
        button {
            background-color:  #e67332; /* Rouge orangé moderne */
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            font-size: 1.1em;
            transition: background-color 0.3s ease, transform 0.3s ease;
            width: 100%;
            margin-top: 20px;
        }
        button:hover {
            background-color: #ff3b2f; /* Rouge plus vif au survol */
            transform: translateY(-2px); /* Effet de levée */
        }
        a {
            display: inline-block;
            margin-top: 20px;
            color: #e67332 /* Rouge orangé moderne */
            text-decoration: none;
            font-weight: bold;
            font-size: 1.1em;
            transition: color 0.3s ease;
        }
        a:hover {
            color: #ff3b2f; /* Rouge plus vif au survol */
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1><%= (request.getAttribute("cinema") != null) ? "Modifier" : "Ajouter" %> un Cinéma</h1>
    <form action="cinemaAdmin" method="post">
        <input type="hidden" name="action" value="<%= (request.getAttribute("cinema") != null) ? "edit" : "add" %>">
        <%
            Cinema cinema = (Cinema) request.getAttribute("cinema");
            if (cinema != null) {
        %>
            <input type="hidden" name="id" value="<%= cinema.getId() %>">
        <%
            }
        %>
        <label for="name">Nom:</label>
        <input type="text" id="name" name="name" value="<%= (cinema != null) ? cinema.getName() : "" %>" required><br>
        <label for="address">Adresse:</label>
        <input type="text" id="address" name="address" value="<%= (cinema != null) ? cinema.getAdress() : "" %>" required><br>
        <button type="submit"><%= (cinema != null) ? "Modifier" : "Ajouter" %></button>
    </form>
    <a href="cinemaAdmin?action=list">Retour à la liste</a>
</body>
</html>