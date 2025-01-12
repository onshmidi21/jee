package com.services;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.ArrayList;
import java.util.List;

import com.entities.*;
import com.entities.Place.Status;

@Stateless
public class PlaceImp implements PlaceLocal {

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<Place> findBySeance(int seanceId) {
        // Récupérer la séance et la salle associée
        Seance seance = em.find(Seance.class, seanceId);
        Salle salle = seance.salle.salle;  // Salle associée à la séance

        // Vérifier si les places existent déjà
        List<Place> places = salle.places;
        if (places == null || places.isEmpty()) {
            // Si aucune place n'existe, on génère les places en fonction de la capacité de la salle
            generatePlaces(salle);
            places = salle.places;
        }

        return places;
    }

    public void generatePlaces(Salle salle) {
        int capacite = salle.getCapacite();
        int columns = 10; // Par exemple, 10 colonnes par rangée
        int rows = (int) Math.ceil((double) capacite / columns); // Calcul du nombre de rangées

        // Vider la collection existante de places
        salle.getPlaces().clear();

        // Création des places
        for (int row = 1; row <= rows; row++) {
            for (int col = 1; col <= columns; col++) {
                // Si la capacité est dépassée, on arrête de créer des places
                if (salle.getPlaces().size() >= capacite) {
                    break;
                }

                Place place = new Place();
                place.setRow(row); // Numéro de la rangée
                place.setCol(col); // Numéro de la colonne
                place.setStatus(Status.DISPONIBLE); // Statut initial
                place.setSeance(salle); // Association avec la salle (relation bidirectionnelle)

                em.persist(place); // Persister la place dans la base de données
                salle.getPlaces().add(place); // Ajouter la place à la liste existante
            }
        }

        // Pas besoin de salle.setPlaces(places) car la collection a été modifiée directement
    }

    @Override
    public Place find(int id) {
    	Place place = em.find(Place.class, id);
        System.out.println("Place trouvé : " + place);
        return place;
        		
    }

    @Override
    public void update(Place place) {
        em.merge(place);  // Mise à jour de l'entité
    }
}
