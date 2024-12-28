package com.services;

import com.entities.Seance;
import com.entities.Film;
import com.entities.Cinema;
import jakarta.ejb.Local;
import java.util.List;

@Local
public interface SeanceLocal {

    void create(Seance seance);

    void update(Seance seance);

    void remove(Seance seance);

    Seance find(int id);

    List<Seance> findAll();

    List<Seance> findByFilm(Film film);

    List<Seance> findByCinema(Cinema cinema);

}
