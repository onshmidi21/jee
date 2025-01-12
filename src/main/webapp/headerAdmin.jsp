<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        /* Styles généraux */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        /* Styles pour le header */
        header {
            background-color: #333; /* Fond sombre */
            color: #fff; /* Texte blanc */
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        /* Logo */
        header .logo {
            text-decoration: none;
            transition: opacity 0.3s ease; /* Transition fluide */
        }

        header .logo img {
            width: 150px; /* Ajustez la largeur selon vos besoins */
            height: auto; /* Conserve le ratio de l'image */
        }

        header .logo:hover {
            opacity: 0.8; /* Effet de survol */
        }

        /* Navigation */
        header nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center; /* Alignement vertical des éléments */
        }

        header nav ul li {
            margin-left: 20px;
        }

        header nav ul li a {
            color: #fff;
            text-decoration: none; /* Pas de soulignement */
            font-size: 18px; /* Taille de police plus grande */
            transition: color 0.3s ease;
        }

        header nav ul li a:hover {
            color: #ff8c42; /* Orange au survol */
        }

        /* Boutons (style similaire aux liens de navigation) */
        .btn-link {
            color: #fff;
            text-decoration: none;
            font-size: 18px;
            transition: color 0.3s ease;
            padding: 5px 10px; /* Espacement léger pour le confort */
        }

        .btn-link:hover {
            color: #ff8c42; /* Orange au survol */
        }

        /* Conteneur pour les boutons */
        .header-buttons {
            display: flex;
            gap: 20px; /* Espace entre les boutons */
        }
    </style>
</head>
<body>
    <header>
        <!-- Bouton Tableau de bord à gauche -->
        <a href="${pageContext.request.contextPath}/admin" class="logo">Tableau de Board </a>
       
        <!-- Navigation -->
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/filmAdmin">Films</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/userAdmin">Utilisateurs</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/cinemaAdmin">Cinémas</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/seanceAdmin">Séances</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/salleAdmin">Salles</a></li>
            </ul>
        </nav>

        <!-- Bouton de déconnexion -->
        <a href="${pageContext.request.contextPath}/logout" class="logout">Déconnexion</a>
    </header>
    
</body>
</html>