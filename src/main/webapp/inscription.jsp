<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

        /* Style du formulaire */
        #corps {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f9;
        }

        #bloc_page {
            background-color: #fff;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 100%;
            max-width: 600px;
        }

        .input {
            margin-bottom: 15px;
            padding: 10px;
            width: 100%;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .publier {
            background-color: #000;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .publier:hover {
            background-color: #333;
        }

        @media (max-width: 768px) {
            .main-nav {
                display: none;
            }
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div id="corps">
    <div id="bloc_page">
        <section>
            <article>
                <p style="text-align: center; font-size: 18px; margin-bottom: 20px;">Remplissez le formulaire suivant pour vous inscrire</p>
                <form method="post" action="inscrit">
                    <label for="nom"><b class="input">Nom</b></label>
                    <input class="input" placeholder="Nom" required autofocus type="text" name="nom" id="nom" size="30" value="">

                    <label for="prenom"><b class="input">Prénom</b></label>
                    <input class="input" required placeholder="Prénom" type="text" name="prenom" id="prenom" size="30" value="">

                    <label for="email"><b class="input">Email</b></label>
                    <input class="input" placeholder="exemple@exemple.com" required type="email" name="email" id="email" size="30" value="">

                    <label for="adresse"><b class="input">Adresse</b></label>
                    <input class="input" placeholder="Adresse Postale" required type="text" name="adresse" id="adresse" size="30" value="">

                    <label for="login"><b class="input">Login</b></label>
                    <input class="input" placeholder="Login" required type="text" name="login" id="login" size="30" value="">

                    <label for="password"><b class="input">Mot de passe</b></label>
                    <input class="input" placeholder="Mot de passe" required type="password" name="password" id="password" size="30" value="">

                    <input class="publier" type="submit" name="Valider" value="Valider">
                </form>
            </article>
        </section>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
