<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Page avec Footer</title>
    <!-- Ajoutez Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        footer {
            background: #FFA500;
            color: #fff;
            padding: 50px 0 20px;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 40px; /* Espacement entre les colonnes */
            padding: 0 20px;
        }

        .footer-section {
            padding: 10px;
        }

        .footer-section h3 {
            color: #ffff;
            margin-bottom: 20px;
            font-size: 18px;
        }

        .footer-section ul {
            list-style: none;
            padding: 0;
        }

        .footer-section ul li {
            margin-bottom: 15px; /* Espacement entre les éléments de la liste */
        }

        .footer-section ul li a {
            color: #fff;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }

        .footer-section ul li a:hover {
            color: #e50914;
        }

        .footer-bottom {
            max-width: 1200px;
            margin: 40px auto 0;
            padding: 20px 20px 0;
            border-top: 1px solid #333;
            text-align: center;
            font-size: 14px;
            color: #666;
        }

        .social-icons {
            display: flex;
            gap: 20px; /* Espacement entre les icônes */
            margin-top: 20px;
        }

        .social-icons a {
            color: #fff;
            text-decoration: none;
            font-size: 24px; /* Taille des icônes */
            transition: color 0.3s;
        }

        .social-icons a:hover {
            color: #e50914;
        }

        @media (max-width: 768px) {
            .footer-content {
                grid-template-columns: repeat(2, 1fr); /* Deux colonnes sur les écrans moyens */
                gap: 30px;
            }
        }

        @media (max-width: 480px) {
            .footer-content {
                grid-template-columns: 1fr; /* Une colonne sur les petits écrans */
                gap: 20px;
            }

            .social-icons {
                justify-content: center; /* Centrer les icônes sur les petits écrans */
            }
        }
    </style>
</head>
<body>
  
    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>LES NOUVEAUTÉS À L'AFFICHE</h3>
                <ul>
                    <li><a href="#">Mufass : Le Roi Lion</a></li>
                    <li><a href="#">SONIC 3 - le film</a></li>
                    <li><a href="#">Valana 2</a></li>
                    <li><a href="#">Un ours dans le Jura</a></li>
                    <li><a href="#">Firma accueilement au cinéma</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>CHIÈMAS DANS VOS VILLES</h3>
                <ul>
                    <li><a href="#">Chiérans à Paris</a></li>
                    <li><a href="#">Chiérans à Lyon</a></li>
                    <li><a href="#">Chiérans à Marseille</a></li>
                    <li><a href="#">Chiérans à Toulouse</a></li>
                    <li><a href="#">Chiérans à Nice</a></li>
                    <li><a href="#">Chiérans autour de moi</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>À PROPOS</h3>
                <ul>
                    <li><a href="#">Critièbres</a></li>
                    <li><a href="#">CritiéCartes</a></li>
                    <li><a href="#">IMAX</a></li>
                    <li><a href="#">Dolly Cinema</a></li>
                    <li><a href="#">40X</a></li>
                    <li><a href="#">ScreenX</a></li>
                    <li><a href="#">Metropolitan Opera</a></li>
                    <li><a href="#">Nos expériences</a></li>
                    <li><a href="#">Toutes les actualités</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>SUIVEZ-NOUS</h3>
                <div class="social-icons">
                    <!-- Icône Facebook -->
                    <a href="https://facebook.com" target="_blank" title="Facebook">
                        <i class="fab fa-facebook"></i>
                    </a>
                    <!-- Icône Instagram -->
                    <a href="https://instagram.com" target="_blank" title="Instagram">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <!-- Icône Email -->
                    <a href="mailto:contact@cinema.com" title="Email">
                        <i class="fas fa-envelope"></i>
                    </a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2025 Cinéma application. Tous droits réservés.</p>
        </div>
    </footer>
</body>
</html>