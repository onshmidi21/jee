<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: black;
            color: orange;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        h1 {
            color: orange;
            text-align: center;
            font-size: 2.5em;
            animation: glow 2s infinite alternate;
        }
        @keyframes glow {
            from {
                text-shadow: 0 0 10px orange, 0 0 20px orange, 0 0 30px darkorange;
            }
            to {
                text-shadow: 0 0 20px orange, 0 0 30px darkorange, 0 0 40px darkorange;
            }
        }
        form {
            background-color: #333;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(255, 165, 0, 0.7);
            width: 300px;
            text-align: center;
        }
        label {
            color: orange;
            font-weight: bold;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid orange;
            border-radius: 4px;
            background-color: #444;
            color: orange;
            font-size: 1em;
        }
        button {
            background-color: orange;
            color: black;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 1.1em;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: darkorange;
            transform: scale(1.05);
        }
        p {
            color: red;
            text-align: center;
            font-weight: bold;
        }
        .fun-text {
            color: orange;
            font-size: 1.2em;
            margin-top: 20px;
            animation: bounce 2s infinite;
        }
        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div>
        <h1>Connexion Admin</h1>
        <form action="loginAdmin" method="post">
            <label for="login">Login:</label>
            <input type="text" id="login" name="login" required><br><br>
            <label for="password">Mot de passe:</label>
            <input type="password" id="password" name="password" required><br><br>
            <button type="submit">Se connecter</button>
        </form>
        <p>${error}</p>
    </div>
        <%@ include file="footer.jsp" %>
    
</body>
</html>