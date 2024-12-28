package com.services;

import com.entities.Compte;
import com.entities.Place;
import com.entities.Ticket;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import com.entities.Place.Status;
@Stateless
public class PaiementService implements PaiementLocal {

    @PersistenceContext(unitName = "Cinema-ejbPU")
    private EntityManager entityMgr;

    @EJB
    private CompteLocal compteService;
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
    public boolean effectuerPaiementAvecTicket(int compteId, int ticketId) {
        // Récupérer le ticket
        Ticket ticket = entityMgr.find(Ticket.class, ticketId);
        if (ticket == null) {
            throw new IllegalArgumentException("Ticket non trouvé");
        }

        // Vérifier le montant du ticket
        Float montant = (float) ticket.seance.getTarif();
        if (montant == null || montant <= 0.0f) {
            throw new IllegalArgumentException("Montant invalide pour le ticket");
        }
        // Mettre à jour le statut de la place à "OCCUPEE"
        ticket.place.setStatus(Status.OCCUPEE);
		em.merge(ticket.place);
        // Effectuer le paiement
        return effectuerPaiement(compteId, montant);

       
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
