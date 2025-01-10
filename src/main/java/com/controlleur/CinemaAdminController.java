package com.controlleur;

import com.entities.Cinema;
import com.entities.Film;
import com.services.CinemaLocal;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CinemaAdminController", urlPatterns = {"/admin/cinemaAdmin"})
public class CinemaAdminController extends HttpServlet {

    @EJB
    private CinemaLocal cinemaService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listCinemas(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteCinema(request, response);
                break;
            
            default:
                listCinemas(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addCinema(request, response);
        } else if ("edit".equals(action)) {
            updateCinema(request, response);
        }
    }

    private void listCinemas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Cinema> cinemas = cinemaService.findAll();
        request.setAttribute("cinemas", cinemas); // Ajoute la liste des cinémas à la requête
        request.getRequestDispatcher("/cinemaList.jsp").forward(request, response); // Envoie la requête à la JSP
    }


    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/cinemaForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Cinema cinema = cinemaService.find(id);
        request.setAttribute("cinema", cinema);
        request.getRequestDispatcher("/cinemaForm.jsp").forward(request, response);
    }

    private void addCinema(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String address = request.getParameter("address");

        Cinema cinema = new Cinema();
        cinema.setName(name);
        cinema.setAdress(address);

        cinemaService.create(cinema);
        response.sendRedirect("cinemaAdmin?action=list");
    }

    private void updateCinema(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String address = request.getParameter("address");

        Cinema cinema = cinemaService.find(id);
        cinema.setName(name);
        cinema.setAdress(address);

        cinemaService.update(cinema);
        response.sendRedirect("cinemaAdmin?action=list");
    }

    private void deleteCinema(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Cinema cinema = cinemaService.find(id);
        cinemaService.remove(cinema);
        response.sendRedirect("cinemaAdmin?action=list");
    }

   
}