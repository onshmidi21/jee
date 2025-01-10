package com.controlleur;

import com.entities.Cinema;
import com.entities.Film;
import com.services.CinemaLocal;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CinemaServlet", urlPatterns = {"/cinema"})
public class CinemaServlet extends HttpServlet {

    @EJB
    private CinemaLocal cinemaService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Définir l'encodage de la réponse
        response.setContentType("text/html;charset=UTF-8");
        
        // Récupérer tous les cinémas pour les afficher
        List<Cinema> cinemas = cinemaService.findAll();
        request.setAttribute("cinemas", cinemas);

        // Récupérer l'ID du cinéma sélectionné
        String cinemaIdParam = request.getParameter("cinemaId");
        if (cinemaIdParam != null && !cinemaIdParam.isEmpty()) {
            try {
                int cinemaId = Integer.parseInt(cinemaIdParam);

                // Récupérer les films associés au cinéma
                List<Film> films = cinemaService.getFilmsByCinemaId(cinemaId);

                if (films != null && !films.isEmpty()) {
                    request.setAttribute("films", films);
                } else {
                    request.setAttribute("message", "Aucun film trouvé pour le cinéma sélectionné.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("message", "L'ID du cinéma est invalide.");
            }
        } else {
            request.setAttribute("message", "Veuillez sélectionner un cinéma.");
        }

        // Rediriger vers la page JSP
        request.getRequestDispatcher("/cinema.jsp").forward(request, response);
    }
    
}
