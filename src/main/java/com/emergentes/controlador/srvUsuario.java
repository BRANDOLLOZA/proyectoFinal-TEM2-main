package com.emergentes.controlador;

import com.emergentes.modelo.Usuario;
import com.emergentes.utiles.usuarioLogin;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "srvUsuario", urlPatterns = {"/srvUsuario"})
public class srvUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String accion = request.getParameter("accion");
        try {
            if (accion != null) {
                switch (accion) {
                    case "verificar":
                        verificar(request, response);
                        break;
                    case "cerrar":
                        cerrarsesion(request, response);
                    default:
                        response.sendRedirect("login.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
            }

        } catch (Exception e) {
            try {
                System.out.println("Error 1" + e.getMessage());
                //this.getServletConfig().getServletContext().getRequestDispatcher("/mensaje.jsp").forward(request, response);
            } catch (Exception ex) {
                System.out.println("Error" + ex.getMessage());
            }
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void cerrarsesion(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        session.setAttribute("usuario", null);
        session.invalidate();
        response.sendRedirect("login.jsp");
    }

    private void verificar(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession sesion;
        usuarioLogin dao;
        Usuario usuario;
        usuario = this.obtenerUsuario(request);
        dao = new usuarioLogin();
        usuario = dao.ideentificar(usuario);
        if (usuario != null && usuario.getRolC().getNombre().equals("Administrador")) {
            sesion = request.getSession();
            sesion.setAttribute("usuario", usuario);
            request.setAttribute("msje", "Bienvenido al sistema");
            System.out.println("usuario es y contraseña correcto");
            //this.getServletConfig().getServletContext().getRequestDispatcher("A0_IndexControlador").forward(request, response);
            response.sendRedirect("A0_IndexControlador");
        } else if (usuario != null && usuario.getRolC().getNombre().equals("Vendedor")) {
            sesion = request.getSession();
            sesion.setAttribute("usuario", usuario);
            //request.setAttribute("msje", "Bienvenido al sistema");
            response.sendRedirect("A0_IndexControlador");
            //this.getServletConfig().getServletContext().getRequestDispatcher("indexVendedor.jsp").forward(request, response);
        } else if (usuario != null && usuario.getRolC().getNombre().equals("Empleado")) {
            sesion = request.getSession();
            sesion.setAttribute("usuario", usuario);
            //request.setAttribute("msje", "Bienvenido al sistema");
            response.sendRedirect("A0_IndexControlador");
            //this.getServletConfig().getServletContext().getRequestDispatcher("indexVendedor.jsp").forward(request, response);
        } else if (usuario != null && usuario.getRolC().getNombre().equals("Tecnico")) {
            sesion = request.getSession();
            sesion.setAttribute("usuario", usuario);
            //request.setAttribute("msje", "Bienvenido al sistema");
            response.sendRedirect("A0_IndexControlador");
            //this.getServletConfig().getServletContext().getRequestDispatcher("indexVendedor.jsp").forward(request, response);
        } else {
            //System.out.println("usuario es y contraseña es incorrecta");
            request.setAttribute("msje", "Usuario y contraseña es  incorrecta");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

    }

    private Usuario obtenerUsuario(HttpServletRequest request) {
        Usuario u = new Usuario();
        u.setLogin(request.getParameter("login"));
        u.setClave(request.getParameter("clave"));
        return u;
    }

}
