package com.services;
import com.entities.Admin;

import jakarta.ejb.Local;
import jakarta.ejb.Singleton;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
@Singleton
public class LoginAdminService {
    @PersistenceContext(unitName = "Cinema-ejbPU")

	private EntityManager entityManager;

    public Admin authenticate(String login, String password) {
        TypedQuery<Admin> query = entityManager.createQuery(
            "SELECT a FROM Admin a WHERE a.login = :login AND a.password = :password", Admin.class);
        query.setParameter("login", login);
        query.setParameter("password", password); 

        try {
            return query.getSingleResult();
        } catch (Exception e) {
            return null; 
        }
    }
}


