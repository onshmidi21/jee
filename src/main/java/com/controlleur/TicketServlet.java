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

@WebServlet("/generateTicket")
public class TicketServlet extends HttpServlet {
	    
	    @EJB
	    private PlaceLocal placeLocal;
	    
	    @EJB
	    private SeanceLocal seanceLocal;
	    
	    @EJB
	    private TicketLocal ticketLocal;
	    
	    
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
	    