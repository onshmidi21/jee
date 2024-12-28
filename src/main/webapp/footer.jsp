<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Footer</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        footer {
            background: #1a1a1a;
            color: #fff;
            padding: 50px 0 20px;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 30px;
            padding: 0 20px;
        }

        .footer-section h3 {
            color: #e50914;
            margin-bottom: 20px;
            font-size: 18px;
        }

        .footer-section ul {
            list-style: none;
        }

        .footer-section ul li {
            margin-bottom: 10px;
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
            gap: 15px;
            margin-top: 20px;
        }

        .social-icons a {
            color: #fff;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }

        .social-icons a:hover {
            color: #e50914;
        }

        @media (max-width: 768px) {
            .footer-content {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 480px) {
            .footer-content {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3> CINÉMA</h3>
                <ul>
                    <li><a href="#">À propos</a></li>
                    <li><a href="#">Nos cinémas</a></li>
                    <li><a href="#">Offres et promotions</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>INFORMATIONS</h3>
                <ul>
                    <li><a href="#">CGV</a></li>
                    <li><a href="#">Mentions légales</a></li>
                    <li><a href="#">Politique de confidentialité</a></li>
                    <li><a href="#">Cookies</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>AIDE</h3>
                <ul>
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Contact</a></li>
                    <li><a href="#">Plan du site</a></li>
                    <li><a href="#">Guide d'utilisation</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>SUIVEZ-NOUS</h3>
                <div class="social-icons">
                    <a href="#" title="Facebook">FB</a>
                    <a href="#" title="Twitter">TW</a>
                    <a href="#" title="Instagram">IG</a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024  Cinéma application. Tous droits réservés.</p>
        </div>
    </footer>
</body>
</html>