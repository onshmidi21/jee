package com.services;

import java.util.List;

import com.entities.Compte;
import com.entities.User;

import jakarta.ejb.Local;

@Local
public interface CompteLocal {
  
    void create(Compte compte);

   
    void update(Compte compte);

 
    void remove(Compte compte);

   
    Compte find(int id);

   
    List<Compte> findAll();

   
    Compte findByUser(User user);

}
