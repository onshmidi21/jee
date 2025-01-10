<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Creative Header - Noir et Orange</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: #f4f4f4;
        }

        header {
            background: #000; /* Fond noir */
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }

        header.sticky {
            position: fixed;
            background: #000; /* Fond noir fixe */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }

        .top-header {
            background: rgba(255, 69, 0, 0.1); /* Fond orange transparent */
            padding: 10px 0;
        }

        .top-header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: flex-end;
            padding: 0 20px;
        }

        .top-header a {
            color: #fff; /* Texte blanc */
            text-decoration: none;
            font-size: 14px;
            margin-left: 20px;
            transition: color 0.3s;
        }

        .top-header a:hover {
            color: #ff4500; /* Orange au survol */
        }

        .main-header {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            position: relative;
        }

        .logo {
            color: #ff4500; /* Logo orange */
            font-size: 28px;
            font-weight: bold;
            text-decoration: none;
            display: flex;
            align-items: center;
        }

        .logo img {
            width: 40px;
            margin-right: 10px;
            animation: spin 5s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .main-nav {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-grow: 1; /* Prend tout l'espace disponible */
            margin-left: 20px; /* Évite que le nav ne touche le logo */
        }

        .main-nav a {
            color: #fff; /* Texte blanc */
            text-decoration: none;
            margin: 0 15px; /* Espacement entre les liens */
            font-weight: bold;
            position: relative;
            transition: color 0.3s;
        }

        .main-nav a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            background: #ff4500; /* Ligne orange */
            bottom: -5px;
            left: 0;
            transition: width 0.3s;
        }

        .main-nav a:hover::after {
            width: 100%;
        }

        @media (max-width: 768px) {
            .main-nav {
                display: none;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <header>
        <div class="top-header">
            <div class="top-header-content">
                <a href="login.jsp">Connexion</a>
                <a href="inscription.jsp">Créer un compte</a>
            </div>
        </div>
        <div class="main-header">
            <a href="#" class="logo">
                <img src="https://via.placeholder.com/40" alt="Logo">
                Cinema
            </a>
            <nav class="main-nav">
                <a href="films">Films à l'affiche</a>
                <a href="cinema">Cinémas</a>
            </nav>
        </div>
    </header>

    <script>
        $(window).scroll(function() {
            if ($(this).scrollTop() > 100) {
                $('header').addClass('sticky');
            } else {
                $('header').removeClass('sticky');
            }
        });
    </script>
</body>
</html>