
package com.emergentes.controlador;

import com.emergentes.dao.ventaAuditoriaDAOimpl;
import com.emergentes.modelo.IngresoAuditoria;
import com.emergentes.modelo.VentaAuditoria;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AuditoriaControlador", urlPatterns = {"/AuditoriaControlador"})
public class AuditoriaControlador extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            //Permite evaluar el prametro
            String action = (request.getParameter("action") != null) ? request.getParameter("action") : "view";
            ventaAuditoriaDAOimpl dao = new ventaAuditoriaDAOimpl();
            int id;
            switch (action) {
                case "view2":
                    //obtener la lista de objetos (registros)
                    List<IngresoAuditoria> lista1 = dao.getAllAuditoriaIngreso();
                    //Ponerlo como atributo de lista
                    request.setAttribute("AuditoriasCompras", lista1);
                    //Pasamos el control
                    request.getRequestDispatcher("compraAuditoria.jsp").forward(request, response);
                    break;
                case "view1":
                    //obtener la lista de objetos (registros)
                    List<VentaAuditoria> lista = dao.getAllAuditoriaVentas();
                    //Ponerlo como atributo de lista
                    request.setAttribute("Auditorias", lista);
                    //Pasamos el control
                    request.getRequestDispatcher("ventaAuditoria.jsp").forward(request, response);
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

    }

}
