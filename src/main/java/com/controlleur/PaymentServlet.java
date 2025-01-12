package com.controlleur;

import com.entities.Compte;
import com.entities.Place;
import com.entities.Seance;
import com.entities.User;
import com.services.CompteLocal;
import com.services.PaiementLocal;
import com.services.PlaceLocal;
import com.services.SeanceLocal;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/paiement")
public class PaymentServlet extends HttpServlet {

    @EJB
    private PaiementLocal paiementService;

    @EJB
    private CompteLocal compteLocal;

    @EJB
    private PlaceLocal placeService;

    @EJB
    private SeanceLocal seanceService;

    private static final Logger logger = Logger.getLogger(PaymentServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.info("Début du traitement de la réservation");

        String placeIdParam = request.getParameter("placeId");
        String seanceIdParam = request.getParameter("seanceId");

        if (placeIdParam == null || seanceIdParam == null) {
            gererErreur(request, response, "Les paramètres sont manquants.", "/paiement.jsp");
            return;
        }

        try {
            int placeId = Integer.parseInt(placeIdParam);
            int seanceId = Integer.parseInt(seanceIdParam);

            if (placeId <= 0 || seanceId <= 0) {
                gererErreur(request, response, "ID de place ou de séance invalide.", "/paiement.jsp");
                return;
            }

            // Récupérer la place et la séance
            Place place = placeService.find(placeId);
            Seance seance = seanceService.find(seanceId);

            if (place == null || seance == null) {
                gererErreur(request, response, "Place ou séance non trouvée.", "/paiement.jsp");
                return;
            }

            // Passer les informations à la JSP pour afficher les détails de la réservation
            request.setAttribute("place", place);
            request.setAttribute("seance", seance);
            request.getRequestDispatcher("/confirmationPaiement.jsp").forward(request, response);


        } catch (NumberFormatException e) {
            logger.severe("Paramètres invalides : " + e.getMessage());
            gererErreur(request, response, "Paramètres invalides.", "/paiement.jsp");
        } catch (Exception e) {
            logger.severe("Erreur lors de la réservation : " + e.getMessage());
            gererErreur(request, response, "Une erreur s'est produite lors de la réservation.", "/paiement.jsp");
        }
    }

    private void gererErreur(HttpServletRequest request, HttpServletResponse response, String messageErreur, String destination)
            throws ServletException, IOException {
        request.setAttribute("error", messageErreur);
        request.getRequestDispatcher(destination).forward(request, response);
    }
}