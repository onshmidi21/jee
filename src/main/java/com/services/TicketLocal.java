package com.services;

import java.util.List;

import com.entities.Ticket;

import jakarta.ejb.Local;
@Local
public interface TicketLocal {

	 Ticket create(Ticket ticket);
	    Ticket find(int id);
	    void update(Ticket ticket);
	    void delete(Ticket ticket);
	    List<Ticket> findAll();
	    public Ticket generateTicket(int placeId, int seanceId);

}
