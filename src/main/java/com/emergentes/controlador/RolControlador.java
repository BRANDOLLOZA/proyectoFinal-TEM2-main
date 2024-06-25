package com.emergentes.controlador;

import com.emergentes.dao.RolDAO;
import com.emergentes.dao.RolDAOimpl;
import com.emergentes.modelo.Rol;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RolControlador", urlPatterns = {"/RolControlador"})
public class RolControlador extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            //Permite evaluar el prametro
            String action = (request.getParameter("action") != null) ? request.getParameter("action") : "view";
            RolDAO dao = new RolDAOimpl();
            Rol ro = new Rol();
            int id;
            switch (action) {
                case "add":
                    request.setAttribute("rol", ro);
                    request.getRequestDispatcher("frm_rol.jsp").forward(request, response);
                    break;
                case "edit":
                    id = Integer.parseInt(request.getParameter("idrol"));
                    ro = dao.getById(id);
                    request.setAttribute("rol", ro);
                    request.getRequestDispatcher("frm_rol.jsp").forward(request, response);
                    break;
                case "delete":
                    id = Integer.parseInt(request.getParameter("idrol"));
                    dao.delete(id);
                    response.sendRedirect("RolControlador");
                    break;
                case "view":
                    //obtener la lista de objetos (registros)
                    List<Rol> lista = dao.getAll();
                    //Ponerlo como atributo de lista
                    request.setAttribute("roles", lista);
                    //Pasamos el control
                    request.getRequestDispatcher("v_roles.jsp").forward(request, response);
                    break;
                default:

                    break;
            }
        } catch (Exception e) {
            System.out.println("Error :" + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idrol = Integer.parseInt(request.getParameter("idrol"));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        Rol rol = new Rol();
        rol.setIdrol(idrol);
        rol.setNombre(nombre);
        rol.setDescripcion(descripcion);
        RolDAO dao = new RolDAOimpl();
        if (idrol == 0) {
            try {
                // Nuevo registro
                dao.insert(rol);
            } catch (Exception ex) {
                System.out.println("Error al insertar " + ex.getMessage());
            }
        } else {
            try {
                // Edicion de registro
                dao.update(rol);
            } catch (Exception ex) {
                System.out.println("Error al editar " + ex.getMessage());
            }
        }
        response.sendRedirect("RolControlador");
    }
}
