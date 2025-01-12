<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login Admin</title>
    <style>
        /* Styles généraux */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
            color: #fff; /* Texte blanc par défaut */
        }

        body {
            background-color: #000; /* Fond noir */
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Header */
        header {
            background-color: #000; /* Noir */
            padding: 10px 20px; /* Padding réduit pour un header plus petit */
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        header h1 {
            margin: 0;
            font-size: 24px; /* Taille de police légèrement réduite */
            font-weight: bold;
        }

        /* Conteneur principal */
        .container {
            flex: 1; /* Prend l'espace disponible */
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px; /* Espace autour du formulaire */
        }

        /* Formulaire */
        form {
            background-color: #333; /* Gris foncé */
            padding: 30px; /* Plus de padding */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            width: 100%;
            max-width: 400px; /* Largeur maximale du formulaire */
            text-align: center;
        }

        form h1 {
            color: #fff; /* Texte blanc */
            font-size: 2em;
            margin-bottom: 20px; /* Plus d'espace */
        }

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
            border-color: #FFA500; /* Orange au focus */
            background-color: #555; /* Fond gris plus clair au focus */
        }

        button {
            background-color: #000; /* Fond noir au départ */
            color: #fff; /* Texte blanc au départ */
            padding: 15px 20px; /* Plus de padding pour le bouton */
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease, color 0.3s ease, transform 0.3s ease;
        }

        button:hover {
            background-color: #FFA500; /* Fond orange au survol */
            color: #000; /* Texte noir au survol */
            transform: scale(1.05); /* Effet de zoom */
        }

        p.error-message {
            color: red;
            font-size: 14px;
            margin-top: 15px; /* Plus d'espace pour le message d'erreur */
            text-align: center;
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
        <form action="loginAdmin" method="post">
            <h1>Connexion Admin</h1>
            <label for="login">Login:</label>
            <input type="text" id="login" name="login" placeholder="Entrez votre login" required>
            <label for="password">Mot de passe:</label>
            <input type="password" id="password" name="password" placeholder="Entrez votre mot de passe" required>
            <button type="submit">Se connecter</button>
            <p class="error-message">${error}</p>
        </form>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>