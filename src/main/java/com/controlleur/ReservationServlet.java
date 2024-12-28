package com.controlleur;

import java.io.IOException;
import java.util.List;

import com.entities.Place;
import com.entities.Seance;
import com.services.PlaceLocal;
import com.services.SeanceLocal;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "reservationServlet", urlPatterns = {"/reservation"})
public class ReservationServlet extends HttpServlet {
    @EJB
    private SeanceLocal seanceLocal;
    @EJB
    private PlaceLocal placeLocal;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int seanceId = Integer.parseInt(request.getParameter("seance_id"));
        Seance seance = seanceLocal.find(seanceId);
        
        if (seance == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Séance non trouvée.");
            return;
        }

        // Passer les informations à la JSP
        List<Place> places = placeLocal.findBySeance(seanceId);
        int colCount = 10; // Nombre de places par rangée (modifiable)
        int rowCount = (int) Math.ceil((double) places.size() / colCount); // Calcul du nombre de rangées

        // Passer les informations à la JSP
        request.setAttribute("seance", seance);
        request.setAttribute("places", places);
        request.setAttribute("colCount", colCount);
        request.setAttribute("rowCount", rowCount);
        
        request.getRequestDispatcher("/reservation.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String placeIdParam = request.getParameter("placeId");
        String seanceIdParam = request.getParameter("seanceId");

        // Ajoutez des logs pour déboguer
        System.out.println("placeId reçu : " + placeIdParam);
        System.out.println("seanceId reçu : " + seanceIdParam);

        // Vérification des paramètres
        if (placeIdParam == null || seanceIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Les paramètres sont manquants.");
            return;
        }

        try {
            int placeId = Integer.parseInt(placeIdParam);
            int seanceId = Integer.parseInt(seanceIdParam);

            // Recherche des objets Place et Seance
            Place place = placeLocal.find(placeId);
            if (place == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Place introuvable.");
                return;
            }

            Seance seance = seanceLocal.find(seanceId);
            if (seance == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Séance introuvable.");
                return;
            }

           

            // Redirection vers la génération du ticket
            request.setAttribute("place", place);
            request.setAttribute("seance", seance);
            request.getRequestDispatcher("/generateTicket").forward(request, response);

        } catch (NumberFormatException e) {
            System.out.println("Erreur de conversion : " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètres invalides.");
        }
    }
}