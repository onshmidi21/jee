package com.services;

import com.entities.Seance;
import com.entities.Film;
import com.entities.SalleDeProjection;
import com.entities.Cinema;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;

@Stateless
public class SenaceImp implements SeanceLocal {

    @PersistenceContext(unitName = "Cinema-ejbPU")
    private EntityManager entityManager;
@EJB
SalleDeProjectionLocal l;
    @Override
    public void create(Seance seance) {
        if (seance == null) {
            throw new IllegalArgumentException("Seance cannot be null");
        }

        // Vérifier si la salle de projection est valide
        SalleDeProjection salleDeProjection = seance.getSalle();
        if (salleDeProjection == null) {
            throw new IllegalArgumentException("SalleDeProjection cannot be null");
        }

        // Récupérer les séances existantes pour cette salle de projection
        List<Seance> existingSeances = l.getSeancesBySalleDeProjection(salleDeProjection.getId());

        // Vérifier si une séance avec la même date et heure existe déjà
        for (Seance existingSeance : existingSeances) {
            if (existingSeance.getDate().equals(seance.getDate())) {
                throw new IllegalStateException("A seance already exists at the same date and time for this salle de projection");
            }
        }

        // Ajouter la séance à la salle de projection
        salleDeProjection.getSeances().add(seance);

        // Persister la séance
        entityManager.persist(seance);
    }

    @Override
    public void update(Seance seance) {
        entityManager.merge(seance);
    }

    @Override
    public void remove(Seance seance) {
        Seance managedSeance = entityManager.find(Seance.class, seance.getId());
        if (managedSeance != null) {
           

            // Supprimer la séance
            entityManager.remove(managedSeance);
        }
    }

    @Override
    public Seance find(int id) {
        Seance seance = entityManager.find(Seance.class, id);
        System.out.println("seance trouvée : " + seance.toString());
        return seance;
    }

    @Override
    public List<Seance> findAll() {
        return entityManager.createQuery("SELECT s FROM Seance s", Seance.class).getResultList();
    }

    @Override
    public List<Seance> findByFilm(Film film) {
        return entityManager.createQuery(
            "SELECT s FROM Seance s WHERE s.salle.film = :film", Seance.class)
            .setParameter("film", film)
            .getResultList();
    }

    @Override
    public List<Seance> findByCinema(Cinema cinema) {
        return entityManager.createQuery("SELECT s FROM Seance s WHERE s.salle.salle.cinema = :cinema", Seance.class)
                .setParameter("cinema", cinema)
                .getResultList();
    }
}