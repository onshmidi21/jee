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

@WebServlet("/login")
public class Login extends HttpServlet {

    @EJB
    private UserLocal userService;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Rediriger vers la page de login si la méthode GET est utilisée
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String login = request.getParameter("login");
        String password = request.getParameter("password");

        boolean isAuthenticated = userService.authenticate(login, password);

        if (isAuthenticated) {
            // Authentification réussie : créer une session utilisateur
            HttpSession session = request.getSession();
            User user = userService.findByLogin(login);
            session.setAttribute("user", user);

            // Vérifier s'il y a une réservation en attente
            String placeId = (String) session.getAttribute("reservationPlaceId");
            String seanceId = (String) session.getAttribute("reservationSeanceId");

            if (placeId != null && seanceId != null) {
                // Rediriger vers la page de paiement
                response.sendRedirect(request.getContextPath() + "/paiement?placeId=" + placeId + "&seanceId=" + seanceId);
                session.removeAttribute("reservationPlaceId");
                session.removeAttribute("reservationSeanceId");
            } else {
                // Rediriger vers la page d'accueil
                response.sendRedirect(request.getContextPath() + "/films");
            }
        } else {
            // Authentification échouée : retourner à la page de login avec un message d'erreur
            request.setAttribute("errorMessage", "Login ou mot de passe incorrect.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }}