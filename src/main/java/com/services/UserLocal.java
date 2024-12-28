package com.services;

import java.util.List;

import com.entities.User;

import jakarta.ejb.Local;

@Local
public interface UserLocal {
 
    void create(User user);

  
    void update(User user);

  
    void remove(User user);

 
    User find(int id);


    List<User> findAll();

    User findByLogin(String login);

  
    boolean authenticate(String login, String password);
}
