package com.controlleur;

import com.entities.Film;
import com.entities.Seance;
import com.services.FilmLocal;
import com.services.SeanceLocal;

import jakarta.ejb.EJB;
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

        // Vérifier si l'ID du film est fourni
        if (filmIdParam == null || filmIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID du film manquant");
            return;
        }

        try {
            // Convertir l'ID du film en entier
            int filmId = Integer.parseInt(filmIdParam);

            // Trouver le film correspondant à cet ID
            Film film = filmLocal.find(filmId);

            // Vérifier si le film existe
            if (film == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Film non trouvé");
                return;
            }

            // Récupérer les séances pour ce film
            List<Seance> seances = seanceService.findByFilm(film);

            // Ajouter les séances et le film au modèle de la requête
            request.setAttribute("seances", seances);
            request.setAttribute("film", film);

            // Transmettre à la JSP
            request.getRequestDispatcher("/seances.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // Si l'ID du film n'est pas un entier valide
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID du film invalide");
        } catch (Exception e) {
            // Gestion des autres exceptions
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Une erreur interne est survenue");
        }
    }
}