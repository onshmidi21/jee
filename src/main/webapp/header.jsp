<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Header</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        header {
            background: #FFA500;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .main-header {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
        }

       
        .main-nav {
            display: flex;
            align-items: center;
        }

       .main-nav a {
            color: #fff;
            text-decoration: none;
            margin-left: 30px;
            font-weight: bold;
            transition: color 0.3s, background 0.3s;
            padding: 8px 12px;
            border-radius: 20px; /* Coins arrondis pour les liens */
        }
        
       .main-nav a:hover {
            color: #e50914; /* Couleur au survol */
            background: rgba(255, 255, 255, 0.1); /* Fond léger au survol */
        }
        
         .logo {
            color: #fff;
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
        }
        
        

        @media (max-width: 768px) {
            .main-nav {
                display: none;
                flex-direction: column;
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                background: rgba(0, 0, 0, 0.9);
                padding: 20px;
                gap: 15px;
            }
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <header>
       
        <div class="main-header">
            <a href="#" class="logo">Cinema</a>
            <nav class="main-nav">
                <a href="films">Films</a>
                <a href="cinema">Cinémas</a>
                <a href="login.jsp">Connexion</a>
                <a href="inscription.jsp">Créer un compte</a>
                <a href="loginAdmin.jsp">ConnexionAdmin </a>
                
          
           
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

        $('.search-bar input').on('focus', function() {
            $(this).css('width', '300px');
        }).on('blur', function() {
            $(this).css('width', '200px');
        });
    </script>
</body>
</html>