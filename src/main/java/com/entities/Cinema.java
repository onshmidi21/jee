package com.entities;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table
public class Cinema implements Serializable
{
	
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

	private int id;

	private String name;
	
	private String adress;
	@OneToMany
    private List<Salle> salles;
	   @ManyToMany
	    @JoinTable(
	        name = "cinema_film"
	       
	    )
    private List<Film> films;
	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getAdress()
	{
		return adress;
	}

	public void setAdress(String adress)
	{
		this.adress = adress;
	}

	public List<Film> getFilms() {
		return films;
	}	 
}