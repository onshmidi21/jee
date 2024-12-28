package com.services;

import java.util.List;

import com.entities.Compte;
import com.entities.User;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless
public class CompteImp implements CompteLocal {

    @PersistenceContext(unitName = "Cinema-ejbPU")
    private EntityManager entityMgr;

    @Override
    public void create(Compte compte) {
        entityMgr.persist(compte);
    }

    @Override
    public void update(Compte compte) {
        entityMgr.merge(compte);
    }

    @Override
    public void remove(Compte compte) {
        Compte managedCompte = entityMgr.find(Compte.class, compte.getId());
        if (managedCompte != null) {
            entityMgr.remove(managedCompte);
        }
    }

    @Override
    public Compte find(int id) {
        return entityMgr.find(Compte.class, id);
    }

    @Override
    public List<Compte> findAll() {
        String queryText = "SELECT c FROM Compte c";
        return entityMgr.createQuery(queryText, Compte.class).getResultList();
    }

    @Override
    public Compte findByUser(User user) {
        if (user == null) {
            throw new IllegalArgumentException("User cannot be null");
        }
        int userId = user.getId();
        String queryText = "SELECT c FROM Compte c WHERE c.user.id = :userId";
        Query query = entityMgr.createQuery(queryText);
        query.setParameter("userId", userId);
        try {
            return (Compte) query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }


  
}
