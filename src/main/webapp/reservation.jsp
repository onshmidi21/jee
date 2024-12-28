<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entities.*" %>
<%@ page import="com.services.*" %>
<%@ page import="java.util.List"%>
<%@ page import="jakarta.ejb.EJB" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réservation - Pathé</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2563eb;
            --primary-hover: #1d4ed8;
            --success-color: #22c55e;
            --danger-color: #ef4444;
            --warning-color: #fbbf24;
            --disabled-color: #4b5563;
            --background-color: #000000;
            --card-background: #1a1a1a;
            --text-primary: #ffffff;
            --text-secondary: #a3a3a3;
            --border-radius: 12px;
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.5);
            --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.5);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background-color: var(--background-color);
            color: var(--text-primary);
            line-height: 1.5;
            min-height: 100vh;
        }

        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 0 1.5rem;
            display: grid;
            grid-template-columns: 1fr 1.2fr;
            gap: 2rem;
        }

        h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .film-info img {
            width: 100%;
            border-radius: var(--border-radius);
        }

        .seat-container {
            background-color: var(--card-background);
            padding: 2rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            margin-top: 2rem;
        }

        .seats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(40px, 1fr));
            gap: 0.5rem;
        }

        .seat {
            aspect-ratio: 1;
            border-radius: var(--border-radius);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
            font-weight: bold;
            cursor: pointer;
            transition: var(--transition);
            background-color: var(--warning-color);
            color: #1f2937;
            border: 1px solid #f3f4f6;
        }

        .seat.occupied {
            background-color: var(--disabled-color);
            cursor: not-allowed;
            opacity: 0.7;
        }

        .seat.selected {
            background-color: var(--success-color);
            color: #ffffff;
            box-shadow: 0 4px 8px rgba(16, 185, 129, 0.4);
            animation: pulse 0.5s ease;
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
            100% {
                transform: scale(1);
            }
        }

        .seat.handicap {
            position: relative;
        }

        .screen {
            height: 4px;
            background: linear-gradient(to right, transparent, #fbbf24, transparent);
            margin: 2rem 0;
            position: relative;
        }

        .screen::after {
            content: 'Écran';
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            top: 1rem;
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        .legend {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin: 2rem 0;
            font-size: 0.875rem;
            color: var(--text-secondary);
        }

        .legend-item {
            display: flex;
            align-items: center;
        }

        .legend-color {
            width: 1rem;
            height: 1rem;
            border-radius: var(--border-radius);
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
        }

        .legend-color.available {
            background-color: var(--warning-color);
        }

        .legend-color.occupied {
            background-color: var(--disabled-color);
        }

        .legend-color.selected {
            background-color: var(--success-color);
        }

        .btn-reserve {
            width: 100%;
            padding: 1rem;
            background-color: var(--warning-color);
            color: black;
            font-size: 1rem;
            font-weight: 600;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-reserve:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md), 0 8px 12px rgba(0, 0, 0, 0.3);
        }

        .btn-reserve:disabled {
            background-color: var(--disabled-color);
            cursor: not-allowed;
            opacity: 0.5;
        }

        @media (max-width: 768px) {
            .container {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .seats {
                grid-template-columns: repeat(8, 1fr);
            }

            h1 {
                font-size: 1.5rem;
            }

            .legend {
                flex-wrap: wrap;
                gap: 0.5rem;
            }
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

    <div class="container">
        <!-- Partie gauche avec infos du film -->
        <div class="film-info">
            <% Seance seance = (Seance) request.getAttribute("seance"); %>
            <h1><%= seance.salle.film.getTitle() %></h1>
            <div class="film-info-img">
                <img src="<%= seance.salle.film.getPicture() %>" alt="<%= seance.salle.film.getTitle() %>">
            </div>
        </div>

        <div class="seat-container">
            <h1>Sélectionnez vos places</h1>
            <div class="seats">
                <% 
                    List<Place> places = (List<Place>) request.getAttribute("places");
                    int rowCount = (int) request.getAttribute("rowCount");
                    int colCount = (int) request.getAttribute("colCount");
                    int placeIndex = 0;

                    for (int row = 1; row <= rowCount; row++) {
                        for (int col = 1; col <= colCount; col++) {
                            if (placeIndex < places.size()) {
                                Place place = places.get(placeIndex++);
                                String seatClass = place.getStatus() == Place.Status.DISPONIBLE ? "available" : "occupied";
                %>
                    <div class="seat <%= seatClass %>" 
                         data-place-id="<%= place.getIdPlace() %>" 
                         data-seance-id="<%= seance.getId() %>" 
                         data-row="<%= place.getRow() %>" 
                         data-col="<%= place.getCol() %>">
                        <%= place.getRow() %>-<%= place.getCol() %>
                    </div>
                <% 
                            }
                        }
                    }
                %>
            </div>

            <div class="screen"></div>

            <div class="legend">
                <div class="legend-item">
                    <div class="legend-color available"></div>
                    Places libres
                </div>
                <div class="legend-item">
                    <div class="legend-color occupied"></div>
                    Places occupées
                </div>
                <div class="legend-item">
                    <div class="legend-color selected"></div>
                    Ma sélection
                </div>
            </div>

         <form id="reservationForm" action="reservation" method="post">
    <div class="selection-info" id="selectionInfo" style="display: none;">
        <div class="seat-count">
            <div class="seat-count-icon">✓</div>
            <span>1 place réservée</span>
        </div>
        <div class="seat-number"></div>
    </div>
    <input type="hidden" name="placeId" id="placeId">
    <input type="hidden" name="seanceId" id="seanceId" value="<%= seance.getId() %>">

    <button type="submit" id="reserveButton" class="btn-reserve" disabled>
        Réserver ma place
    </button>
</form>
        </div>
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const seats = document.querySelectorAll('.seat:not(.occupied)');
        const reserveButton = document.getElementById('reserveButton');
        const selectionInfo = document.getElementById('selectionInfo');
        const seatNumber = selectionInfo.querySelector('.seat-number');
        let selectedSeat = null;

        seats.forEach(seat => {
            seat.addEventListener('click', function() {
                if (seat.classList.contains('occupied')) return;

                // Désélectionner la place précédente
                if (selectedSeat) {
                    selectedSeat.classList.remove('selected');
                }

                // Sélectionner la nouvelle place
                selectedSeat = seat;
                selectedSeat.classList.add('selected');

                // Mettre à jour les informations
                const row = seat.getAttribute('data-row');
                const col = seat.getAttribute('data-col');
                const placeId = seat.getAttribute('data-place-id');
                const seanceId = seat.getAttribute('data-seance-id');

                // Mettre à jour les champs cachés
                document.getElementById('placeId').value = placeId;
                document.getElementById('seanceId').value = seanceId;

                // Afficher les informations de sélection
                selectionInfo.style.display = 'flex';
                seatNumber.textContent = `${row}-${col}`;

                // Activer le bouton de réservation
                reserveButton.disabled = false;
            });
        });

        // Empêcher la soumission si aucune place n'est sélectionnée
        document.getElementById('reservationForm').addEventListener('submit', function(e) {
            const placeIdInput = document.getElementById('placeId');
            if (!placeIdInput.value) {
                e.preventDefault();
                alert('Veuillez sélectionner une place avant de réserver.');
            }
        });
    });
    </script>
    <jsp:include page="footer.jsp"/>
    
</body>
</html>