package com.services;

import jakarta.ejb.Local;
import java.math.BigDecimal;

@Local
public interface PaiementLocal {
    public boolean effectuerPaiementAvecPlaceEtSeance(int compteId, int placeId, int seanceId);}