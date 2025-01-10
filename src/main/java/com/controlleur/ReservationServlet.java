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
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "reservationServlet", urlPatterns = {"/reservation"})
public class ReservationServlet extends HttpServlet {
    @EJB
    private SeanceLocal seanceLocal;
    @EJB
    private PlaceLocal placeLocal;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int seanceId = Integer.parseInt(request.getParameter("seance_id"));
        Seance seance = seanceLocal.find(seanceId);
        
        if (seance == null) {
            request.setAttribute("error", "Séance non trouvée.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        // Récupérer les places disponibles pour cette séance
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

    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String placeIdParam = request.getParameter("placeId");
        String seanceIdParam = request.getParameter("seanceId");

        if (placeIdParam == null || seanceIdParam == null) {
            request.setAttribute("error", "Les paramètres sont manquants.");
            request.getRequestDispatcher("/reservation.jsp").forward(request, response);
            return;
        }

        try {
            int placeId = Integer.parseInt(placeIdParam);
            int seanceId = Integer.parseInt(seanceIdParam);

         

            // Passer les informations à la page de paiement
            request.setAttribute("placeId", placeId);
            request.setAttribute("seanceId", seanceId);

            // Rediriger vers la page de paiement
            request.getRequestDispatcher("/paiement").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Paramètres invalides.");
            request.getRequestDispatcher("/reservation.jsp").forward(request, response);
        }
    }}