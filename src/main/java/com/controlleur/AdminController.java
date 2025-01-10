package com.controlleur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();

        if (action == null || action.equals("/")) {
            // Afficher le tableau de bord
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
        } else {
            switch (action) {
            case "/films":
                // Rediriger vers le contrôleur des films
                response.sendRedirect(request.getContextPath() + "/filmAdmin");
                break;
            case "/users":
                // Rediriger vers le contrôleur des utilisateurs
                request.getRequestDispatcher("/admin/userAdmin").forward(request, response);
                break;
            case "/cinemas":
                // Rediriger vers le contrôleur des cinémas
                request.getRequestDispatcher("/admin/cinemaAdmin").forward(request, response);
                break;
            case "/salle":
                // Rediriger vers le contrôleur des cinémas
                request.getRequestDispatcher("/admin/salleAdmin").forward(request, response);
                break;
            case "/seance":
                // Rediriger vers le contrôleur des cinémas
                request.getRequestDispatcher("/admin/seanceAdmin").forward(request, response);
                break;
        }}
    }
}