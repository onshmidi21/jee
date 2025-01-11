<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion</title>
    <style>
        /* Style général */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Utilise toute la hauteur de la fenêtre */
        }

        /* Header */
        header {
            background-color: #000; /* Noir */
            color: #fff;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        header h1 {
            margin: 0;
            font-size: 28px;
            font-weight: bold;
        }

        /* Conteneur principal pour centrer le formulaire */
        .container {
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            padding: 30px;
            width: 100%;
            max-width: 400px; /* Largeur maximale du formulaire */
            margin: auto; /* Centre le conteneur */
            flex: 1; /* Permet au conteneur de prendre l'espace disponible */
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        /* Titre du formulaire */
        .container h1 {
            color: #333333;
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
        }

        /* Labels et champs de formulaire */
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            text-align: left;
            color: #555;
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
            border-color: #4caf50; /* Vert au focus */
        }

        /* Bouton de connexion */
        button {
            background-color: #000000; /* Noir */
            color: white;
            border: none;
            padding: 12px 15px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #333333; /* Gris foncé au survol */
        }

        /* Message d'erreur */
        p.error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
            text-align: center;
        }

        /* Footer */
        footer {
            background-color: #000; /* Noir */
            color: #fff;
            text-align: center;
            padding: 15px;
            margin-top: auto; /* Place le footer en bas */
            box-shadow: 0 -4px 8px rgba(0, 0, 0, 0.2);
        }

        footer p {
            margin: 0;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    
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

   

    <jsp:include page="footer.jsp"/>
</body>
</html>