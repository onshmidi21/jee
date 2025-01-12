package com.entities;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.sql.Time;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table
public class Film implements Serializable
{
	
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

	
	private int id;

	
	private String title;
    @OneToMany(mappedBy = "film", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<SalleDeProjection> salleDeProjection;
	 
	private String type;
	

	private String director;
	

	private String actors;

	private Time duration;
	
	private String picture;
	
	private Date date;
	
	
	private String description;
	
	public Film()
	{
	}

	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public String getTitle()
	{
		return title;
	}

	public void setTitle(String title)
	{
		this.title = title;
	}

	public String getType()
	{
		return type;
	}

	public void setType(String type)
	{
		this.type = type;
	}

	public String getDirector()
	{
		return director;
	}

	public void setDirector(String director)
	{
		this.director = director;
	}

	public String getActors()
	{
		return actors;
	}

	public void setActors(String actors)
	{
		this.actors = actors;
	}

	public Time getDuration()
	{
		return duration;
	}

	public void setDuration(Time duration)
	{
		this.duration = duration;
	}

	
	public String getPicture()
	{
		return picture;
	}

	public void setPicture(String picture)
	{
		this.picture = picture;
	}
	
	public Date getDate()
	{
		return date;
	}

	public void setDate(Date date)
	{
		this.date = date;
	}
	
	public String getDescription()
	{
		return description;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}
}
