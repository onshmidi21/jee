<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entities.Seance, com.entities.Place, java.util.List" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réservation</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
      * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
    color: #000000;
}

body {
    background: #000000;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}

.container {
    max-width: 1280px;
    margin: 2rem auto; /* Marge en haut et en bas */
    padding: 0 1.5rem;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 2rem;
    align-items: start;
    flex: 1;
}

h1 {
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 1rem;
     color: #ffffff;
}

.film-info {
    height: 100%;
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.film-info img {
    width: 100%;
    height: auto;
    object-fit: cover;
}

.seat-container {
    background-color: #1a1a1a;
    padding: 2rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.5);
    height: 100%;
    display: flex;
    flex-direction: column;
}

.seats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(40px, 1fr));
    gap: 0.5rem;
}

.seat {
    aspect-ratio: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.9rem;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease;
    background-color: #fbbf24;
    color: #1f2937;
    border: 1px solid #f3f4f6;
}

.seat.occupied {
    background-color: #4b5563;
    cursor: not-allowed;
    opacity: 0.7;
}

.seat.selected {
    background-color: #22c55e;
    color: #ffffff;
    box-shadow: 0 4px 8px rgba(16, 185, 129, 0.4);
    animation: pulse 0.5s ease;
}

@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.1); }
    100% { transform: scale(1); }
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
    color: #a3a3a3;
    font-size: 0.875rem;
}

.legend {
    display: flex;
    justify-content: center;
    gap: 1rem;
    margin: 2rem 0;
    font-size: 0.875rem;
    color: #a3a3a3;
}

.legend-item {
    display: flex;
    align-items: center;
     color: #ffffff;
}

.legend-color {
    width: 1rem;
    height: 1rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
}

.legend-color.available {
    background-color: #fbbf24;
}

.legend-color.occupied {
    background-color: #4b5563;
}

.legend-color.selected {
    background-color: #22c55e;
}

.btn-reserve {
    width: 100%;
    padding: 1rem;
    background-color: #fbbf24;
    color: black;
    font-size: 1rem;
    font-weight: 600;
    border: none;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
}

.btn-reserve:hover {
    background-color: #1d4ed8;
    transform: translateY(-2px);
    box-shadow: 0 8px 12px rgba(0, 0, 0, 0.3);
}

.btn-reserve:disabled {
    background-color: #4b5563;
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
        color :#ffff
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
            <%
                Seance seance = (Seance) request.getAttribute("seance");
            %>
            <div class="film-info-img">
                <img src="<%= seance.getSalle().getFilm().getPicture() %>" alt="<%= seance.getSalle().getFilm().getTitle() %>">
            </div>
        </div>

        <div class="seat-container">
            <h1 >Sélectionnez vos places</h1>
            <div class="seats">
                <%
                    List<Place> places = (List<Place>) request.getAttribute("places");
                    for (Place place : places) {
                        String seatClass = place.getStatus() == Place.Status.DISPONIBLE ? "seat available" : "seat occupied";
                %>
                    <div class="<%= seatClass %>" 
                         data-place-id="<%= place.getIdPlace() %>" 
                         data-seance-id="<%= seance.getId() %>" 
                         data-row="<%= place.getRow() %>" 
                         data-col="<%= place.getCol() %>">
                        <%= place.getRow() %>-<%= place.getCol() %>
                    </div>
                <%
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

            <form id="reservationForm" action="paiement" method="post">
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
</body>
    <%@ include file="footer.jsp" %>

</html>