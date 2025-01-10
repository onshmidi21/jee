<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        /* Styles pour le footer */
        footer {
            background-color: #333; /* Fond sombre */
            color: #fff; /* Texte blanc */
            padding: 20px;
            text-align: center;
            margin-top: 50px;
            box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.2);
        }

        footer p {
            margin: 5px 0;
        }

        footer a {
            color: #ff8c42; /* Orange pour les liens */
            text-decoration: none;
            transition: color 0.3s ease;
        }

        footer a:hover {
            color: #e67332; /* Orange plus foncé au survol */
        }
    </style>
</head>
<body>
    <footer>
        <p>&copy; 2025 Cinéma Admin. Tous droits réservés.</p>
        <p><a href="${pageContext.request.contextPath}/admin/contact">Contact</a> | <a href="${pageContext.request.contextPath}/admin/privacy">Politique de confidentialité</a></p>
    </footer>
</body>
</html>