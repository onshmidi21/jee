package com.entities;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
public class SalleDeProjection implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

  

    @ManyToOne
    public  Film film; // Film projeté dans cette salle
    @OneToMany(mappedBy = "salle")
    private List<Seance> seances;
    @OneToOne
    @JoinColumn(name = "salle_id") 
    public Salle salle; // Salle physique où a lieu la projection

    // Constructeurs
    public SalleDeProjection() {}

 

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
        return "SalleDeProjection [id=" + id  + ", salle=" + salle.getName() + "]";
    }
}
