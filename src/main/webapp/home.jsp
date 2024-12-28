<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil - Réservation de tickets</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            text-align: center;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 30px;
            border-radius: 8px;
        }

        h1 {
            color: #333333;
            margin-bottom: 20px;
        }

        p {
            color: #555555;
            font-size: 16px;
            margin-bottom: 30px;
        }

        .buttons {
            display: flex;
            justify-content: space-around;
        }

        .buttons a {
            text-decoration: none;
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #4CAF50;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .buttons a:hover {
            background-color: #45a049;
        }

        .buttons a:nth-child(2) {
            background-color: #007BFF;
        }

        .buttons a:nth-child(2):hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bienvenue sur l'application de réservation de tickets de films</h1>
        <p>Connectez-vous ou inscrivez-vous pour réserver vos tickets de film préférés !</p>
        <div class="buttons">
            <a href="inscription.jsp">S'inscrire</a>
            <a href="login.jsp">Se connecter</a>
        </div>
    </div>
</body>
</html>