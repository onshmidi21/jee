<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.entities.Seance" %>
<%@ page import="com.entities.Film" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Détails du Film</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Styles généraux */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', sans-serif;
        }

        body {
            background-color: #000; /* Fond noir */
            color: #fff; /* Texte blanc */
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        h1 {
            text-align: center;
            color:#e50914; /* Orange */
            margin: 40px 0;
            font-size: 2.5rem;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin: 40px auto;
            width: 90%;
            gap: 40px;
        }

        /* Section des détails du film */
        .film-details {
            background-color: #222; /* Noir plus clair */
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            width: 30%;
            text-align: center;
        }

        .film-details img {
            max-width: 100%;
            height: auto;
            max-height: 400px;
            border-radius: 8px;
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }

        .film-details img:hover {
            transform: scale(1.05);
        }

        .film-details h2 {
            font-size: 24px;
            color: #ff6f00;
        }

        .film-details p {
            font-size: 16px;
            color: #ddd;
            margin: 15px 0;
        }

        .film-actions {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }

        .btn-like, .btn-love {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
            font-size: 16px;
        }

        .btn-like {
            background-color: #FFA500; /* Jaune */
            color: #000;
        }

        .btn-like.active {
            background-color: #e6c200;
        }

        .btn-love {
            background-color:#e50914; /* Rouge */
            color: white;
        }

        .btn-love.active {
            background-color: #c71585;
        }

        /* Section des séances */
        .seances-list {
            background-color: #222;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            width: 65%;
        }

        /* Styles pour le tableau des séances */
        .seances-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .seances-table th, .seances-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #444;
        }

        .seances-table th {
            background-color: #333;
            color: #FFA500;
            font-size: 16px;
        }

        .seances-table tr:hover {
            background-color: #444;
        }

        .seances-table .btn-reserve {
            padding: 8px 16px;
            background-color: #FFA500;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
 
        .seances-table .btn-reserve:hover {
            background-color: #e65c00;
            transform: scale(1.05);
        }

        /* Responsivité du tableau */
        @media (max-width: 768px) {
            .seances-table {
                display: block;
                overflow-x: auto;
            }
        }

        /* Calendrier annuel réduit */
        .annual-calendar {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 4 colonnes pour les mois */
            gap: 10px;
            margin-bottom: 20px;
        }

        .month-calendar {
            background-color: #333;
            padding: 10px;
            border-radius: 8px;
            text-align: center;
        }

        .month-calendar h4 {
            color: #FFA500;
            margin-bottom: 5px;
            font-size: 14px;
        }

        .month-days {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 3px;
        }

        .calendar-day {
            background-color: #444;
            color: #fff;
            padding: 3px;
            border-radius: 3px;
            text-align: center;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
            font-size: 10px;
        }

        .calendar-day.projection-day {
            background-color: #FFA500;
            color: #000;
        }

        .calendar-day:hover {
            background-color: #555;
            transform: translateY(-3px);
        }

        /* Media Queries pour la responsivité */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .film-details, .seances-list {
                width: 100%;
                margin-bottom: 30px;
            }

            .annual-calendar {
                grid-template-columns: repeat(2, 1fr); /* 2 colonnes sur mobile */
            }
        }

        /* Style pour le message */
        #message {
            display: none;
            margin-top: 20px;
            padding: 10px;
            background-color: #333;
            color: #fff;
            text-align: center;
            border-radius: 4px;
        }

        /* Style pour mettre en évidence la séance */
        .highlighted-seance {
            background-color: #555 !important;
            transition: background-color 0.5s ease;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<%-- Récupération de l'identifiant du film --%>
<%
    String filmId = request.getParameter("filmId");
    Film film = (Film) request.getAttribute("film");
    List<Seance> seances = (List<Seance>) request.getAttribute("seances");

    // Récupérer l'année actuelle
    Calendar calendar = Calendar.getInstance();
    int currentYear = calendar.get(Calendar.YEAR);

    // Créer une liste des jours de projection
    java.util.Map<String, java.util.Set<Integer>> projectionDaysByMonth = new java.util.HashMap<>();
    if (seances != null) {
        for (Seance seance : seances) {
            calendar.setTime(seance.getDate());
            int month = calendar.get(Calendar.MONTH);
            int day = calendar.get(Calendar.DAY_OF_MONTH);
            String monthKey = currentYear + "-" + month;
            projectionDaysByMonth.computeIfAbsent(monthKey, k -> new java.util.HashSet<>()).add(day);
        }
    }
%>

<h1>Séances disponibles</h1>

<div class="container">
    <%-- Colonne de gauche : Affiche et informations du film --%>
    <div class="film-details">
        <img src="<%= film.getPicture() %>" alt="<%= film.getTitle() %>">
        <h2><%= film.getTitle() %></h2>
        <p><strong>Description:</strong> <%= film.getDescription() != null ? film.getDescription() : "Aucune description disponible." %></p>
        <p><strong>Réalisateur:</strong> <%= film.getDirector() %></p>
        <p><strong>Type:</strong> <%= film.getType() %></p>
        <p><strong>Durée:</strong> <%= film.getDuration() %> min</p>
        <p><strong>Date de sortie:</strong> <%= new SimpleDateFormat("dd MMM yyyy").format(film.getDate()) %></p>
        
        <!-- Boutons Like et J'adore -->
        <div class="film-actions">
            <button id="btn-like" class="btn-like"><i class="fas fa-thumbs-up"></i> Like</button>
            <button id="btn-love" class="btn-love"><i class="fas fa-heart"></i> J'adore</button>
        </div>

        <!-- Zone pour afficher le message -->
        <div id="message"></div>
    </div>

    <%-- Colonne de droite : Liste des séances --%>
    <div class="seances-list">
        <!-- Calendrier annuel réduit -->
        <div class="annual-calendar">
            <%
                // Afficher les 12 mois de l'année
                for (int month = 0; month < 12; month++) {
                    calendar.set(currentYear, month, 1);
                    String monthName = new SimpleDateFormat("MMM").format(calendar.getTime());
                    String monthKey = currentYear + "-" + month;
                    java.util.Set<Integer> projectionDays = projectionDaysByMonth.getOrDefault(monthKey, new java.util.HashSet<>());
            %>
                <div class="month-calendar">
                    <h4><%= monthName %></h4>
                    <div class="month-days">
                        <%
                            // Afficher les jours du mois
                            int maxDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
                            for (int day = 1; day <= maxDay; day++) {
                                String dayClass = projectionDays.contains(day) ? "calendar-day projection-day" : "calendar-day";
                        %>
                            <div class="<%= dayClass %>" data-date="<%= String.format("%04d-%02d-%02d", currentYear, month + 1, day) %>">
                                <%= day %>
                            </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            <%
                }
            %>
        </div>

        <%-- Vérification si des séances existent --%>
        <%
            if (seances != null && !seances.isEmpty()) {
        %>
            <table class="seances-table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Horaire</th>
                        <th>Salle</th>
                        <th>Cinéma</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Seance seance : seances) { %>
                        <tr id="seance-<%= new SimpleDateFormat("yyyy-MM-dd").format(seance.getDate()) %>">
                            <td><%= new SimpleDateFormat("dd/MM/yyyy").format(seance.getDate()) %></td>
                            <td><%= seance.getHoraire() %></td>
                            <td><%= seance.getSalle() != null ? seance.salle.salle.getName() : "Salle inconnue" %></td>
                            <td><%= seance.getSalle() != null ? seance.salle.salle.cinema.getName() : "Cinéma inconnu" %></td>
                            <td>
                                <form action="reservation" method="GET">
                                    <input type="hidden" name="seance_id" value="<%= seance.getId() %>">
                                    <button class="btn-reserve" type="submit">Réserver</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <%
            } else {
        %>
            <p class="no-seances">Aucune séance n'est disponible pour ce film.</p>
        <%
            }
        %>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    // Gestionnaire d'événement pour le bouton "Like"
    document.getElementById('btn-like').addEventListener('click', function() {
        const messageDiv = document.getElementById('message');
        messageDiv.textContent = "Vous avez aimé ce film !";
        messageDiv.style.display = 'block';
        this.classList.toggle('active'); // Ajoute ou retire la classe "active"
    });

    // Gestionnaire d'événement pour le bouton "J'adore"
    document.getElementById('btn-love').addEventListener('click', function() {
        const messageDiv = document.getElementById('message');
        messageDiv.textContent = "Vous adorez ce film !";
        messageDiv.style.display = 'block';
        this.classList.toggle('active'); // Ajoute ou retire la classe "active"
    });

    // Gestionnaire d'événement pour les jours du calendrier
    document.querySelectorAll('.calendar-day.projection-day').forEach(day => {
        day.addEventListener('click', function() {
            const date = this.getAttribute('data-date');
            console.log("Date cliquée :", date); // Vérifiez dans la console
            const seanceRow = document.getElementById(`seance-${date}`);
            if (seanceRow) {
                seanceRow.scrollIntoView({ behavior: 'smooth', block: 'start' });
                seanceRow.classList.add('highlighted-seance');
                setTimeout(() => {
                    seanceRow.classList.remove('highlighted-seance');
                }, 2000);
            } else {
                console.error("Aucune séance trouvée pour la date :", date);
            }
        });
    });
</script>

</body>
</html>