<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.entities.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getAttribute("seance") != null ? "Modifier" : "Ajouter" %> une Séance</title>
    <style>
        /* Styles généraux */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #1e1e1e; /* Fond noir légèrement plus clair */
            color: #fff; /* Texte blanc */
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        h1 {
            color: #ff6f61; /* Rouge orangé moderne */
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(255, 111, 97, 0.3); /* Ombre textuelle */
        }
        form {
            background-color: #1e1e1e; /* Fond gris très foncé */
            padding: 30px;
            border-radius: 15px; /* Coins arrondis */
            box-shadow: 0 8px 16px rgba(255, 111, 97, 0.2); /* Ombre orange */
            border: 2px solid #ff6f61; /* Bordure orange */
            width: 100%;
            max-width: 600px;
            animation: fadeIn 0.5s ease-in-out; /* Animation d'apparition */
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        label {
            font-weight: bold;
            margin-top: 15px;
            display: block;
            color: #ff6f61; /* Rouge orangé moderne */
            font-size: 1.1em;
        }
        input[type="text"], input[type="number"], input[type="date"], input[type="time"], select {
            width: 100%;
            padding: 12px;
            margin-top: 8px;
            margin-bottom: 20px;
            border: 2px solid #ff6f61; /* Bordure orange */
            border-radius: 8px;
            box-sizing: border-box;
            background-color: #333; /* Fond gris foncé */
            color: #fff; /* Texte blanc */
            font-size: 1em;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        input[type="text"]:focus, input[type="number"]:focus, input[type="date"]:focus, input[type="time"]:focus, select:focus {
            border-color: #ff3b2f; /* Rouge plus vif au focus */
            box-shadow: 0 0 8px rgba(255, 59, 47, 0.5); /* Ombre portée au focus */
            outline: none;
        }
        button {
            background-color: #ff6f61; /* Rouge orangé moderne */
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            font-size: 1.1em;
            transition: background-color 0.3s ease, transform 0.3s ease;
            width: 100%;
            margin-top: 20px;
        }
        button:hover {
            background-color: #ff3b2f; /* Rouge plus vif au survol */
            transform: translateY(-2px); /* Effet de levée */
        }
        a {
            display: inline-block;
            margin-top: 20px;
            color: #ff6f61; /* Rouge orangé moderne */
            text-decoration: none;
            font-weight: bold;
            font-size: 1.1em;
            transition: color 0.3s ease;
        }
        a:hover {
            color: #ff3b2f; /* Rouge plus vif au survol */
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1><%= request.getAttribute("seance") != null ? "Modifier" : "Ajouter" %> une Séance</h1>
    <form action="seanceAdmin" method="post">
        <input type="hidden" name="action" value="<%= request.getAttribute("seance") != null ? "edit" : "add" %>">
        
        <% if (request.getAttribute("seance") != null) { %>
            <input type="hidden" name="id" value="<%= ((Seance) request.getAttribute("seance")).getId() %>">
        <% } %>
        
        <label for="salleId">Salle:</label>
        <select id="salleId" name="salleId" required>
            <% 
                List<Salle> salles = (List<Salle>) request.getAttribute("salles");
                Seance seance = (Seance) request.getAttribute("seance");
                if (salles != null) {
                    for (Salle salle : salles) {
                        String selected = (seance != null && seance.getSalle().getId() == salle.getId()) ? "selected" : "";
            %>
                        <option value="<%= salle.getId() %>" <%= selected %>><%= salle.getName() %></option>
            <% 
                    }
                }
            %>
        </select><br>
        
        <label for="filmId">Film:</label>
        <select id="filmId" name="filmId" required>
            <% 
                List<Film> films = (List<Film>) request.getAttribute("films");
                if (films != null) {
                    for (Film film : films) {
                        String selected = (seance != null && seance.getSalle().getFilm().getId() == film.getId()) ? "selected" : "";
            %>
                        <option value="<%= film.getId() %>" <%= selected %>><%= film.getTitle() %></option>
            <% 
                    }
                }
            %>
        </select><br>
        
        <label for="date">Date:</label>
        <%
            String dateValue = "";
            if (seance != null && seance.getDate() != null) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                dateValue = dateFormat.format(seance.getDate());
            }
        %>
        <input type="date" id="date" name="date" value="<%= dateValue %>" required><br>
        
        <label for="horaire">Horaire:</label>
        <%
            String horaireValue = "";
            if (seance != null && seance.getHoraire() != null) {
                SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
                horaireValue = timeFormat.format(seance.getHoraire());
            }
        %>
        <input type="time" id="horaire" name="horaire" value="<%= horaireValue %>" required><br>
        
        <label for="tarif">Tarif:</label>
        <input type="number" id="tarif" name="tarif" step="0.01" value="<%= seance != null ? seance.getTarif() : "" %>" required><br>
        
        <button type="submit"><%= seance != null ? "Modifier" : "Ajouter" %></button>
    </form>
    
    <a href="seanceAdmin?action=list">Retour à la liste</a>
</body>
</html>