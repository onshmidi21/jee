</html><%@ page import="com.entities.Film"%>

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
            gap: 40px; /* Espacement entre les deux colonnes */
        }

        .film-info {
            flex: 1;
            text-align: left;
        }

        .film-image-wrapper {
            flex: 1;
            max-width: 500px;
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }

        .film-image-wrapper img {
            width: 100%;
            height: auto;
            object-fit: cover;
        }

        h1 {
            font-size: 3.5em;
            color: #fff; /* Titre en blanc */
            margin-bottom: 20px;
            font-weight: 500;
            text-transform: uppercase;
        }

        .film-description {
            font-size: 1.1em;
            color: #ccc; /* Couleur du texte de description */
            margin: 20px 0;
            line-height: 1.6;
        }

        .button {
            background-color: #ff5733;
            color: white;
            padding: 18px 40px;
            text-decoration: none;
            font-size: 1.3em;
            border-radius: 30px;
            box-shadow: 0 4px 15px rgba(255, 87, 51, 0.5);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .button:hover {
            background-color: #e04a29;
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
            }

            h1 {
                font-size: 3em;
            }

            .film-image-wrapper {
                max-width: 80%;
                height: 350px;
            }

            .button {
                font-size: 1.1em;
                padding: 15px 30px;
            }
        }

        @media (max-width: 480px) {
            h1 {
                font-size: 2.5em;
            }

            .film-image-wrapper {
                max-width: 100%;
                height: 250px;
            }

            .button {
                font-size: 1em;
                padding: 12px 25px;
            }
        }
    </style>
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

          

            <!-- Bouton de réservation -->
            <a href="seances?filmId=<%= randomFilm != null ? randomFilm.getId() : "" %>" class="button">Réserver maintenant</a>
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