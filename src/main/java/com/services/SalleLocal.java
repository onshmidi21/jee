package com.services;

import java.util.List;

import com.entities.Salle;

import jakarta.ejb.Local;

@Local
public interface SalleLocal {

   
    void create(Salle salle);

  
    void update(Salle salle);


    void remove(Salle salle);

    Salle find(int id);

   
    List<Salle> findAll();

   

   
    List<Salle> findByCinema(int cinemaId);
}
