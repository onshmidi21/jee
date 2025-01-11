<%@ page import="com.entities.Film"%>
<!DOCTYPE html>
<html>
<head>
    <title>Film Aléatoire</title>
   <style>
        /* Style global */
        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #000; /* Arrière-plan noir */
            color: #fff; /* Texte en blanc pour contraster avec l'arrière-plan */
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 60px; /* Augmenter l'espace entre les colonnes */
        }

        .film-info {
            flex: 1;
            text-align: left;
            margin-right: 40px; /* Ajouter une marge à droite pour plus d'espace */
        }

        .film-image-wrapper {
            flex: 1;
            max-width: 500px;
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .film-image-wrapper:hover {
            transform: scale(1.05); /* Zoom léger au survol */
            box-shadow: 0 15px 40px rgba(255, 87, 51, 0.5); /* Ombre plus prononcée */
        }

        .film-image-wrapper img {
            width: 100%;
            height: auto;
            object-fit: cover;
            border-radius: 10px;
        }

        h1 {
            font-size: 3.5em;
            color: #fff; /* Titre en blanc */
            margin-bottom: 40px; /* Ajouter un espace entre le titre et le bouton */
            font-weight: 500;
            text-transform: uppercase;
            text-shadow: 2px 2px 8px rgba(255, 87, 51, 0.7); /* Ombre portée */
            font-family: 'Bebas Neue', cursive; /* Police stylisée */
        }

        .button-container {
            text-align: right; /* Aligner le bouton à droite */
        }

        .button {
            background-color: #FFA500; /* Orange */
            color: white;
            padding: 20px 80px; /* Augmenter le padding horizontal pour un bouton plus large */
            text-decoration: none;
            font-size: 1.3em;
            border-radius: 30px;
            box-shadow: 0 4px 15px rgba(255, 87, 51, 0.5);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px; /* Espace entre l'icône et le texte */
            margin-right: 60px; /* Ajouter une marge à droite du bouton */
        }

        .button:hover {
            background-color: #FF8C00; /* Orange plus foncé au survol */
            box-shadow: 0 6px 20px rgba(255, 87, 51, 0.7);
        }

        .button:focus {
            outline: none;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                align-items: center;
                gap: 30px; /* Réduire l'espace en mode responsive */
            }

            h1 {
                font-size: 3em;
                margin-bottom: 30px; /* Ajuster l'espace en mode responsive */
            }

            .film-image-wrapper {
                max-width: 80%;
                height: 350px;
            }

            .button {
                font-size: 1.1em;
                padding: 15px 50px; /* Ajuster le padding en mode responsive */
                margin-right: 0; /* Supprimer la marge en mode responsive */
            }

            .film-info {
                margin-right: 0; /* Supprimer la marge en mode responsive */
            }
        }

        @media (max-width: 480px) {
            h1 {
                font-size: 2.5em;
                margin-bottom: 20px; /* Ajuster l'espace en mode responsive */
            }

            .film-image-wrapper {
                max-width: 100%;
                height: 250px;
            }

            .button {
                font-size: 1em;
                padding: 12px 40px; /* Ajuster le padding en mode responsive */
            }
        }
    </style>
    <!-- Lien vers une police Google Fonts (Bebas Neue) -->
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
</head>
<body>
    <div class="container">
        <!-- Informations du film à droite -->
        <div class="film-info">
            <h1>
                <%
                    Film randomFilm = (Film) request.getAttribute("randomFilm");
                    if (randomFilm != null) {
                %>
                    <%= randomFilm.getTitle() %>
                <% 
                    } else { 
                %>
                    Film non trouvé
                <% 
                    } 
                %>
            </h1>

            <!-- Conteneur pour aligner le bouton à droite -->
            <div class="button-container">
                <a href="seances?filmId=<%= randomFilm != null ? randomFilm.getId() : "" %>" class="button">Reserver maintenant</a>
            </div>
        </div>

        <!-- Image du film à gauche -->
        <div class="film-image-wrapper">
            <img src="<%
                if (randomFilm != null) {
                    out.print(randomFilm.getPicture());
                } else {
                    out.print("/path/to/default-image.jpg");  // Image par défaut si film non trouvé
                }
            %>" alt="<%
                if (randomFilm != null) {
                    out.print(randomFilm.getTitle());
                } else {
                    out.print("Film non trouvé");
                }
            %>">
        </div>
    </div>
</body>
</html>