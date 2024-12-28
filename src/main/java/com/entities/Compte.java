package com.entities;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
@Entity  
@Table(name="COMPTES") 
public class Compte implements Serializable {  
    @Id @GeneratedValue(strategy = GenerationType.AUTO)  
private int id;  
@OneToOne
private User user ;  
private float solde;  
private String password;
public Compte() {  
  super();  
}  
public int getId() {  
  return this.id;  
}  
public void setId(int id) {  
  this.id = id;  
}  

 
public float getSolde() {  
  return this.solde;  
}  
public void setSolde(double d) {  
  this.solde = (float) d;  
}  
             public String toString() {  
  StringBuilder sb = new StringBuilder();  
  sb.append("Compte[id=").append(getId()).append(", name=").  
  append(user.getName()).append("]");  
 return sb.toString();  
}
			public User getUser() {
				return user;
			}
			public void setUser(User user) {
				this.user = user;
			}
			public String getPassword() {
				return password;
			}
			public void setPassword(String password) {
				this.password = password;
			}  }