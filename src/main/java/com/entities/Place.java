package com.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "places")
public class Place {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_place")
    private int idPlace;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_salle")
    private Salle salle;

    @Column(name = "row_position", nullable = false)  // Renommé en row_number
    private int row;  // Numéro de rangée

    @Column(name = "col", nullable = false)
    private int col;  // Numéro de colonne

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private Status status;  // Statut de la place (DISPONIBLE, OCCUPEE)

    // Getters et setters

    public int getIdPlace() {
        return idPlace;
    }

    public void setIdPlace(int idPlace) {
        this.idPlace = idPlace;
    }

    public Salle getSeance() {
        return salle;
    }

    public void setSeance(Salle salle) {
        this.salle = salle;
    }

    public int getRow() {
        return row;
    }

    public void setRow(int row) {
        this.row = row;
    }

    public int getCol() {
        return col;
    }

    public void setCol(int col) {
        this.col = col;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public enum Status {
        DISPONIBLE, OCCUPEE, EN_COURS,
    }
}
