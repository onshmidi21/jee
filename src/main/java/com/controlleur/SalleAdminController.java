package com.controlleur;

import com.entities.Salle;
import com.entities.Cinema;
import com.services.SalleLocal;
import com.services.CinemaLocal;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SalleAdminController", urlPatterns = {"/admin/salleAdmin"})
public class SalleAdminController extends HttpServlet {

    @EJB
    private SalleLocal salleService;

    @EJB
    private CinemaLocal cinemaService; // Service pour gérer les cinémas

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listSalles(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteSalle(request, response);
                break;
            default:
                listSalles(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addSalle(request, response);
        } else if ("edit".equals(action)) {
            updateSalle(request, response);
        }
    }

    private void listSalles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Salle> salles = salleService.findAll();
        request.setAttribute("salles", salles);
        request.getRequestDispatcher("/salleList.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Cinema> cinemas = cinemaService.findAll(); // Récupérer la liste des cinémas disponibles
        request.setAttribute("cinemas", cinemas);
        request.getRequestDispatcher("/salleForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Salle salle = salleService.find(id);
        List<Cinema> cinemas = cinemaService.findAll(); // Récupérer la liste des cinémas disponibles
        request.setAttribute("salle", salle);
        request.setAttribute("cinemas", cinemas);
        request.getRequestDispatcher("/salleForm.jsp").forward(request, response);
    }

    private void addSalle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nom = request.getParameter("nom");
        int capacite = Integer.parseInt(request.getParameter("capacite"));
        int cinemaId = Integer.parseInt(request.getParameter("cinemaId")); // Récupérer l'ID du cinéma

        Salle salle = new Salle();
        salle.setName(nom);
        salle.setCapacite(capacite);

        Cinema cinema = cinemaService.find(cinemaId); // Trouver le cinéma
        salle.setCinema(cinema); // Associer le cinéma à la salle

        salleService.create(salle);
        response.sendRedirect("salleAdmin?action=list");
    }

    private void updateSalle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        int capacite = Integer.parseInt(request.getParameter("capacite"));
        int cinemaId = Integer.parseInt(request.getParameter("cinemaId")); // Récupérer l'ID du cinéma

        Salle salle = salleService.find(id);
        salle.setName(nom);
        salle.setCapacite(capacite);

        Cinema cinema = cinemaService.find(cinemaId); // Trouver le cinéma
        salle.setCinema(cinema); // Associer le cinéma à la salle

        salleService.update(salle);
        response.sendRedirect("salleAdmin?action=list");
    }

    private void deleteSalle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Salle salle = salleService.find(id);
        salleService.remove(salle);
        response.sendRedirect("salleAdmin?action=list");
    }
}