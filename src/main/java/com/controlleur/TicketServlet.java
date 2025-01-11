package com.controlleur;

import java.io.IOException;

import com.entities.Place;
import com.entities.Seance;
import com.entities.Ticket;
import com.services.PlaceLocal;
import com.services.SeanceLocal;
import com.services.TicketLocal;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/generateTicket")
public class TicketServlet extends HttpServlet {
	    
	    @EJB
	    private PlaceLocal placeLocal;
	    
	    @EJB
	    private SeanceLocal seanceLocal;
	    
	    @EJB
	    private TicketLocal ticketLocal;
	    @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        HttpSession session = request.getSession();

	        // Récupérer le ticket depuis la session (s'il existe)
	        Ticket ticket = (Ticket) session.getAttribute("ticket");

	        if (ticket == null) {
	            // Si le ticket n'existe pas dans la session, en générer un nouveau
	            String placeIdStr = request.getParameter("placeId");
	            String seanceIdStr = request.getParameter("seanceId");

	            if (placeIdStr == null || placeIdStr.isEmpty() || seanceIdStr == null || seanceIdStr.isEmpty()) {
	                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Les paramètres placeId ou seanceId sont manquants.");
	                return;
	            }

	            try {
	                int placeId = Integer.parseInt(placeIdStr);
	                int seanceId = Integer.parseInt(seanceIdStr);

	                Seance seance = seanceLocal.find(seanceId);
	                Place place = placeLocal.find(placeId);

	                if (seance == null || place == null) {
	                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Séance ou place introuvable.");
	                    return;
	                }

	                // Générer un nouveau ticket
	                ticket = ticketLocal.generateTicket(placeId, seanceId);

	                // Stocker le ticket dans la session
	                session.setAttribute("ticket", ticket);
	            } catch (NumberFormatException e) {
	                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètres invalides.");
	                return;
	            } catch (Exception e) {
	                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Une erreur s'est produite lors de la génération du ticket.");
	                return;
	            }
	        }

	        // Passer les informations à la JSP
	        request.setAttribute("ticket", ticket);
	        request.setAttribute("seance", ticket.getSeance());
	        request.setAttribute("place", ticket.getPlace());

	        // Rediriger vers la page de ticket
	        RequestDispatcher dispatcher = request.getRequestDispatcher("ticket.jsp");
	        dispatcher.forward(request, response);
	    }
	    
	    	    	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    	    	    String placeIdStr = request.getParameter("placeId");
	    	    	    String seanceIdStr = request.getParameter("seanceId");

	    	    	    if (placeIdStr == null || placeIdStr.isEmpty() || seanceIdStr == null || seanceIdStr.isEmpty()) {
	    	    	        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Les paramètres placeId ou seanceId sont manquants.");
	    	    	        return;
	    	    	    }

	    	    	    try {
	    	    	        int placeId = Integer.parseInt(placeIdStr);
	    	    	        int seanceId = Integer.parseInt(seanceIdStr);

	    	    	        Seance seance = seanceLocal.find(seanceId);
	    	    	        Place place = placeLocal.find(placeId);
	    	    	        if (seance == null || place == null) {
	    	    	            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Séance ou place introuvable.");
	    	    	            return;
	    	    	        }

	    	    	        Ticket ticket = ticketLocal.generateTicket( placeId,seanceId);
	    	    	        request.setAttribute("ticket", ticket);
	    	    	        request.setAttribute("seance", seance);
	    	    	        request.setAttribute("place", place);
                            
	    	    	        RequestDispatcher dispatcher = request.getRequestDispatcher("ticket.jsp");
	    	    	        dispatcher.forward(request, response);
	    	    	    } catch (NumberFormatException e) {
	    	    	        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètres invalides.");
	    	    	    }
	    	    	}
	    	    }
	    