<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion</title>
    <style>
        /* Applique Flexbox au body */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            flex-direction: column; /* Empêche les éléments d'aller sur plusieurs lignes */
            height: 100vh; /* Utilise toute la hauteur de la fenêtre */
            margin: 0;
        }

        /* Conteneur principal pour centrer le contenu */
        .container {
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            padding: 20px;
            width: 300px;
            text-align: center;
            margin-top: 50px; /* Ajoute un espace au-dessus du formulaire */
            margin-bottom: 50px; /* Ajoute un espace sous le formulaire */
            flex: 1; /* Permet au formulaire de prendre de la place */
        }

        /* Style du header */
       
        h1 {
            color: #333333;
            font-size: 24px;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            text-align: left;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #4caf50;
        }

        button {
            background-color: #000000; /* Noir */
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #333333; /* Gris foncé au survol */
        }

        p.error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>
<%@ include file="header.jsp" %>

<body>

    <header>
        <!-- Ton contenu de header ici -->
        <h1>Bienvenue sur le site</h1>
    </header>

    <div class="container">
        <h1>Connexion</h1>
        <form action="login" method="post">
            <label for="login">Login :</label>
            <input type="text" id="login" name="login" placeholder="Entrez votre login" required>

            <label for="password">Mot de passe :</label>
            <input type="password" id="password" name="password" placeholder="Entrez votre mot de passe" required>

            <button type="submit">Se connecter</button>
        </form>

        <!-- Affichage du message d'erreur -->
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null && !errorMessage.isEmpty()) {
        %>
            <p class="error-message"><%= errorMessage %></p>
        <%
            }
        %>
    </div>

    <footer>
        <!-- Ton contenu de footer ici -->
        <p>&copy; 2024 Cinéma Application. Tous droits réservés.</p>
    </footer>

</body>
<jsp:include page="footer.jsp"/>

</html>
