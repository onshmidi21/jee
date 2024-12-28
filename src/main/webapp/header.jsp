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
            background: #000;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .top-header {
            background: #1a1a1a;
            padding: 5px 0;
        }

        .top-header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: flex-end;
            padding: 0 20px;
        }

        .top-header a {
            color: #fff;
            text-decoration: none;
            font-size: 14px;
            margin-left: 20px;
        }

        .main-header {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
        }

        .logo {
            color: #fff;
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
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
            transition: color 0.3s;
        }

        .main-nav a:hover {
            color: #e50914;
        }

        .search-bar {
            position: relative;
            margin-left: 30px;
        }

        .search-bar input {
            padding: 8px 15px;
            border-radius: 20px;
            border: none;
            width: 200px;
            background: #333;
            color: #fff;
        }

        @media (max-width: 768px) {
            .main-nav {
                display: none;
            }
        }
    </style>
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
            <a href="#" class="logo">Cinema</a>
            <nav class="main-nav">
                <a href="films">Films à l'affiche</a>
                <a href="cinema">Cinémas</a>
                <div class="search-bar">
                    <input type="text" placeholder="Rechercher...">
                </div>
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