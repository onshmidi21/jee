package com.entities;

import java.io.Serializable;
import java.sql.Time;
import java.util.List;
import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "seances")
public class Seance implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private Date date;

    private Time horaire;
    private double tarif ;
    @ManyToOne
    @JoinColumn(name = "salle_de_projection_id") 
    public  SalleDeProjection salle ;
    
    public SalleDeProjection getSalle() {
        return salle;
    }

 


    // Constructeurs, getters et setters
    public Seance() {}

    public Seance(Date date, Time horaire, SalleDeProjection salle,List<Place> places) {
        this.date = date;
        this.horaire = horaire;
     this.salle= salle ;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Time getHoraire() {
        return horaire;
    }

    public void setHoraire(Time horaire) {
        this.horaire = horaire;
    }




	public double getTarif() {
		return tarif;
	}




	public void setTarif(double tarif) {
		this.tarif = tarif;
	}

    

 



   


}
