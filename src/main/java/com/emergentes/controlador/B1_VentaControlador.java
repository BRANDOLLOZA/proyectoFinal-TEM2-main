package com.emergentes.controlador;

import com.emergentes.dao.ArticuloDAO;
import com.emergentes.dao.ArticuloDAOimpl;
import com.emergentes.dao.ClienteDAO;
import com.emergentes.dao.ClienteDAOimpl;
import com.emergentes.dao.Detalle_ventaDAO;
import com.emergentes.dao.Detalle_ventaDAOimpl;
import com.emergentes.dao.VentaDAO;
import com.emergentes.dao.VentaDAOimpl;
import com.emergentes.modelo.Articulo;
import com.emergentes.modelo.Detalle_venta;
import com.emergentes.modelo.Persona;
import com.emergentes.modelo.Venta;
import com.emergentes.utiles.ConexionBD;
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
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transaction;

@WebServlet(name = "B1_VentaControlador", urlPatterns = {"/B1_VentaControlador"})
public class B1_VentaControlador extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            VentaDAO dao = new VentaDAOimpl();
            ClienteDAO daoCliente = new ClienteDAOimpl();
            ArticuloDAO daoArticulo = new ArticuloDAOimpl();
            int id;
            List<Persona> lista_clientes = null;
            Venta venta = new Venta();

            Detalle_ventaDAO daoDetalleV = new Detalle_ventaDAOimpl();
            //Detalle_venta d_venta = new Detalle_venta();
            List<Detalle_venta> lista1 = null;

            String action = (request.getParameter("action") != null) ? request.getParameter("action") : "view";
            switch (action) {
                case "add":
                    List<Articulo> lista_articulos = daoArticulo.getAll();
                    request.setAttribute("articulos", lista_articulos);

                    lista_clientes = daoCliente.getAll();
                    request.setAttribute("lista_clientes", lista_clientes);

                    request.setAttribute("venta", venta);
                    request.getRequestDispatcher("frm_venta.jsp").forward(request, response);
                    break;
                case "edit":
                    id = Integer.parseInt(request.getParameter("idventa"));
                    venta = dao.getById(id);
                    lista_clientes = daoCliente.getAll();
                    request.setAttribute("lista_clientes", lista_clientes);
                    // Colocar como atributo
                    request.setAttribute("venta", venta);
                    // Transferir el control a frmventa.jsp
                    request.getRequestDispatcher("frm_venta.jsp").forward(request, response);
                    break;
                case "delete":
                    id = Integer.parseInt(request.getParameter("idventa"));
                    dao.delete(id);
                    response.sendRedirect("B1_VentaControlador");
                    break;
                case "view":
                    //Obtener la lista de registros
                    List<Venta> lista = dao.getAll();
                    request.setAttribute("ventas", lista);
                    request.getRequestDispatcher("b1_ventas.jsp").forward(request, response);
                    break;
                case "detalle_venta":
                    id = Integer.parseInt(request.getParameter("idventa"));
                    lista1 = daoDetalleV.getAllId(id);
                    request.setAttribute("d_ventas", lista1);

                    // Transferir el control a frmventa.jsp
                    venta = dao.getById(id);
                    request.setAttribute("venta", venta);

                    request.getRequestDispatcher("frm_dventas.jsp").forward(request, response);
                    break;
                case "repVenta":
                    generarReporteVenta(response);
                    break;
                case "repDetalleVenta":
                    id = Integer.parseInt(request.getParameter("idventa"));
                    //venta = dao.getById(id);

                    generarReporteVentaDetalle(response, id);
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
        int id = Integer.parseInt(request.getParameter("idventa"));
        int idcliente = Integer.parseInt(request.getParameter("idcliente"));
        //int idusuario = Integer.parseInt(request.getParameter("idusuario"));
        int idusuario = Integer.parseInt(request.getParameter("idusuario"));
        String tipo_comprobante = request.getParameter("tipo_comprobante");
        String serie_comprobante = request.getParameter("serie_comprobante");
        String num_comprobante = request.getParameter("num_comprobante");
        double total_venta = Double.parseDouble(request.getParameter("total_venta"));
        Date fecha_hora = Date.valueOf(request.getParameter("fecha_hora"));
        String estado = "Aceptado";

        //int iddetalle = Integer.parseInt(request.getParameter("iddetalle_venta"));
        int id_venta = Integer.parseInt(request.getParameter("idusuario"));
        String[] idarticulo = request.getParameterValues("idarticulo[]");
        String[] cantidad = request.getParameterValues("cantidad[]");
        String[] precio_venta = request.getParameterValues("precio_venta[]");
        String[] descuento = request.getParameterValues("descuento[]");
        

        Venta venta = new Venta();
        venta.setIdventa(id);
        venta.setIdcliente(idcliente);
        venta.setIdusuario(idusuario);
        venta.setTipo_comprobante(tipo_comprobante);
        venta.setSerie_comprobante(serie_comprobante);
        venta.setNum_comprobante(num_comprobante);
        venta.setFecha_hora(fecha_hora);
        venta.setTotal_venta(total_venta);
        venta.setEstado(estado);

        // List<Detalle_venta> detalles = new ArrayList<>();
        Detalle_venta de_venta = new Detalle_venta();

        if (id == 0) {
            //Nuevo
            VentaDAO dao = new VentaDAOimpl();
            Detalle_ventaDAO daoDV = new Detalle_ventaDAOimpl();
            try {
                // Nuevo registro
                id_venta = dao.insert(venta);
                //venta.setIdventa(id_venta);
                System.out.println("id de venta: " + id_venta);
                // registrando detalle de venta

                ConexionBD conexion = new ConexionBD();
                Connection conn = conexion.conectar();
                PreparedStatement dv = conn.prepareStatement("INSERT INTO detalle_venta (idventa,idarticulo,cantidad,precio_venta,descuento) values (?,?,?,?,?)");
                for (int i = 0; i < idarticulo.length; i++) {
                    dv.setInt(1, id_venta);
                    dv.setInt(2, (Integer.parseInt(idarticulo[i])));
                    dv.setInt(3, (Integer.parseInt(cantidad[i])));
                    dv.setInt(4, (Integer.parseInt(precio_venta[i])));
                    dv.setInt(5, (Integer.parseInt(descuento[i])));
                    dv.executeUpdate();
                   
                    System.out.println("contador: " + i);
                }
                // daoDV.insert(de_venta);

                response.sendRedirect("B1_VentaControlador");
                dv.close(); // Cerrar el objeto que contiene la sentencia SQL preparada
                conn.close();
            } catch (Exception ex) {
                System.out.println("Error al insertar " + ex.getMessage());
            }
        } else {
            //Editar
            VentaDAO dao = new VentaDAOimpl();
            try {
                dao.update(venta);
                response.sendRedirect("D1_ArticuloControlador");
            } catch (Exception ex) {
                System.out.println("Error al editar" + ex.getMessage());
            }
        }

    }

    private void generarReporteVenta(HttpServletResponse response) throws IOException, Exception {
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
                    + "<h2>Reporte Ventas</h2>\n"
                    + "<table class=\"table table-bordered table-striped\">\n"
                    + "<thead class=\"thead-dark\">\n"
                    + "<tr>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">IdVenta</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Fecha-Hora</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Cliente</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Usuario</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Tipo Comprobante</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Nro Coprobante</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Total Bs</th>\n"
                    + "</tr>\n"
                    + "</thead>\n"
                    + "<tbody>\n";

            VentaDAO dao = new VentaDAOimpl();
            ClienteDAO daoCliente = new ClienteDAOimpl();
            ArticuloDAO daoArticulo = new ArticuloDAOimpl();
            List<Venta> lista = dao.getAll();
            for (Venta venta : lista) {
                htmlContent += "<tr>\n"
                        + "<td style=\"font-size: 12px;\">" + venta.getIdventa() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + venta.getFecha_hora() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + venta.getCliente() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + venta.getUsuario() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + venta.getTipo_comprobante() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + venta.getNum_comprobante() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + venta.getTotal_venta() + "</td>\n"
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

    private void generarReporteVentaDetalle(HttpServletResponse response, int id) throws Exception {
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
                    + "<h2>Reporte Detalle Venta</h2>\n"
                    + "<table class=\"table table-bordered table-striped\">\n"
                    + "<thead class=\"thead-dark\">\n"
                    + "<tr>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">id</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Articuculo</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Cantidad</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Precio</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Descuento</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Sub total</th>\n"
                    + "</tr>\n"
                    + "</thead>\n"
                    + "<tbody>\n";

            VentaDAO dao = new VentaDAOimpl();
            ClienteDAO daoCliente = new ClienteDAOimpl();
            ArticuloDAO daoArticulo = new ArticuloDAOimpl();
            List<Persona> lista_clientes = null;
            Venta venta = new Venta();

            Detalle_ventaDAO daoDetalleV = new Detalle_ventaDAOimpl();
            //Detalle_venta d_venta = new Detalle_venta();
            List<Detalle_venta> lista1 = null;

            venta = dao.getById(id);
            lista1 = daoDetalleV.getAllId(id);

            htmlContent += "<p style=\"text-align: left;\">Cliente: " + venta.getCliente() + "<br>"
                    + "Numero de factura: " + venta.getNum_comprobante() + "<br>"
                    + "Fecha: " + venta.getFecha_hora() + "</p>\n";

            for (Detalle_venta detalleVenta : lista1) {
                htmlContent += "<tr>\n"
                        + "<td style=\"font-size: 12px;\">" + detalleVenta.getIdventa() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + detalleVenta.getArticulo() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + detalleVenta.getCantidad() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + detalleVenta.getPrecio_venta() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + detalleVenta.getDescuento() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + detalleVenta.getSubtotal() + "</td>\n"
                        + "</tr>\n";
            }
            htmlContent += "<tr>"
                    + "<td colspan=5 style=\"font-size: 12px;\">TOTAL</td>\n"
                    + "<td style=\"font-size: 12px;\">" + venta.getTotal_venta() + " </td>\n"
                    + "</tr>";

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

}
