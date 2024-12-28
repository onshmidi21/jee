package com.controlleur;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.services.FilmLocal;
import com.services.SeanceLocal;
import com.entities.Film;
import com.entities.Seance;
@WebServlet(name="ListFilms", urlPatterns={"/films"})
public class ListFilms extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB
    private FilmLocal filmLocal;

    public ListFilms() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupération des films
        List<Film> lfilms = null;
        try {
            lfilms = filmLocal.findAll();
            Film randomFilm = filmLocal.findRandomFilm();  // Récupérer un film aléatoire
    		request.setAttribute("randomFilm", randomFilm );



        } catch (Exception e) {
            e.printStackTrace();
            // Log de l'erreur si nécessaire
        }

        // Vérification des données récupérées
        if (lfilms != null && !lfilms.isEmpty()) {
            System.out.println("Films récupérés : " + lfilms.size());
        } else {
            System.out.println("Aucun film trouvé.");
        }

        // Ajout des films à la requête
        request.setAttribute("ListFilms", lfilms != null ? lfilms : new ArrayList<Film>());

        // Redirection vers la JSP
        request.getRequestDispatcher("/films.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
