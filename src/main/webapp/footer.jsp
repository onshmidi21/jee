<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Page avec Footer</title>
    <!-- Ajoutez Font Awesome pour les ic�nes -->
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
            margin-bottom: 15px; /* Espacement entre les �l�ments de la liste */
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
            gap: 20px; /* Espacement entre les ic�nes */
            margin-top: 20px;
        }

        .social-icons a {
            color: #fff;
            text-decoration: none;
            font-size: 24px; /* Taille des ic�nes */
            transition: color 0.3s;
        }

        .social-icons a:hover {
            color: #e50914;
        }

        @media (max-width: 768px) {
            .footer-content {
                grid-template-columns: repeat(2, 1fr); /* Deux colonnes sur les �crans moyens */
                gap: 30px;
            }
        }

        @media (max-width: 480px) {
            .footer-content {
                grid-template-columns: 1fr; /* Une colonne sur les petits �crans */
                gap: 20px;
            }

            .social-icons {
                justify-content: center; /* Centrer les ic�nes sur les petits �crans */
            }
        }
    </style>
</head>
<body>
  
    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>LES NOUVEAUT�S � L'AFFICHE</h3>
                <ul>
                    <li><a href="#">Mufass : Le Roi Lion</a></li>
                    <li><a href="#">SONIC 3 - le film</a></li>
                    <li><a href="#">Valana 2</a></li>
                    <li><a href="#">Un ours dans le Jura</a></li>
                    <li><a href="#">Firma accueilement au cin�ma</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>CHI�MAS DANS VOS VILLES</h3>
                <ul>
                    <li><a href="#">Chi�rans � Paris</a></li>
                    <li><a href="#">Chi�rans � Lyon</a></li>
                    <li><a href="#">Chi�rans � Marseille</a></li>
                    <li><a href="#">Chi�rans � Toulouse</a></li>
                    <li><a href="#">Chi�rans � Nice</a></li>
                    <li><a href="#">Chi�rans autour de moi</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>� PROPOS</h3>
                <ul>
                    <li><a href="#">Criti�bres</a></li>
                    <li><a href="#">Criti�Cartes</a></li>
                    <li><a href="#">IMAX</a></li>
                    <li><a href="#">Dolly Cinema</a></li>
                    <li><a href="#">40X</a></li>
                    <li><a href="#">ScreenX</a></li>
                    <li><a href="#">Metropolitan Opera</a></li>
                    <li><a href="#">Nos exp�riences</a></li>
                    <li><a href="#">Toutes les actualit�s</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>SUIVEZ-NOUS</h3>
                <div class="social-icons">
                    <!-- Ic�ne Facebook -->
                    <a href="https://facebook.com" target="_blank" title="Facebook">
                        <i class="fab fa-facebook"></i>
                    </a>
                    <!-- Ic�ne Instagram -->
                    <a href="https://instagram.com" target="_blank" title="Instagram">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <!-- Ic�ne Email -->
                    <a href="mailto:contact@cinema.com" title="Email">
                        <i class="fas fa-envelope"></i>
                    </a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2025 Cin�ma application. Tous droits r�serv�s.</p>
        </div>
    </footer>
</body>
</html>