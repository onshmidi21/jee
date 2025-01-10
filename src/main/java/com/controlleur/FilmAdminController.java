package com.controlleur;

import com.entities.Film;
import com.entities.SalleDeProjection;
import com.services.FilmLocal;
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

@WebServlet(name = "FilmAdminController", urlPatterns = {"/admin/filmAdmin"})
public class FilmAdminController extends HttpServlet {

    @EJB
    private FilmLocal filmService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listFilms(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteFilm(request, response);
                break;
            
            default:
                listFilms(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addFilm(request, response);
        } else if ("edit".equals(action)) {
            updateFilm(request, response);
        }
    }

    private void listFilms(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Film> films = filmService.findAll();
        request.setAttribute("films", films);
        request.getRequestDispatcher("/filmList.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/filmForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Film film = filmService.find(id);
        request.setAttribute("film", film);
        request.getRequestDispatcher("/filmForm.jsp").forward(request, response);
    }

    private void addFilm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String director = request.getParameter("director");
        String type = request.getParameter("type");
        String actors = request.getParameter("actors");
        String durationStr = request.getParameter("duration");
        String picture = request.getParameter("picture");
        String dateStr = request.getParameter("date");
        String description = request.getParameter("description");

        // Convertir la durée en Time
        Time duration = Time.valueOf(durationStr + ":00");

        // Convertir la date en Date
        Date date = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            date = dateFormat.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Film film = new Film();
        film.setTitle(title);
        film.setDirector(director);
        film.setType(type);
        film.setActors(actors);
        film.setDuration(duration);
        film.setPicture(picture);
        film.setDate(date);
        film.setDescription(description);

        filmService.create(film);
        response.sendRedirect("filmAdmin?action=list");
    }

    private void updateFilm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String director = request.getParameter("director");
        String type = request.getParameter("type");
        String actors = request.getParameter("actors");
        String durationStr = request.getParameter("duration");
        String picture = request.getParameter("picture");
        String dateStr = request.getParameter("date");
        String description = request.getParameter("description");

        // Convertir la durée en Time
        Time duration = Time.valueOf(durationStr + ":00");

        // Convertir la date en Date
        Date date = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            date = dateFormat.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Film film = filmService.find(id);
        film.setTitle(title);
        film.setDirector(director);
        film.setType(type);
        film.setActors(actors);
        film.setDuration(duration);
        film.setPicture(picture);
        film.setDate(date);
        film.setDescription(description);

        filmService.update(film);
        response.sendRedirect("filmAdmin?action=list");
    }

    private void deleteFilm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Film film = filmService.find(id);
        filmService.remove(film);
        response.sendRedirect("filmAdmin?action=list");
    }

  
}