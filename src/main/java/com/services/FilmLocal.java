package com.services;

import java.util.List;

import com.entities.Film;

import jakarta.ejb.Local;

@Local
public interface FilmLocal {
   
    void create(Film film);

    
    void update(Film film);


    void remove(Film film);

  
    Film find(int id);

   
    List<Film> findAll();

   
    List<Film> findByTitle(String title);

    
    List<Film> findByDirector(String director);

    
    List<Film> findByType(String type);
     Film findRandomFilm();
}
