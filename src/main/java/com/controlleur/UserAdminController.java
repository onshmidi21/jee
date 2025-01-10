package com.controlleur;

import com.entities.User;
import com.services.UserLocal;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserAdminController", urlPatterns = {"/admin/userAdmin"})
public class UserAdminController extends HttpServlet {

    @EJB
    private UserLocal userService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listUsers(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            default:
                listUsers(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addUser(request, response);
        } else if ("edit".equals(action)) {
            updateUser(request, response);
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = userService.findAll();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/userList.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/userForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userService.find(id);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/userForm.jsp").forward(request, response);
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String firstname = request.getParameter("firstname");
        String email = request.getParameter("email");
        String adress = request.getParameter("adress");

        User user = new User();
        user.setLogin(login);
        user.setPassword(password);
        user.setName(name);
        user.setFirstname(firstname);
        user.setEmail(email);
        user.setAdress(adress);

        userService.create(user);
        response.sendRedirect("userAdmin?action=list");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String firstname = request.getParameter("firstname");
        String email = request.getParameter("email");
        String adress = request.getParameter("adress");

        User user = userService.find(id);
        user.setLogin(login);
        user.setPassword(password);
        user.setName(name);
        user.setFirstname(firstname);
        user.setEmail(email);
        user.setAdress(adress);

        userService.update(user);
        response.sendRedirect("userAdmin?action=list");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userService.find(id);
        userService.remove(user);
        response.sendRedirect("userAdmin?action=list");
    }
}