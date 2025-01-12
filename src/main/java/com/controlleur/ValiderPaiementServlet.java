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

@WebServlet("/validerPaiement")
public class ValiderPaiementServlet extends HttpServlet {

    @EJB
    private PaiementLocal paiementService;

    @EJB
    private CompteLocal compteLocal;

    @EJB
    private PlaceLocal placeService;

    @EJB
    private SeanceLocal seanceService;

    private static final Logger logger = Logger.getLogger(ValiderPaiementServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.info("Accès à la page de validation de paiement via GET");

        // Récupérer les paramètres de la requête
        String placeIdParam = request.getParameter("placeId");
        String seanceIdParam = request.getParameter("seanceId");

        // Vérifier si l'utilisateur est connecté
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // Stocker les informations de la réservation dans la session
            session = request.getSession(true); // Créer une nouvelle session si elle n'existe pas
            session.setAttribute("placeId", placeIdParam);
            session.setAttribute("seanceId", seanceIdParam);

            // Rediriger vers la page de login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Récupérer l'utilisateur de la session
        User user = (User) session.getAttribute("user");

        if (placeIdParam == null || seanceIdParam == null) {
            gererErreur(request, response, "Les paramètres sont manquants.", "/confirmationPaiement.jsp");
            return;
        }

        try {
            int placeId = Integer.parseInt(placeIdParam);
            int seanceId = Integer.parseInt(seanceIdParam);

            // Récupérer la place et la séance
            Place place = placeService.find(placeId);
            Seance seance = seanceService.find(seanceId);

            if (place == null || seance == null) {
                gererErreur(request, response, "Place ou séance non trouvée.", "/confirmationPaiement.jsp");
                return;
            }

            // Passer les informations à la JSP pour afficher les détails de la réservation
            request.setAttribute("place", place);
            request.setAttribute("seance", seance);
            request.getRequestDispatcher("/confirmationPaiement.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            logger.severe("Paramètres invalides : " + e.getMessage());
            gererErreur(request, response, "Paramètres invalides.", "/confirmationPaiement.jsp");
        } catch (Exception e) {
            logger.severe("Erreur lors de la récupération des détails de la réservation : " + e.getMessage());
            gererErreur(request, response, "Une erreur s'est produite lors de la récupération des détails de la réservation.", "/confirmationPaiement.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.info("Début de la validation du paiement");

        // Récupérer les paramètres
        String placeIdParam = request.getParameter("placeId");
        String seanceIdParam = request.getParameter("seanceId");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // Stocker les informations de la réservation dans la session
            session = request.getSession(true); // Créer une nouvelle session si elle n'existe pas
            session.setAttribute("placeId", placeIdParam);
            session.setAttribute("seanceId", seanceIdParam);

            // Rediriger vers la page de login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Récupérer l'utilisateur de la session
        User user = (User) session.getAttribute("user");

        if (placeIdParam == null || seanceIdParam == null) {
            gererErreur(request, response, "Les paramètres sont manquants.", "/confirmationPaiement.jsp");
            return;
        }

        try {
            int placeId = Integer.parseInt(placeIdParam);
            int seanceId = Integer.parseInt(seanceIdParam);

            // Récupérer la place et la séance
            Place place = placeService.find(placeId);
            Seance seance = seanceService.find(seanceId);

            if (place == null || seance == null) {
                gererErreur(request, response, "Place ou séance non trouvée.", "/confirmationPaiement.jsp");
                return;
            }

            // Récupérer le compte de l'utilisateur
            Compte compte = compteLocal.findByUser(user);

            if (compte == null) {
                gererErreur(request, response, "Compte utilisateur introuvable.", "/confirmationPaiement.jsp");
                return;
            }

            // Effectuer le paiement
            boolean paiementReussi = paiementService.effectuerPaiementAvecPlaceEtSeance(compte.getId(), placeId, seanceId);

            if (paiementReussi) {
                // Rediriger vers la page de génération du ticket
                response.sendRedirect(request.getContextPath() + "/generateTicket?placeId=" + placeId + "&seanceId=" + seanceId);
            } else {
                gererErreur(request, response, "Paiement échoué. Solde insuffisant.", "/confirmationPaiement.jsp");
            }
        } catch (NumberFormatException e) {
            logger.severe("Paramètres invalides : " + e.getMessage());
            gererErreur(request, response, "Paramètres invalides.", "/confirmationPaiement.jsp");
        } catch (Exception e) {
            logger.severe("Erreur lors du paiement : " + e.getMessage());
            gererErreur(request, response, "Une erreur s'est produite lors du paiement.", "/confirmationPaiement.jsp");
        }
    }

    private void gererErreur(HttpServletRequest request, HttpServletResponse response, String messageErreur, String destination)
            throws ServletException, IOException {
        request.setAttribute("error", messageErreur);
        request.getRequestDispatcher(destination).forward(request, response);
    }
}