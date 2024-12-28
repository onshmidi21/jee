package com.controlleur;

import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.services.FilmLocal;
import com.entities.Film;

@WebServlet(name="RandomFilmServlet", urlPatterns={"/randomFilm"})
public class RondomFilmServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB
    private FilmLocal filmLocal;  // Inject FilmLocal service

    public RondomFilmServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Film randomFilm = null;
        
        try {
            // Call the service method to get a random film
            randomFilm = filmLocal.findRandomFilm();
            
            // Check if a random film is retrieved
            if (randomFilm == null) {
                System.out.println("No random film found.");
            }

            // Set the random film as a request attribute
            request.setAttribute("randomFilm", randomFilm);

            // Forward the request to the JSP page
            request.getRequestDispatcher("/filmRandom.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving random film.");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);  // Delegate POST request to doGet
    }
}
