package com.controlleur;

import java.io.IOException;
import java.text.Normalizer;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.services.*;
import com.entities.*;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
@WebServlet(name="Inscription",urlPatterns={"/inscrit"})

public class Inscription extends HttpServlet
{
    private static final long serialVersionUID = 1L;

    @EJB
    private UserLocal userFacade;

    public Inscription()
    {
        // TODO Auto-generated constructor stub
    }

 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // TODO Auto-generated method stub
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("utf-8");

        // Récupération des paramètres du formulaire d'inscription
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String adresse = request.getParameter("adresse");
        String login = request.getParameter("login"); // Saisie du login par l'utilisateur
        String password = request.getParameter("password"); // Saisie du mot de passe par l'utilisateur

       
        // Création de l'utilisateur avec les données saisies
        User usr = new User();
        usr.setLogin(login); // Utilisation du login disponible
        usr.setName(nom);
        usr.setFirstname(prenom);
        usr.setEmail(email);
        usr.setPassword(password); // Le mot de passe saisi
        usr.setAdress(adresse);

        // Enregistrement de l'utilisateur dans la base de données
        userFacade.create(usr);

        // Redirection vers la page d'accueil après inscription
        this.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
