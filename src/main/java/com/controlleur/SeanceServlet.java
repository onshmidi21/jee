package com.controlleur;

import com.entities.Film;
import com.entities.Seance;
import com.services.FilmImp;
import com.services.FilmLocal;
import com.services.SeanceLocal;

import jakarta.ejb.EJB;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/seances")
public class SeanceServlet extends HttpServlet {

    @EJB
    private SeanceLocal seanceService;  // Injection de la dépendance SeanceLocal
    
    @EJB
    private FilmLocal filmLocal;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer l'ID du film depuis la requête
        String filmIdParam = request.getParameter("filmId");

        if (filmIdParam != null) {
            try {
                // Convertir l'ID du film en entier
                int filmId = Integer.parseInt(filmIdParam);
                
                // Trouver le film correspondant à cet ID
                Film film = filmLocal.find(filmId);

                if (film != null) {
                    // Récupérer les séances pour ce film
                    List<Seance> seances = seanceService.findByFilm(film);
                    // Ajouter les séances au modèle de la requête
                    request.setAttribute("seances", seances);
                    // Ajouter le film pour affichage (facultatif)
                    request.setAttribute("film", film);
                    // Transmettre à la JSP
                    request.getRequestDispatcher("/seances.jsp").forward(request, response);
                } else {
                    // Si le film n'est pas trouvé, rediriger vers une erreur
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Film non trouvé");
                }
            } catch (NumberFormatException e) {
                // Si l'ID du film n'est pas un entier valide
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID du film invalide");
            }
        } else {
            // Si aucun film ID n'est fourni, rediriger vers une page d'index
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID du film manquant");
        }
    }
}
