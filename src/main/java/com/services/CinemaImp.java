package com.services;

import java.util.List;

import com.entities.Cinema;
import com.entities.Film;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless
public class CinemaImp implements CinemaLocal {

    @PersistenceContext(unitName = "Cinema-ejbPU")
    private EntityManager entityMgr;

    @Override
    public void create(Cinema cinema) {
        entityMgr.persist(cinema);
    }

    @Override
    public void update(Cinema cinema) {
        entityMgr.merge(cinema);
    }

    @Override
    public void remove(Cinema cinema) {
        Cinema managedCinema = entityMgr.find(Cinema.class, cinema.getId());
        if (managedCinema != null) {
            entityMgr.remove(managedCinema);
        }
    }

   

    @Override
    public List<Cinema> findAll() {
        return entityMgr.createQuery("SELECT c FROM Cinema c", Cinema.class).getResultList();
    }

  

	@Override
	public Cinema find(int id) {
        return entityMgr.find(Cinema.class, id);

	}

	@Override
	public List<Cinema> findbyName(String name) {
		Query query = entityMgr.createQuery("SELECT c FROM Cinema c WHERE c.name = :name", Cinema.class);
        query.setParameter("name", name);
        return query.getResultList();
	}

	@Override
	
	public List<Film> getFilmsByCinemaId(int cinemaId) {
	    try {
	    	 String sql = "SELECT f.* FROM Film f " +
                     "WHERE f.id IN (SELECT fc.films_id FROM cinema_film fc WHERE fc.Cinema_id = :cinemaId)";

        Query query = entityMgr.createNativeQuery(sql, Film.class);
        query.setParameter("cinemaId", cinemaId);
	        // Retourner la liste des films associés au cinéma
	        return query.getResultList();
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}

}
