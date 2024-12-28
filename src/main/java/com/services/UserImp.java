package com.services;

import java.util.List;

import com.entities.User;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless
public class UserImp implements UserLocal {

    @PersistenceContext(unitName = "Cinema-ejbPU")
    private EntityManager entityMgr;

    @Override
    public void create(User user) {
        entityMgr.persist(user);
    }

    @Override
    public void update(User user) {
        entityMgr.merge(user);
    }

    @Override
    public void remove(User user) {
        User managedUser = entityMgr.find(User.class, user.getId());
        if (managedUser != null) {
            entityMgr.remove(managedUser);
        }
    }

    @Override
    public User find(int id) {
        return entityMgr.find(User.class, id);
    }

    @Override
    public List<User> findAll() {
        String queryText = "SELECT u FROM User u";
        return entityMgr.createQuery(queryText, User.class).getResultList();
    }

    @Override
    public User findByLogin(String login) {
        String queryText = "SELECT u FROM User u WHERE u.login = :login";
        Query query = entityMgr.createQuery(queryText);
        query.setParameter("login", login);
        List<User> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    }

    @Override
    public boolean authenticate(String login, String password) {
        User user = findByLogin(login);
        return user != null && user.getPassword().equals(password);
    }
}
