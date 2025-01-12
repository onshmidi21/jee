<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.entities.Salle" %>
<%@ page import="com.entities.Cinema" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title><%= request.getAttribute("salle") != null ? "Modifier" : "Ajouter" %> une Salle</title>
    <style>
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
        input[type="text"], input[type="number"], select {
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
        input[type="text"]:focus, input[type="number"]:focus, select:focus {
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
    <h1><%= request.getAttribute("salle") != null ? "Modifier" : "Ajouter" %> une Salle</h1>
    <form action="salleAdmin" method="post">
        <input type="hidden" name="action" value="<%= request.getAttribute("salle") != null ? "edit" : "add" %>">
        
        <% if (request.getAttribute("salle") != null) { %>
            <input type="hidden" name="id" value="<%= ((Salle) request.getAttribute("salle")).getId() %>">
        <% } %>
        
        <label for="nom">Nom :</label>
        <input type="text" id="nom" name="nom" value="<%= request.getAttribute("salle") != null ? ((Salle) request.getAttribute("salle")).getName() : "" %>" required><br>
        
        <label for="capacite">Capacité :</label>
        <input type="number" id="capacite" name="capacite" value="<%= request.getAttribute("salle") != null ? ((Salle) request.getAttribute("salle")).getCapacite() : "" %>" required><br>
        
        <label for="cinemaId">Cinéma :</label>
        <select id="cinemaId" name="cinemaId" required>
            <%
                // Récupérer la liste des cinémas depuis l'attribut de requête
                List<Cinema> cinemas = (List<Cinema>) request.getAttribute("cinemas");
                Salle salle = (Salle) request.getAttribute("salle");
                
                if (cinemas != null) {
                    for (Cinema cinema : cinemas) {
                        // Sélectionner le cinéma actuel si on est en mode modification
                        String selected = (salle != null && salle.getCinema() != null && salle.getCinema().getId() == cinema.getId()) ? "selected" : "";
            %>
                        <option value="<%= cinema.getId() %>" <%= selected %>><%= cinema.getName() %></option>
            <%
                    }
                }
            %>
        </select><br>
        
        <button type="submit"><%= request.getAttribute("salle") != null ? "Modifier" : "Ajouter" %></button>
    </form>
    
    <a href="salleAdmin?action=list">Retour à la liste</a>
</body>
</html>