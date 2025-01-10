<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
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

        header .logo {
            font-size: 24px;
            font-weight: bold;
            color: #ff8c42; /* Orange pour le logo */
            text-decoration: none;
        }

        header nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
        }

        header nav ul li {
            margin-left: 20px;
        }

        header nav ul li a {
            color: #fff;
            text-decoration: none;
            font-size: 16px;
            transition: color 0.3s ease;
        }

        header nav ul li a:hover {
            color: #ff8c42; /* Orange au survol */
        }

        header .logout {
            background-color: #ff8c42; /* Bouton orange */
            padding: 8px 15px;
            border-radius: 5px;
            color: #fff;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        header .logout:hover {
            background-color: #e67332; /* Orange plus foncé au survol */
        }
    </style>
</head>
<body>
    <header>
        <!-- Logo -->
        <a href="${pageContext.request.contextPath}/admin" class="logo">Admin Dashboard</a>

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