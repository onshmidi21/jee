package com.services;

import java.util.List;

import com.entities.Salle;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless
public class SalleImp implements SalleLocal {

    @PersistenceContext(unitName = "Cinema-ejbPU")
    private EntityManager entityMgr;

    @Override
    public void create(Salle salle) {
        entityMgr.persist(salle);
    }

    @Override
    public void update(Salle salle) {
        entityMgr.merge(salle);
    }

    @Override
    public void remove(Salle salle) {
        Salle managedSalle = entityMgr.find(Salle.class, salle.getId());
        if (managedSalle != null) {
            entityMgr.remove(managedSalle);
        }
    }

    @Override
    public Salle find(int id) {
        return entityMgr.find(Salle.class, id);
    }

    @Override
    public List<Salle> findAll() {
        String queryText = "SELECT s FROM Salle s";
        return entityMgr.createQuery(queryText, Salle.class).getResultList();
    }



    @Override
    public List<Salle> findByCinema(int cinemaId) {
        String queryText = "SELECT s FROM Salle s WHERE s.cinema.id = :cinemaId";
        Query query = entityMgr.createQuery(queryText);
        query.setParameter("cinemaId", cinemaId);
        return query.getResultList();
    }
}
