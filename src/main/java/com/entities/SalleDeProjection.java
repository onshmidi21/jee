package com.entities;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
public class SalleDeProjection implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

  

    @ManyToOne
    @JoinColumn(name = "film_id")
    public Film film; // Film projeté dans cette salle

    @ManyToOne
    @JoinColumn(name = "salle_id") 
    public Salle salle; // Salle physique où a lieu la projection

    // Constructeurs
    public SalleDeProjection() {}

    public SalleDeProjection( Film film, Salle salle) {
   
        this.film = film;
        this.salle = salle;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

   

    public Film getFilm() {
        return film;
    }

    public void setFilm(Film film) {
        this.film = film;
    }

    public Salle getSalle() {
        return salle;
    }

    public void setSalle(Salle salle) {
        this.salle = salle;
    }

    @Override
    public String toString() {
        return "SalleDeProjection [id=" + id +", film=" + film.getTitle() + ", salle=" + salle.getName() + "]";
    }
}
