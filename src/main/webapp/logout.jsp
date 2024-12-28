<%@ page session="true" %>
<%
    session.invalidate(); // Invalider la session
    response.sendRedirect("login.jsp"); // Rediriger vers la page de login
%>
