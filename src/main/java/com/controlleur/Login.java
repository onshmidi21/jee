package com.controlleur;

import com.entities.User;
import com.services.UserLocal;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/login")
public class Login extends HttpServlet {

    private static final Logger logger = Logger.getLogger(Login.class.getName());

    @EJB
    private UserLocal userService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Rediriger vers la page de login si la méthode GET est utilisée
        System.out.println("Accès à la page de login via GET.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String login = request.getParameter("login");
        String password = request.getParameter("password");

        // Validation des entrées
        if (login == null || login.isEmpty() || password == null || password.isEmpty()) {
            System.out.println("Champs de connexion vides.");
            request.setAttribute("errorMessage", "Veuillez remplir tous les champs.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            // Authentification de l'utilisateur
            boolean isAuthenticated = userService.authenticate(login, password);

            if (isAuthenticated) {
                // Authentification réussie : créer une session utilisateur
                HttpSession session = request.getSession();
                User user = userService.findByLogin(login);
                session.setAttribute("user", user);

                // Récupérer l'URL de redirection depuis la session
                String redirectUrl = (String) session.getAttribute("redirectAfterLogin");

                System.out.println("Tentative de connexion avec login : " + login);
                System.out.println("URL de redirection après login : " + redirectUrl);

                if (redirectUrl != null && !redirectUrl.isEmpty()) {
                    // Rediriger vers la page précédemment demandée
                    System.out.println("Redirection vers : " + redirectUrl);
                    response.sendRedirect(redirectUrl);
                    // Nettoyer l'attribut de session après la redirection
                    session.removeAttribute("redirectAfterLogin");
                } else {
                    // Rediriger vers la page d'accueil par défaut si aucune URL n'est stockée
                    System.out.println("Redirection vers la page d'accueil.");
                    response.sendRedirect(request.getContextPath() + "/films");
                }
            } else {
                // Authentification échouée : retourner à la page de login avec un message d'erreur
                System.out.println("Échec de l'authentification pour le login : " + login);
                request.setAttribute("errorMessage", "Login ou mot de passe incorrect.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Journaliser l'erreur et afficher un message d'erreur générique
            System.out.println("Erreur lors de l'authentification : " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur s'est produite lors de l'authentification. Veuillez réessayer.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}