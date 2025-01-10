<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.entities.Film"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getAttribute("film") != null ? "Modifier" : "Ajouter" %> un Film</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #fffff; /* Fond noir légèrement plus clair */
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
            color: #ff6f61; /* Rouge orangé moderne */
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
            color: #ff6f61; /* Rouge orangé moderne */
            font-size: 1.1em;
        }
        input[type="text"], input[type="date"], textarea {
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
        input[type="text"]:focus, input[type="date"]:focus, textarea:focus {
            border-color: #ff3b2f; /* Rouge plus vif au focus */
            box-shadow: 0 0 8px rgba(255, 59, 47, 0.5); /* Ombre portée au focus */
            outline: none;
        }
        textarea {
            height: 120px;
            resize: vertical; /* Permet de redimensionner verticalement */
        }
        button {
            background-color: #ff6f61; /* Rouge orangé moderne */
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
            color: #ff6f61; /* Rouge orangé moderne */
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
    <h1><%= request.getAttribute("film") != null ? "Modifier" : "Ajouter" %> un Film</h1>
    <form action="filmAdmin" method="post">
        <input type="hidden" name="action" value="<%= request.getAttribute("film") != null ? "edit" : "add" %>">
        <% if (request.getAttribute("film") != null) { %>
            <input type="hidden" name="id" value="<%= ((Film) request.getAttribute("film")).getId() %>">
        <% } %>
        <label for="title">Titre:</label>
        <input type="text" id="title" name="title" value="<%= request.getAttribute("film") != null ? ((Film) request.getAttribute("film")).getTitle() : "" %>" required><br>
        <label for="director">Réalisateur:</label>
        <input type="text" id="director" name="director" value="<%= request.getAttribute("film") != null ? ((Film) request.getAttribute("film")).getDirector() : "" %>" required><br>
        <label for="type">Type:</label>
        <input type="text" id="type" name="type" value="<%= request.getAttribute("film") != null ? ((Film) request.getAttribute("film")).getType() : "" %>" required><br>
        <label for="actors">Acteurs:</label>
        <input type="text" id="actors" name="actors" value="<%= request.getAttribute("film") != null ? ((Film) request.getAttribute("film")).getActors() : "" %>" required><br>
        <label for="duration">Durée (HH:MM):</label>
        <input type="text" id="duration" name="duration" value="<%= request.getAttribute("film") != null ? ((Film) request.getAttribute("film")).getDuration().toString().substring(0, 5) : "" %>" required><br>
        <label for="picture">Image (URL):</label>
        <input type="text" id="picture" name="picture" value="<%= request.getAttribute("film") != null ? ((Film) request.getAttribute("film")).getPicture() : "" %>"><br>
        <label for="date">Date:</label>
        <input type="date" id="date" name="date" value="<%= request.getAttribute("film") != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(((Film) request.getAttribute("film")).getDate()) : "" %>" required><br>
        <label for="description">Description:</label>
        <textarea id="description" name="description"><%= request.getAttribute("film") != null ? ((Film) request.getAttribute("film")).getDescription() : "" %></textarea><br>
        <button type="submit"><%= request.getAttribute("film") != null ? "Modifier" : "Ajouter" %></button>
    </form>
    <a href="filmAdmin?action=list">Retour à la liste</a>
</body>
</html>