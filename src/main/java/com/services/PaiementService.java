package com.services;


import com.entities.Compte;
import com.entities.Place;
import com.entities.Ticket;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import com.entities.Place.Status;
import com.entities.Seance;
@Stateless
public class PaiementService implements PaiementLocal {

    @PersistenceContext(unitName = "Cinema-ejbPU")
    private EntityManager entityMgr;

    @EJB
    private CompteLocal compteService;
    @EJB
    private PlaceLocal placeservice;
    @EJB
    private SeanceLocal seanceservice;
    @PersistenceContext
    private EntityManager em;

    
    @Override
    public boolean effectuerPaiementAvecPlaceEtSeance(int compteId, int placeId, int seanceId) {
    	    Compte compte = compteService.find(compteId);
    	    Place place = placeservice.find(placeId);
    	    Seance seance = seanceservice.find(seanceId);

    	    if (compte == null || place == null || seance == null) {
    	    	System.err.println("Erreur : Compte, place ou séance non trouvé.");
    	        return false;
    	    }

    	    // Vérifier le solde du compte
    	    if (compte.getSolde() < seance.getTarif()) {
    	    	System.err.println("Solde insuffisant.");
    	        return false;
    	    }

    	    // Débiter le compte
    	    compte.setSolde(compte.getSolde() - seance.getTarif());
    	    compteService.update(compte);

    	    // Marquer la place comme occupée
    	    place.setStatus(Status.OCCUPEE);
    	    placeservice.update(place);

    	    return true;
    	}

    

    
}
