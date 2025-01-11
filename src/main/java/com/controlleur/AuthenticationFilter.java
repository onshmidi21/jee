package com.controlleur;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/protected/*") // Appliquer ce filtre à toutes les pages protégées
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if (isLoggedIn) {
            // L'utilisateur est connecté, continuer vers la page demandée
            System.out.println("Utilisateur connecté. Accès autorisé à : " + httpRequest.getRequestURI());
            chain.doFilter(request, response);
        } else {
            // L'utilisateur n'est pas connecté, stocker l'URL demandée et rediriger vers la page de login
            String requestedPage = httpRequest.getRequestURI();
            session = httpRequest.getSession();
            session.setAttribute("redirectAfterLogin", requestedPage);

            System.out.println("URL demandée : " + requestedPage);
            System.out.println("Utilisateur non connecté. Redirection vers /login.");

            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation du filtre (si nécessaire)
    }

    @Override
    public void destroy() {
        // Nettoyage du filtre (si nécessaire)
    }
}