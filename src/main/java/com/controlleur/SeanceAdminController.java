package com.controlleur;

import com.entities.Seance;
import com.entities.Film;
import com.entities.Salle;
import com.entities.SalleDeProjection;
import com.services.SeanceLocal;
import com.services.FilmLocal;
import com.services.SalleDeProjectionImp;
import com.services.SalleDeProjectionLocal;
import com.services.SalleLocal;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "SeanceAdminController", urlPatterns = {"/admin/seanceAdmin"})
public class SeanceAdminController extends HttpServlet {

    @EJB
    private SeanceLocal seanceService;

    @EJB
    private SalleLocal salleService;

    @EJB
    private FilmLocal filmService;

    @EJB
    private SalleDeProjectionLocal salleDeProjectionService; // Injecter le nouveau service

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listSeances(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteSeance(request, response);
                break;
            default:
                listSeances(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addSeance(request, response);
        } else if ("edit".equals(action)) {
            updateSeance(request, response);
        }
    }

    private void listSeances(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Seance> seances = seanceService.findAll();
        List<Film> films = filmService.findAll(); // Pour le formulaire de filtrage
        request.setAttribute("seances", seances);
        request.setAttribute("films", films);
        request.getRequestDispatcher("/seanceList.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Récupérer toutes les salles
        List<Salle> salles = salleService.findAll();
        // Récupérer tous les films
        List<Film> films = filmService.findAll();

        // Passer les listes à la vue
        request.setAttribute("salles", salles);
        request.setAttribute("films", films);

        // Afficher le formulaire
        request.getRequestDispatcher("/seanceForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Seance seance = seanceService.find(id);

        // Récupérer toutes les salles
        List<Salle> salles = salleService.findAll();
        // Récupérer tous les films
        List<Film> films = filmService.findAll();

        // Passer les listes et la séance à la vue
        request.setAttribute("seance", seance);
        request.setAttribute("salles", salles);
        request.setAttribute("films", films);

        // Afficher le formulaire
        request.getRequestDispatcher("/seanceForm.jsp").forward(request, response);
    }

    private void addSeance(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int salleId = Integer.parseInt(request.getParameter("salleId"));
        int filmId = Integer.parseInt(request.getParameter("filmId")); // Récupérer l'ID du film
        String dateStr = request.getParameter("date");
        String horaireStr = request.getParameter("horaire");
        double tarif = Double.parseDouble(request.getParameter("tarif"));

        // Convertir les dates et heures
        Date date = null;
        Time horaire = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            date = dateFormat.parse(dateStr);
            horaire = Time.valueOf(horaireStr + ":00");
        } catch (ParseException e) {
            e.printStackTrace();
        }

        // Créer ou récupérer la SalleDeProjection
        SalleDeProjection salleDeProjection = salleDeProjectionService.getOrCreateSalleDeProjection(salleId, filmId);

        if (salleDeProjection != null) {
            // Créer la séance
            Seance seance = new Seance();
            seance.setSalle(salleDeProjection); // Associer la SalleDeProjection
            seance.setDate(date);
            seance.setHoraire(horaire);
            seance.setTarif(tarif);

            seanceService.create(seance);
        }

        response.sendRedirect("seanceAdmin?action=list");
    }

    private void updateSeance(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int salleId = Integer.parseInt(request.getParameter("salleId"));
        int filmId = Integer.parseInt(request.getParameter("filmId")); // Récupérer l'ID du film
        String dateStr = request.getParameter("date");
        String horaireStr = request.getParameter("horaire");
        double tarif = Double.parseDouble(request.getParameter("tarif"));

        // Convertir les dates et heures
        Date date = null;
        Time horaire = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            date = dateFormat.parse(dateStr);
            horaire = Time.valueOf(horaireStr + ":00");
        } catch (ParseException e) {
            e.printStackTrace();
        }

        // Créer ou récupérer la SalleDeProjection
        SalleDeProjection salleDeProjection = salleDeProjectionService.getOrCreateSalleDeProjection(salleId, filmId);

        if (salleDeProjection != null) {
            // Mettre à jour la séance
            Seance seance = seanceService.find(id);
            seance.setSalle(salleDeProjection); // Associer la SalleDeProjection
            seance.setDate(date);
            seance.setHoraire(horaire);
            seance.setTarif(tarif);

            seanceService.update(seance);
        }

        response.sendRedirect("seanceAdmin?action=list");
    }

    private void deleteSeance(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Seance seance = seanceService.find(id);
        seanceService.remove(seance);
        response.sendRedirect("seanceAdmin?action=list");
    }
}