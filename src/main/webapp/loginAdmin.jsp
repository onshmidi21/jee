<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login Admin</title>
</head>
<body>
    <h1>Connexion Admin</h1>
    <form action="loginAdmin" method="post">
        <label for="login">Login:</label>
        <input type="text" id="login" name="login" required><br><br>
        <label for="password">Mot de passe:</label>
        <input type="password" id="password" name="password" required><br><br>
        <button type="submit">Se connecter</button>
    </form>
    <p style="color: red;">${error}</p>
</body>
</html>