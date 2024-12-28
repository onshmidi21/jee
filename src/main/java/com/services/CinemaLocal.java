package com.services;

import java.util.List;

import com.entities.Cinema;
import com.entities.Film;

import jakarta.ejb.Local;

@Local
public interface CinemaLocal {
	void create(Cinema cinema);
	void update(Cinema cinema);
	void remove(Cinema cinema);

	Cinema find(int id);
	List<Cinema> findbyName(String name);
	List<Cinema> findAll();
	 public List<Film> getFilmsByCinemaId(int cinemaId) ;
}
