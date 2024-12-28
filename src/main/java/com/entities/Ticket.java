package com.entities;

import java.io.Serializable;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "tickets")
public class Ticket implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    
    @OneToOne
    @JoinColumn(name = "place_id")
    private Place Place;

    
    @ManyToOne
    @JoinColumn(name = "seance_id")
	public Seance seance;

    @OneToOne
	public Place place;

   

   

    // Constructeur par défaut
    public Ticket() {}

   

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

  

    public Seance getSeance() {
        return seance;
    }

    public void setSeance(Seance seance) {
        this.seance = seance;
    }

   

   

  

    @Override
    public String toString() {
        return "Ticket [id=" + id + ","  + 
               ", seanceId=" + seance.getId() + ", "+ 
               ","  +"]";
    }

	public void setPlace(Place place2) {
this.place=place2;		
	}
}
