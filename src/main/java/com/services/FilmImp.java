package com.services;

import java.util.List;

import com.entities.Film;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless
public class FilmImp implements FilmLocal {

    @PersistenceContext(unitName = "Cinema-ejbPU")
    private EntityManager entityMgr;

    @Override
    public void create(Film film) {
        entityMgr.persist(film);
    }

    @Override
    public void update(Film film) {
        entityMgr.merge(film);
    }

    @Override
    public void remove(Film film) {
        Film managedFilm = entityMgr.find(Film.class, film.getId());
        if (managedFilm != null) {
            entityMgr.remove(managedFilm);
        }
    }

    @Override
    public Film find(int id) {
        return entityMgr.find(Film.class, id);
    }

    @Override
    public List<Film> findAll() {
        return entityMgr.createQuery("SELECT f FROM Film f", Film.class).getResultList();
    }

    @Override
    public List<Film> findByTitle(String title) {
        Query query = entityMgr.createQuery("SELECT f FROM Film f WHERE f.title = :title", Film.class);
        query.setParameter("title", title);
        return query.getResultList();
    }

    @Override
    public List<Film> findByDirector(String director) {
        Query query = entityMgr.createQuery("SELECT f FROM Film f WHERE f.director = :director", Film.class);
        query.setParameter("director", director);
        return query.getResultList();
    }

    @Override
    public List<Film> findByType(String type) {
        Query query = entityMgr.createQuery("SELECT f FROM Film f WHERE f.type = :type", Film.class);
        query.setParameter("type", type);
        return query.getResultList();
    }
    @Override
    public Film findRandomFilm() {
        try {
            // Assuming MySQL or MariaDB, use FUNCTION('RAND')
            Query query = entityMgr.createQuery("SELECT f FROM Film f ORDER BY FUNCTION('RAND')", Film.class);
            query.setMaxResults(1);  // Limit to one result

            // Fetch the result
            List<Film> films = query.getResultList();

            if (films.isEmpty()) {
                System.out.println("No films found.");
                return null;  // No films found
            }

            return films.get(0);  // Return the first random film

        } catch (Exception e) {
            e.printStackTrace();
            // Log error
            return null;
        }
    }



}
