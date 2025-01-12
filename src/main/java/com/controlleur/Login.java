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
        // Récupérer l'URL de la page précédente (referer)
        String referer = request.getHeader("referer");
        HttpSession session = request.getSession();

        // Stocker l'URL de la page précédente dans la session
        if (referer != null && !referer.contains("/login")) {
            session.setAttribute("redirectAfterLogin", referer);
            System.out.println("URL de redirection stockée : " + referer);
        }

        // Rediriger vers la page de login
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

                // Récupérer les identifiants de la réservation depuis la session
                String placeId = (String) session.getAttribute("placeId");
                String seanceId = (String) session.getAttribute("seanceId");

                // Nettoyer la session après avoir récupéré les informations
                session.removeAttribute("placeId");
                session.removeAttribute("seanceId");

                // Rediriger vers la page de paiement avec les identifiants
                if (placeId != null && seanceId != null) {
                    System.out.println("Redirection vers la page de paiement avec placeId=" + placeId + " et seanceId=" + seanceId);
                    response.sendRedirect(request.getContextPath() + "/validerPaiement?placeId=" + placeId + "&seanceId=" + seanceId);
                } else {
                    // Rediriger vers la page d'accueil par défaut si aucune information n'est stockée
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