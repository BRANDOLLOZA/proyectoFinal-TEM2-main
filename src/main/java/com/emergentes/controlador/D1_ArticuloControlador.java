package com.emergentes.controlador;

import com.emergentes.dao.ArticuloDAO;
import com.emergentes.dao.ArticuloDAOimpl;
import com.emergentes.dao.CategoriaDAO;
import com.emergentes.dao.CategoriaDAOimpl;
import com.emergentes.modelo.Articulo;
import com.emergentes.modelo.Categoria;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "D1_ArticuloControlador", urlPatterns = {"/D1_ArticuloControlador"})
public class D1_ArticuloControlador extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ArticuloDAO dao = new ArticuloDAOimpl();
            CategoriaDAO daoCat = new CategoriaDAOimpl();
            int id;
            List<Categoria> lista_categorias = null;
            Articulo articulo = new Articulo();
            String action = (request.getParameter("action") != null) ? request.getParameter("action") : "view";
            switch (action) {
                case "add":
                    lista_categorias = daoCat.getAll();
                    request.setAttribute("lista_categorias", lista_categorias);
                    request.setAttribute("articulo", articulo);
                    request.getRequestDispatcher("frm_articulo.jsp").forward(request, response);
                    break;
                case "edit":
                    id = Integer.parseInt(request.getParameter("idarticulo"));
                    articulo = dao.getById(id);
                    lista_categorias = daoCat.getAll();
                    request.setAttribute("lista_categorias", lista_categorias);
                    // Colocar como atributo
                    request.setAttribute("articulo", articulo);
                    // Transferir el control a frmventa.jsp
                    request.getRequestDispatcher("frm_articulo.jsp").forward(request, response);
                    break;
                case "delete":
                    id = Integer.parseInt(request.getParameter("idarticulo"));
                    dao.delete(id);
                    response.sendRedirect("D1_ArticuloControlador");
                    break;
                case "repArticulo":
                    generarReporteArticulo(response);
                    break;
                case "view":
                    //Obtener la lista de registros
                    List<Articulo> lista = dao.getAll();
                    request.setAttribute("articulos", lista);
                    request.getRequestDispatcher("d1_articulos.jsp").forward(request, response);
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
        int id = Integer.parseInt(request.getParameter("idarticulo"));
        String codigo = request.getParameter("codigo");
        String nombre = request.getParameter("nombre");
        int stock = Integer.parseInt(request.getParameter("stock"));
        String descripcion = request.getParameter("descripcion");
        String imagen = "";
        int condicion = 1;
        int idcategoria = Integer.parseInt(request.getParameter("idcategoria"));
        Articulo articulo = new Articulo();
        articulo.setIdarticulo(id);
        articulo.setCodigo(codigo);
        articulo.setNombre(nombre);
        articulo.setStock(stock);
        articulo.setDescripcion(descripcion);
        articulo.setImagen(imagen);
        articulo.setCondicion(condicion);
        articulo.setIdcategoria(idcategoria);
        if (id == 0) {
            //Nuevo
            ArticuloDAO dao = new ArticuloDAOimpl();
            try {
                // Nuevo registro
                dao.insert(articulo);
                response.sendRedirect("D1_ArticuloControlador");
            } catch (Exception ex) {
                System.out.println("Error al insertar " + ex.getMessage());
            }
        } else {
            //Editar
            ArticuloDAO dao = new ArticuloDAOimpl();
            try {
                dao.update(articulo);
                response.sendRedirect("D1_ArticuloControlador");
            } catch (Exception ex) {
                System.out.println("Error al editar" + ex.getMessage());
            }
        }
    }

    private void generarReporteArticulo(HttpServletResponse response) throws Exception {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=reporte_empresa.pdf");

        OutputStream out = response.getOutputStream();
// Configurar los márgenes del documento (en puntos)
        float marginLeft = 36; // Márgen izquierdo en puntos
        float marginRight = 36; // Márgen derecho en puntos
        float marginTop = 72; // Márgen superior en puntos
        float marginBottom = 72; // Márgen inferior en puntos
        try {
            Document documento = new Document(PageSize.A4.rotate(), marginLeft, marginRight, marginTop, marginBottom);

            //PdfWriter.getInstance(documento, new FileOutputStream("ruta/del/archivo.pdf"));
            documento.open();

            // Insertar HTML en el PDF usando HtmlConverter de iText
            String htmlContent = "<!DOCTYPE html>\n"
                    + "<html>\n"
                    + "<head>\n"
                    + "<title>Reporte de Empresa</title>\n"
                    + "<link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css\">\n"
                    + "<style>\n"
                    + ".company-info h3 {\n"
                    + "   margin-top: 0; /* Elimina el espacio superior */\n"
                    + "}\n"
                    + ".company-logo img {\n"
                    + "   max-width: 100px; /* Ajusta el ancho máximo de la imagen */\n"
                    + "   height: auto; /* Mantén la relación de aspecto */\n"
                    + "}\n"
                    + ".center-text {\n"
                    + "   text-align: center; /* Centra el texto horizontalmente */\n"
                    + "}\n"
                    + "</style>\n"
                    + "</head>\n"
                    + "<body>\n"
                    + "<div class=\"container\">\n"
                    + "<div class=\"row\">\n"
                    + // Fila para el logo
                    "<div class=\"col-md-12\">\n"
                    + "<div class=\"company-logo text-center\">\n"
                    + "<img src=\"https://serviciopagina.upea.bo/Carrera/Logos/377b68ca-9d21-477b-a1aa-56fd21d9d1b4.png\" alt=\"Logo de la Empresa\" class=\"img-fluid\">\n"
                    + "</div>\n"
                    + "</div>\n"
                    + "</div>\n"
                    + "<div class=\"row\">\n"
                    + // Fila para la información de la empresa
                    "<div class=\"col-md-12\">\n"
                    + "<div class=\"company-info\">\n"
                    + "<h3>Universidad Publica del El Alto</h3>\n"
                    + "<p>Carrera: Ingenieria de sistemas</p>\n"
                    + "<p>Docente: M Sc. Mario Torrez</p>\n"
                    + "<p>Materia ¨TEM-742 Tecnologias emergentes II</p>\n"
                    + "</div>\n"
                    + "</div>\n"
                    + "</div>\n"
                    + "<div class=\"row\">\n"
                    + // Fila para el reporte de ventas
                    "<div class=\"col-md-12 center-text\">\n" // Agrega la clase center-text
                    + "<h2>Reporte Articulos</h2>\n"
                    + "<table class=\"table table-bordered table-striped\">\n"
                    + "<thead class=\"thead-dark\">\n"
                    + "<tr>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Id</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">nombre</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Codigo</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Stock</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Descripcion</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">categoria</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Condicion</th>\n"
                    + "</tr>\n"
                    + "</thead>\n"
                    + "<tbody>\n";

            ArticuloDAO dao = new ArticuloDAOimpl();
            CategoriaDAO daoCat = new CategoriaDAOimpl();
            List<Articulo> lista = dao.getAll();
            for (Articulo per : lista) {
                htmlContent += "<tr>\n"
                        + "<td style=\"font-size: 12px;\">" + per.getIdarticulo() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + per.getNombre() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + per.getCodigo() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + per.getStock() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + per.getDescripcion() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + per.getCategoria() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + per.getCondicion() + "</td>\n"
                        + "</tr>\n";
            }

            java.util.Date fechaActual = new java.util.Date();
            java.text.SimpleDateFormat formato = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            String fechaHora = formato.format(fechaActual);

            htmlContent += "</tbody>\n"
                    + "</table>\n"
                    + "<p style=\"text-align: left; font-size: 10px;\">Reporte generado el: " + fechaHora + "</p>\n"
                    + // Agregar la fecha y hora al final
                    "</div>\n"
                    + "</div>\n"
                    + "</div>\n"
                    + "</body>\n"
                    + "</html>";

            // Convertir HTML a PDF y agregarlo al documento
            HtmlConverter.convertToPdf(htmlContent, out);

            documento.close();
        } catch (DocumentException ex) {
        }
    }

    private PdfPCell getStyledCell(Object content, Font font, PdfPCell cell) {
        cell.setPhrase(new Phrase(String.valueOf(content), font));
        cell.setMinimumHeight(10); // Ajusta la altura mínima de la celda según tus necesidades
        return cell;
    }
}
