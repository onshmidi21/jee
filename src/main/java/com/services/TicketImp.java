
package com.services;

import java.util.List;

import com.entities.*;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class TicketImp implements TicketLocal {
    @PersistenceContext(unitName = "Cinema-ejbPU")

    private EntityManager em;
    
   
    
    @Override
    public Ticket find(int id) {
        return em.find(Ticket.class, id);
    }
    
    
    
   
    @Override
    public List<Ticket> findAll() {
        return em.createQuery("SELECT t FROM Ticket t", Ticket.class).getResultList();
    }
    public Ticket generateTicket(int placeId, int seanceId) {
        Place place = em.find(Place.class, placeId);
        Seance seance = em.find(Seance.class, seanceId);
        
        if (place == null || seance == null) {
            throw new IllegalArgumentException("Place ou séance invalide");
        }
        
       
        
        Ticket ticket = new Ticket();
        ticket.setPlace(place);
        ticket.setSeance(seance);
        
        
        
        // Persister le ticket
        em.persist(ticket);
        
        return ticket;
    }
  
	@Override
	public Ticket create(Ticket ticket) {
		em.persist(ticket);
        return ticket;
	}

	@Override
	public void update(Ticket ticket) {
        em.merge(ticket);
		
	}

	@Override
	public void delete(Ticket ticket) {
        em.remove(em.merge(ticket));
		
	}
}