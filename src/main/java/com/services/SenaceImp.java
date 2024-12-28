package com.services;
import com.entities.Seance;
import com.entities.Film;
import com.entities.Cinema;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;
@Stateless

public class SenaceImp implements SeanceLocal {

    @PersistenceContext
    private EntityManager entityManager;  // Pour interagir avec la base de données

    // Créer une nouvelle séance
    @Override
    public void create(Seance seance) {
        entityManager.persist(seance);
    }

    // Mettre à jour une séance existante
    @Override
    public void update(Seance seance) {
        entityManager.merge(seance);
    }

    // Supprimer une séance
    @Override
    public void remove(Seance seance) {
        entityManager.remove(entityManager.merge(seance));
    }

    // Trouver une séance par son ID
    @Override
    public Seance find(int id) {
        return entityManager.find(Seance.class, id);
    }

    // Trouver toutes les séances
    @Override
    public List<Seance> findAll() {
        return entityManager.createQuery("SELECT s FROM Seance s", Seance.class).getResultList();
    }

    // Trouver les séances par film
    @Override
    public List<Seance> findByFilm(Film film) {
        return entityManager.createQuery(
            "SELECT s FROM Seance s WHERE s.salle.film = :film", Seance.class)
            .setParameter("film", film)
            .getResultList();
    }

    // Trouver les séances par cinéma
    @Override
    public List<Seance> findByCinema(Cinema cinema) {
        return entityManager.createQuery("SELECT s FROM Seance s WHERE s.salle.salle.cinema = :cinema", Seance.class)
                .setParameter("cinema", cinema)
                .getResultList();
    }

    
} 


