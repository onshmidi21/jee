package com.controlleur;

import java.io.IOException;

import com.entities.Compte;
import com.entities.Ticket;
import com.entities.User;
import com.services.CompteLocal;
import com.services.PaiementLocal;
import com.services.TicketLocal;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/paiement")
public class PaymentServlet extends HttpServlet {
    
    @EJB
    private PaiementLocal paiementService;
    
    @EJB
    private CompteLocal compteLocal;
    
    @EJB
    private TicketLocal ticketLocal;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String ticketIdParam = request.getParameter("ticketId");
        
        if (ticketIdParam == null || ticketIdParam.trim().isEmpty()) {
            request.setAttribute("error", "ID du ticket manquant.");
            request.getRequestDispatcher("/paiement.jsp").forward(request, response);
            return;
        }

        try {
            int ticketId = Integer.parseInt(ticketIdParam);
            Ticket ticket = ticketLocal.find(ticketId);
            
            if (ticket == null) {
                System.out.println("Ticket non trouvé pour l'ID: " + ticketId); // Debug log
                request.setAttribute("error", "Ticket non trouvé pour l'ID: " + ticketId);
                request.getRequestDispatcher("/paiement.jsp").forward(request, response);
                return;
            }

            Compte compte = compteLocal.findByUser(user);
            if (compte == null) {
                request.setAttribute("error", "Compte non trouvé pour l'utilisateur.");
                request.getRequestDispatcher("/paiement.jsp").forward(request, response);
                return;
            }

            // Définir les attributs pour la page JSP
            request.setAttribute("ticket", ticket);
            request.setAttribute("compte", compte);
            
            // Vérification du solde
            if (compte.getSolde() >= ticket.getSeance().getTarif()) {
                // Rediriger vers la page de paiement avec les informations
                request.getRequestDispatcher("/paiement.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Solde insuffisant. Veuillez vérifier votre compte.");
                request.getRequestDispatcher("/paiement.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Format d'ID de ticket invalide: " + ticketIdParam);
            request.getRequestDispatcher("/paiement.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Erreur lors du traitement: " + e.getMessage()); // Debug log
            request.setAttribute("error", "Une erreur s'est produite lors du traitement du paiement.");
            request.getRequestDispatcher("/paiement.jsp").forward(request, response);
        }
    } @Override
            protected void doPost(HttpServletRequest request, HttpServletResponse response)
                    throws ServletException, IOException {

                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("user");

                if (user == null) {
                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                    return;
                }

                String ticketIdParam = request.getParameter("ticketId");

                if (ticketIdParam == null || ticketIdParam.trim().isEmpty()) {
                    request.setAttribute("error", "ID du ticket manquant.");
                    request.getRequestDispatcher("/paiement.jsp").forward(request, response);
                    return;
                }

                try {
                    int ticketId = Integer.parseInt(ticketIdParam);
                    Ticket ticket = ticketLocal.find(ticketId);

                    if (ticket == null) {
                        request.setAttribute("error", "Ticket non trouvé pour l'ID: " + ticketId);
                        request.getRequestDispatcher("/paiement.jsp").forward(request, response);
                        return;
                    }

                    Compte compte = compteLocal.findByUser(user);
                    if (compte == null) {
                        request.setAttribute("error", "Compte non trouvé pour l'utilisateur.");
                        request.getRequestDispatcher("/paiement.jsp").forward(request, response);
                        return;
                    }

                    // Vérifier que le solde est suffisant et effectuer le paiement
                    if (compte.getSolde() >= ticket.getSeance().getTarif()) {
                        // Déduire le tarif du compte et mettre à jour le ticket comme payé
                        paiementService.effectuerPaiementAvecTicket(compte.getId(), ticketId);
                        request.setAttribute("success", "Le paiement a été effectué avec succès.");
                        request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Solde insuffisant. Veuillez vérifier votre compte.");
                        request.getRequestDispatcher("/paiement.jsp").forward(request, response);
                    }

                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Format d'ID de ticket invalide: " + ticketIdParam);
                    request.getRequestDispatcher("/paiement.jsp").forward(request, response);
                } catch (Exception e) {
                    request.setAttribute("error", "Une erreur s'est produite lors du traitement du paiement.");
                    request.getRequestDispatcher("/paiement.jsp").forward(request, response);
                }
            }}