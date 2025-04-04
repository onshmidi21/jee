package com.services;

import com.entities.Film;
import com.entities.Salle;
import com.entities.SalleDeProjection;
import com.entities.Seance;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

import java.util.Collections;
import java.util.List;

@Stateless
public class SalleDeProjectionImp implements SalleDeProjectionLocal {

    @PersistenceContext(unitName = "Cinema-ejbPU")
    private EntityManager entityMgr;

    @EJB
    private SalleLocal salleService;

    @EJB
    private FilmLocal filmService;

    @Override
    public void create(SalleDeProjection salleDeProjection) {
        if (salleDeProjection == null) {
            throw new IllegalArgumentException("SalleDeProjection cannot be null");
        }
        entityMgr.persist(salleDeProjection);
    }

    @Override
    public void update(SalleDeProjection salleDeProjection) {
        if (salleDeProjection == null) {
            throw new IllegalArgumentException("SalleDeProjection cannot be null");
        }
        entityMgr.merge(salleDeProjection);
    }

    @Override
    public void remove(SalleDeProjection salleDeProjection) {
        if (salleDeProjection == null) {
            throw new IllegalArgumentException("SalleDeProjection cannot be null");
        }
        SalleDeProjection managedSalle = entityMgr.find(SalleDeProjection.class, salleDeProjection.getId());
        if (managedSalle != null) {
            entityMgr.remove(managedSalle);
        }
    }

    @Override
    public SalleDeProjection find(int id) {
        return entityMgr.find(SalleDeProjection.class, id);
    }

    @Override
    public List<SalleDeProjection> findAll() {
        String queryText = "SELECT s FROM SalleDeProjection s";
        return entityMgr.createQuery(queryText, SalleDeProjection.class).getResultList();
    }

    @Override
    public List<SalleDeProjection> findByFilm(int filmId) {
        String queryText = "SELECT s FROM SalleDeProjection s WHERE s.film.id = :filmId";
        Query query = entityMgr.createQuery(queryText);
        query.setParameter("filmId", filmId);
        return query.getResultList();
    }

    @Override
    public SalleDeProjection getOrCreateSalleDeProjection(int salleId, int filmId) {
        // Rechercher une SalleDeProjection existante pour cette salle et ce film
        String queryText = "SELECT s FROM SalleDeProjection s WHERE s.salle.id = :salleId AND s.film.id = :filmId";
        Query query = entityMgr.createQuery(queryText);
        query.setParameter("salleId", salleId);
        query.setParameter("filmId", filmId);

        List<SalleDeProjection> result = query.getResultList();
        if (!result.isEmpty()) {
            return result.get(0); // Retourner la SalleDeProjection existante
        }

        // Si elle n'existe pas, en créer une nouvelle
        Salle salle = salleService.find(salleId);
        Film film = filmService.find(filmId);

        if (salle == null || film == null) {
            throw new IllegalArgumentException("Salle or Film not found with the provided IDs");
        }

        SalleDeProjection salleDeProjection = new SalleDeProjection();
        salleDeProjection.setSalle(salle);
        salleDeProjection.setFilm(film);
        entityMgr.persist(salleDeProjection); // Sauvegarder la nouvelle SalleDeProjection
        return salleDeProjection;
    }
    @Override
    public List<Seance> getSeancesBySalleDeProjection(int salleDeProjectionId) {
        // Vérifier si la salle de projection existe (optionnel)
        SalleDeProjection salleDeProjection = entityMgr.find(SalleDeProjection.class, salleDeProjectionId);
        if (salleDeProjection == null) {
            throw new IllegalArgumentException("SalleDeProjection not found with ID: " + salleDeProjectionId);
        }

        // Récupérer les séances associées à cette salle de projection
        String queryText = "SELECT s FROM Seance s WHERE s.salleDeProjection.id = :salleDeProjectionId";
        Query query = entityMgr.createQuery(queryText, Seance.class);
        query.setParameter("salleDeProjectionId", salleDeProjectionId);

        // Exécuter la requête et retourner les résultats
        try {
            return query.getResultList();
        } catch (Exception e) {
            // Log l'erreur et retourner une liste vide ou relancer l'exception selon le cas
            System.err.println("Error fetching seances: " + e.getMessage());
            return Collections.emptyList(); // Ou relancer l'exception
        }
    
}}