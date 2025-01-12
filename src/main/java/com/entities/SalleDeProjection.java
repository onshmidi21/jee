package com.entities;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
public class SalleDeProjection implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

  

    @ManyToOne // Activation de la suppression en cascade
    public  Film film; // Film projeté dans cette salle
    @OneToMany(mappedBy = "salle", fetch = FetchType.LAZY ,cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Seance> seances;
    @OneToOne // Activation de la suppression en cascade
    @JoinColumn(name = "salle_id") 
    public Salle salle; // Salle physique où a lieu la projection

    // Constructeurs
    public SalleDeProjection() {
        this.seances = new ArrayList<>(); // Initialisation de la liste
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
        return "SalleDeProjection [id=" + id  + ", salle=" + salle.getName() + "]";
    }



    public List<Seance> getSeances() {
        if (seances == null) {
            seances = new ArrayList<>();
        }
        return seances;
    }
}
