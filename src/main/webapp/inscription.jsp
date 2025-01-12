<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inscription</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        /* Fond de la page en noir */
        body {
            background-color: #000; /* Noir */
            color: #fff;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
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

        /* Conteneur principal */
        #corps {
            flex: 1; /* Prend l'espace disponible */
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px; /* Espace autour du formulaire */
        }

        /* Bloc du formulaire */
        #bloc_page {
            background-color: #333; /* Gris foncé */
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            width: 100%;
            max-width: 600px;
        }

        /* Titre du formulaire */
        #bloc_page p {
            text-align: center;
            font-size: 24px; /* Taille de police augmentée */
            margin-bottom: 20px;
            color: #fff; /* Texte blanc */
            font-weight: bold; /* Texte en gras */
        }

        /* Labels */
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            text-align: left;
            color: #fff; /* Texte blanc */
        }

        /* Champs de formulaire */
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
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

        /* Bouton de soumission */
        .publier {
            background-color: #000; /* Noir */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            transition: background-color 0.3s ease, color 0.3s ease; /* Transition fluide */
        }

        .publier:hover {
            background-color: #FFA500; /* Jaune au survol */
            color: #000; /* Texte noir au survol */
        }

        /* Footer */
        footer {
            background-color: #000; /* Noir */
            color: #fff;
            text-align: center;
            padding: 20px; /* Padding réduit pour un footer plus compact */
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

    <div id="corps">
        <div id="bloc_page">
            <section>
                <article>
                    <p>Le Formulaire D'inscription </p>
                    <form method="post" action="inscrit">
                        <label for="nom"><b class="input">Nom</b></label>
                        <input class="input" placeholder="Nom" required autofocus type="text" name="nom" id="nom" size="30" value="">

                        <label for="prenom"><b class="input">Prénom</b></label>
                        <input class="input" required placeholder="Prénom" type="text" name="prenom" id="prenom" size="30" value="">

                        <label for="email"><b class="input">Email</b></label>
                        <input class="input" placeholder="Adresse Email" required type="text" name="adresse email" id="adresse email" size="30" value="">

                        <label for="adresse"><b class="input">Adresse</b></label>
                        <input class="input" placeholder="Adresse Postale" required type="text" name="adresse" id="adresse" size="30" value="">

                        <label for="login"><b class="input">Login</b></label>
                        <input class="input" placeholder="Login" required type="text" name="login" id="login" size="30" value="">

                        <label for="password"><b class="input">Mot de passe</b></label>
                        <input class="input" placeholder="Mot de passe" required type="password" name="password" id="password" size="30" value="">

                        <input class="publier" type="submit" name="Valider" value="Valider">
                    </form>
                </article>
            </section>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>