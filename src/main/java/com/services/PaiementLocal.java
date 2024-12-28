package com.services;

import jakarta.ejb.Local;
import java.math.BigDecimal;

@Local
public interface PaiementLocal {
    boolean effectuerPaiement(int compteId, Float montant);
    boolean crediterCompte(int compteId, Float montant);
    Float consulterSolde(int compteId);
    public boolean effectuerPaiementAvecTicket(int compteId, int ticketId);
}