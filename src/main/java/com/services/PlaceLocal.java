package com.services;
import java.util.List;
import com.entities.Place;

import jakarta.ejb.Local;
@Local
public interface PlaceLocal {
    List<Place> findBySeance(int seanceId);
    Place find(int id);
    void update(Place place);
}
