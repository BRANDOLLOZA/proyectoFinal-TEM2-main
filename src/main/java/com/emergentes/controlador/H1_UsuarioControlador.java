package com.emergentes.controlador;

import com.emergentes.dao.RolDAO;
import com.emergentes.dao.RolDAOimpl;
import com.emergentes.dao.UsuarioDAO;
import com.emergentes.dao.UsuarioDAOimpl;
import com.emergentes.modelo.Rol;
import com.emergentes.modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "H1_UsuarioControlador", urlPatterns = {"/H1_UsuarioControlador"})
public class H1_UsuarioControlador extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UsuarioDAO dao = new UsuarioDAOimpl();
            RolDAO daoRol = new RolDAOimpl();
            int id;
            List<Rol> lista_roles = null;
            Usuario usuario = new Usuario();
            
            String action = (request.getParameter("action") != null) ? request.getParameter("action") : "view";
            
            switch (action) {
                case "add":
                    lista_roles = daoRol.getAll();
                    request.setAttribute("lista_roles", lista_roles);
                    request.setAttribute("usuario", usuario);
                    request.getRequestDispatcher("frm_usuario.jsp").forward(request, response);
                    break;
                case "edit":
                    id = Integer.parseInt(request.getParameter("idusuario"));
                    usuario = dao.getById(id);
                    
                    lista_roles = daoRol.getAll();
                    request.setAttribute("lista_roles", lista_roles);
                    // Colocar como atributo
                    request.setAttribute("usuario", usuario);
                    // Transferir el control a frmventa.jsp
                    request.getRequestDispatcher("frm_usuario.jsp").forward(request, response);
                    break;
                case "delete":
                    id = Integer.parseInt(request.getParameter("idusuario"));
                    
                    dao.delete(id);
                    
                    response.sendRedirect("H1_UsuarioControlador");
                    break;
                case "view":
                    //Obtener la lista de registros
                    List<Usuario> lista = dao.getAll();
                    request.setAttribute("usuarios", lista);
                    request.getRequestDispatcher("h1_usuarios.jsp").forward(request, response);
                    break;
                default:
                    break;
            }
        } catch (Exception ex) {
            System.out.println("Error Fatal" + ex.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("idusuario"));
        String nombre = request.getParameter("nombre");
        String ci_documento = request.getParameter("ci_documento");
        String email = request.getParameter("email");
        String cargo = request.getParameter("cargo");
        String login = request.getParameter("login");
        String clave = request.getParameter("clave");
        int condicion = 1;
        int rol_id = Integer.parseInt(request.getParameter("idrol"));
        Usuario usuario = new Usuario();
        usuario.setIdusuario(id);
        usuario.setNombre(nombre);
        usuario.setCi_documento(ci_documento);
        usuario.setCargo(cargo);
        usuario.setEmail(email);
        usuario.setLogin(login);
        usuario.setClave(clave);
        usuario.setCondicion(condicion);
        usuario.setIdrol(rol_id);
        if (id == 0) {
            //Nuevo
            UsuarioDAO dao = new UsuarioDAOimpl();
            try {
                // Nuevo registro
                dao.insert(usuario);
                response.sendRedirect("H1_UsuarioControlador");
            } catch (Exception ex) {
                System.out.println("Error al insertar " + ex.getMessage());
            }
        } else {
            //Editar
            UsuarioDAO dao = new UsuarioDAOimpl();
            try {
                dao.update(usuario);
                response.sendRedirect("H1_UsuarioControlador");
            } catch (Exception ex) {
                System.out.println("Error al editar" + ex.getMessage());
            }
        }
        
    }
    
}
