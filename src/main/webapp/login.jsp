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
            background-color: #000; /* Fond noir */
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Utilise toute la hauteur de la fenêtre */
        }

        /* Header */
        header {
            background-color: #000; /* Noir */
            color: #fff;
            padding: 10px 20px; /* Padding réduit pour un header plus petit */
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        header h1 {
            margin: 0;
            font-size: 24px; /* Taille de police légèrement réduite */
            font-weight: bold;
        }

        /* Conteneur principal pour centrer le formulaire */
        .container {
            background-color: #333; /* Gris foncé */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            padding: 40px; /* Plus de padding pour plus d'espace */
            width: 100%;
            max-width: 400px; /* Largeur maximale du formulaire */
            margin: 40px auto; /* Centre le conteneur avec plus d'espace */
            flex: 1; /* Permet au conteneur de prendre l'espace disponible */
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        /* Titre du formulaire */
        .container h1 {
            color: #fff; /* Texte blanc */
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
        }

        /* Labels et champs de formulaire */
        label {
            display: block;
            margin-bottom: 10px; /* Plus d'espace entre les labels et les champs */
            font-weight: bold;
            text-align: left;
            color: #fff; /* Texte blanc */
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px; /* Plus de padding pour les champs */
            margin-bottom: 20px; /* Plus d'espace entre les champs */
            border: 1px solid #555; /* Bordure grise */
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s ease, background-color 0.3s ease;
            background-color: #444; /* Fond gris */
            color: #fff; /* Texte blanc */
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #4caf50; /* Vert au focus */
            background-color: #555; /* Fond gris plus clair au focus */
        }

        /* Bouton de connexion */
        button {
            background-color: #000; /* Noir */
            color: white;
            border: none;
            padding: 15px 20px; /* Plus de padding pour le bouton */
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease, color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Ombre légère */
        }

        button:hover {
            background-color: #FFA500; /* Jaune au survol */
            color: #000; /* Texte noir au survol */
            transform: translateY(-5px); /* Effet de décoller */
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.2); /* Ombre plus prononcée */
        }

        /* Message d'erreur */
        p.error-message {
            color: red;
            font-size: 14px;
            margin-top: 15px; /* Plus d'espace pour le message d'erreur */
            text-align: center;
        }

        /* Lien vers la page d'inscription */
        p.register-link {
            text-align: center;
            margin-top: 20px; /* Espacement avec le formulaire */
            color: #fff; /* Texte blanc */
        }

        p.register-link a {
            color: #FFA500; /* Couleur orange pour le lien */
            text-decoration: none; /* Pas de soulignement */
            font-weight: bold;
            transition: color 0.3s ease;
        }

        p.register-link a:hover {
            color: #e67332; /* Orange plus foncé au survol */
        }

        /* Footer */
        footer {
            background-color: #000; /* Noir */
            color: #fff;
            text-align: center;
            padding: 20px; /* Padding réduit pour un footer plus compact */
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

        <!-- Lien vers la page d'inscription -->
        <p class="register-link">
            Si vous n'avez pas de compte, <a href="inscription.jsp">inscrivez-vous ici</a>.
        </p>

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