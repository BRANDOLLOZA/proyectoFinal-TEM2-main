package com.emergentes.controlador;

import com.emergentes.dao.ArticuloDAO;
import com.emergentes.dao.ArticuloDAOimpl;
import com.emergentes.dao.Detalle_ingresoDAO;
import com.emergentes.dao.Detalle_ingresoDAOimpl;
import com.emergentes.dao.IngresoDAO;
import com.emergentes.dao.IngresoDAOimpl;
import com.emergentes.dao.ProveedorDAO;
import com.emergentes.dao.ProveedorDAOimpl;
import com.emergentes.modelo.Articulo;
import com.emergentes.modelo.Detalle_ingreso;
import com.emergentes.modelo.Ingreso;
import com.emergentes.modelo.Persona;
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
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "IngresoControlador", urlPatterns = {"/IngresoControlador"})
public class IngresoControlador extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            IngresoDAO dao = new IngresoDAOimpl();
            ProveedorDAO daoProveedor = new ProveedorDAOimpl();
            ArticuloDAO daoArticulo = new ArticuloDAOimpl();
            int id;
            List<Persona> lista_proveedores = null;

            Ingreso ingreso = new Ingreso();
            Detalle_ingresoDAO daoDetalleI = new Detalle_ingresoDAOimpl();
            List<Detalle_ingreso> lista1 = null;
            String action = (request.getParameter("action") != null) ? request.getParameter("action") : "view";
            switch (action) {
                case "add":
                    List<Articulo> lista_articulos = daoArticulo.getAll();
                    request.setAttribute("articulos", lista_articulos);

                    lista_proveedores = daoProveedor.getAll();
                    request.setAttribute("lista_proveedores", lista_proveedores);

                    request.setAttribute("ingreso", ingreso);
                    request.getRequestDispatcher("frm_ingreso.jsp").forward(request, response);
                    break;
                case "edit":
                    id = Integer.parseInt(request.getParameter("idingreso"));
                    ingreso = dao.getById(id);
                    lista_proveedores = daoProveedor.getAll();
                    request.setAttribute("lista_proveedores", lista_proveedores);
                    // Colocar como atributo
                    request.setAttribute("ingreso", ingreso);
                    // Transferir el control a frmventa.jsp
                    request.getRequestDispatcher("frm_ingreso.jsp").forward(request, response);
                    break;
                case "delete":
                    id = Integer.parseInt(request.getParameter("idingreso"));
                    dao.delete(id);
                    response.sendRedirect("IngresoControlador");
                    break;
                case "view":
                    List<Ingreso> lista = dao.getAll();
                    request.setAttribute("ingresos", lista);
                    request.getRequestDispatcher("v_ingresos.jsp").forward(request, response);
                    break;
                case "repCompra":
                    generarReporteCompra(response);
                    break;
                case "detalle_venta":
                    id = Integer.parseInt(request.getParameter("idingreso"));
                    lista1 = daoDetalleI.getAllId(id);
                    request.setAttribute("d_ingresos", lista1);

                    ingreso = dao.getById(id);
                    request.setAttribute("ingreso", ingreso);

                    request.getRequestDispatcher("frm_dingresos.jsp").forward(request, response);
                    break;
                case "repDetalleCompra":
                    id = Integer.parseInt(request.getParameter("idingreso"));
                    //venta = dao.getById(id);

                    generarReporteDetalleCompra(response, id);
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
        //datos para el registro de la tabla ingreso
        int id = Integer.parseInt(request.getParameter("idingreso"));
        int idproveedor = Integer.parseInt(request.getParameter("idproveedor"));
        //int idusuario = Integer.parseInt(request.getParameter("idusuario"));
        int idusuario = Integer.parseInt(request.getParameter("idusuario"));
        String tipo_comprobante = request.getParameter("tipo_comprobante");
        String serie_comprobante = request.getParameter("serie_comprobante");
        String num_comprobante = request.getParameter("num_comprobante");
        Date fecha_hora = Date.valueOf(request.getParameter("fecha_hora"));
        double total_compra = Double.parseDouble(request.getParameter("total_compra"));
        String estado = "Aceptado";
        // datos para el registro de la tabla detalle_ingreso
        //int iddetalle = Integer.parseInt(request.getParameter("iddetalle_venta"));
        int id_ingreso = Integer.parseInt(request.getParameter("idusuario"));
        String[] idarticulo = request.getParameterValues("idarticulo[]");
        String[] cantidad = request.getParameterValues("cantidad[]");
        String[] precio_compra = request.getParameterValues("precio_compra[]");
        String[] precio_venta = request.getParameterValues("precio_venta[]");

        Ingreso ingreso = new Ingreso();
        ingreso.setIdingreso(id);
        ingreso.setIdproveedor(idproveedor);
        ingreso.setIdusuario(idusuario);
        ingreso.setTipo_comprobante(tipo_comprobante);
        ingreso.setSerie_comprobante(serie_comprobante);
        ingreso.setNum_comprobante(num_comprobante);
        ingreso.setFecha_hora(fecha_hora);
        ingreso.setTotal_compra(total_compra);
        ingreso.setEstado(estado);

        Detalle_ingreso de_ingreso = new Detalle_ingreso();

        if (id == 0) {
            IngresoDAO dao = new IngresoDAOimpl();
            Detalle_ingresoDAO daoDI = new Detalle_ingresoDAOimpl();
            try {
                // Nuevo registro detalle de ingreso
                id_ingreso = dao.insert(ingreso);
                ConexionBD conexion = new ConexionBD();
                Connection conn = conexion.conectar();
                PreparedStatement di = conn.prepareStatement("INSERT INTO detalle_ingreso (idingreso,idarticulo,cantidad,precio_compra,precio_venta) values (?,?,?,?,?)");

                for (int i = 0; i < idarticulo.length; i++) {
                    di.setInt(1, id_ingreso);
                    di.setInt(2, (Integer.parseInt(idarticulo[i])));
                    di.setInt(3, (Integer.parseInt(cantidad[i])));
                    di.setDouble(4, (Double.parseDouble(precio_compra[i])));
                    di.setDouble(5, (Double.parseDouble(precio_venta[i])));
                    di.executeUpdate();
                }
                response.sendRedirect("IngresoControlador");
                di.close(); // Cerrar el objeto que contiene la sentencia SQL preparada
                conn.close();
            } catch (Exception ex) {
                System.out.println("Error al insertar " + ex.getMessage());
            }
        } else {
            //Editar
            IngresoDAO dao = new IngresoDAOimpl();
            try {
                dao.update(ingreso);
                response.sendRedirect("IngresoControlador");
            } catch (Exception ex) {
                System.out.println("Error al editar" + ex.getMessage());
            }
        }
    }

    private void generarReporteCompra(HttpServletResponse response) throws IOException, Exception {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=reporte_empresa.pdf");

        OutputStream out = response.getOutputStream();
        // Configurar los márgenes del documento (en puntos)
        float marginLeft = 36; // Márgen izquierdo en puntos
        float marginRight = 36; // Márgen derecho en puntos
        float marginTop = 72; // Márgen superior en puntos
        float marginBottom = 72; // Márgen inferior en puntos
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
                + "<h2>Reporte Compras</h2>\n"
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
        IngresoDAO dao = new IngresoDAOimpl();
        ProveedorDAO daoProveedor = new ProveedorDAOimpl();
        ArticuloDAO daoArticulo = new ArticuloDAOimpl();
        List<Ingreso> lista = dao.getAll();
        for (Ingreso ingreso : lista) {
            htmlContent += "<tr>\n"
                    + "<td style=\"font-size: 12px;\">" + ingreso.getIdingreso() + "</td>\n"
                    + "<td style=\"font-size: 12px;\">" + ingreso.getFecha_hora() + "</td>\n"
                    + "<td style=\"font-size: 12px;\">" + ingreso.getProveedor() + "</td>\n"
                    + "<td style=\"font-size: 12px;\">" + ingreso.getUsuario() + "</td>\n"
                    + "<td style=\"font-size: 12px;\">" + ingreso.getTipo_comprobante() + "</td>\n"
                    + "<td style=\"font-size: 12px;\">" + ingreso.getNum_comprobante() + "</td>\n"
                    + "<td style=\"font-size: 12px;\">" + ingreso.getTotal_compra() + "</td>\n"
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
    }

    private PdfPCell getStyledCell(Object content, Font font, PdfPCell cell) {
        cell.setPhrase(new Phrase(String.valueOf(content), font));
        cell.setMinimumHeight(10); // Ajusta la altura mínima de la celda según tus necesidades
        return cell;
    }

    private void generarReporteDetalleCompra(HttpServletResponse response, int id) throws Exception {
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
                    + "<h2>Reporte Detalle Compras</h2>\n"
                    + "<table class=\"table table-bordered table-striped\">\n"
                    + "<thead class=\"thead-dark\">\n"
                    + "<tr>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">id</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Articuculo</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Cantidad</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Precio de compra</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Precio de venta</th>\n"
                    + "<th scope=\"col\" style=\"font-size: 13px; text-align: center;\">Sub total</th>\n"
                    + "</tr>\n"
                    + "</thead>\n"
                    + "<tbody>\n";

            IngresoDAO dao = new IngresoDAOimpl();
            ProveedorDAO daoProveedor = new ProveedorDAOimpl();
            ArticuloDAO daoArticulo = new ArticuloDAOimpl();
            List<Persona> lista_clientes = null;
            Ingreso ingreso = new Ingreso();

            Detalle_ingresoDAO daoDetalleC = new Detalle_ingresoDAOimpl();
            //Detalle_venta d_venta = new Detalle_venta();
            List<Detalle_ingreso> listaIngreso = null;

            ingreso = dao.getById(id);
            listaIngreso = daoDetalleC.getAllId(id);

            htmlContent += "<p style=\"text-align: left;\">Proveedor: " + ingreso.getProveedor() + "<br>"
                    + "Numero de factura: " + ingreso.getNum_comprobante() + "<br>"
                    + "Fecha: " + ingreso.getFecha_hora() + "</p>\n";

            for (Detalle_ingreso detalleCompra : listaIngreso) {
                htmlContent += "<tr>\n"
                        + "<td style=\"font-size: 12px;\">" + detalleCompra.getIdingreso() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + detalleCompra.getArticulo() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + detalleCompra.getCantidad() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + detalleCompra.getPrecio_compra() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + detalleCompra.getPrecio_venta() + "</td>\n"
                        + "<td style=\"font-size: 12px;\">" + detalleCompra.getSubtotal() + "</td>\n"
                        + "</tr>\n";
            }
            htmlContent += "<tr>"
                    + "<td colspan=5 style=\"font-size: 12px;\">TOTAL</td>\n"
                    + "<td style=\"font-size: 12px;\">" + ingreso.getTotal_compra() + " </td>\n"
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
