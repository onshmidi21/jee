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
    public boolean effectuerPaiement(int compteId, Float montant) {
        if (montant == null || montant <= 0.0f) {
            throw new IllegalArgumentException("Le montant doit être positif");
        }

        Compte compte = compteService.find(compteId);
        if (compte == null) {
            throw new IllegalArgumentException("Compte non trouvé");
        }

        if (compte.getSolde() < montant) {
            return false; // Solde insuffisant
        }

        // Débiter le compte
        compte.setSolde(compte.getSolde() - montant);
        compteService.update(compte);
        

        return true; // Paiement effectué avec succès
    }
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

    @Override
    public boolean crediterCompte(int compteId, Float montant) {
        if (montant == null || montant <= 0.0f) {
            throw new IllegalArgumentException("Le montant doit être positif");
        }

        Compte compte = compteService.find(compteId);
        if (compte == null) {
            throw new IllegalArgumentException("Compte non trouvé");
        }

        // Créditer le compte
        compte.setSolde(compte.getSolde() + montant);
        compteService.update(compte);

        return true; // Crédit effectué avec succès
    }

    @Override
    public Float consulterSolde(int compteId) {
        Compte compte = compteService.find(compteId);
        if (compte == null) {
            throw new IllegalArgumentException("Compte non trouvé");
        }
        return compte.getSolde();
    }
}
