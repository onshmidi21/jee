package com.entities;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;

@Entity
public class Salle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    private String name;
    private int capacite;
    @OneToMany(mappedBy = "salle", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    public List<Place> places; 
@ManyToOne
public Cinema cinema ;
    // Constructeur par défaut
    public Salle() {}

    // Constructeur avec paramètres
    public Salle(String name, String adress, int capacite) {
        this.name = name;
        this.capacite = capacite;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

   

   

    public int getCapacite() {
        return capacite;
    }

    public void setCapacite(int capacite) {
        this.capacite = capacite;
    }

    @Override
    public String toString() {
        return "Salle [id=" + id + ", name=" + name + ", " + ", capacite=" + capacite + "]";
    }

	public void setPlaces(List<Place> places2) {
this.places=places2;		
	}
}
