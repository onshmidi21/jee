package com.services;

import com.entities.SalleDeProjection;
import com.entities.Seance;

import jakarta.ejb.Local;

import java.util.List;
@Local

public interface SalleDeProjectionLocal {
    void create(SalleDeProjection salleDeProjection);
    void update(SalleDeProjection salleDeProjection);
    void remove(SalleDeProjection salleDeProjection);
    SalleDeProjection find(int id);
    List<SalleDeProjection> findAll();
    List<SalleDeProjection> findByFilm(int filmId); // Optionnel : pour trouver les salles par film
	SalleDeProjection getOrCreateSalleDeProjection(int salleId, int filmId);
	public List<Seance> getSeancesBySalleDeProjection(int salleDeProjectionId);
}