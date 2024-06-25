<%@page import="com.emergentes.modelo.Ingreso"%>
<%@page import="com.emergentes.dao.ProveedorDAOimpl"%>
<%@page import="com.emergentes.dao.IngresoDAOimpl"%>
<%@page import="com.emergentes.dao.ProveedorDAO"%>
<%@page import="com.emergentes.dao.IngresoDAO"%>
<%@page import="com.emergentes.modelo.Venta"%>
<%@page import="com.emergentes.dao.ArticuloDAOimpl"%>
<%@page import="com.emergentes.dao.ArticuloDAO"%>
<%@page import="com.emergentes.dao.ClienteDAOimpl"%>
<%@page import="com.emergentes.dao.ClienteDAO"%>
<%@page import="com.emergentes.dao.VentaDAOimpl"%>
<%@page import="com.emergentes.dao.VentaDAO"%>
<%@page import="com.emergentes.utiles.Conversiones, java.util.*"%>
<%@page contentType="application/vnd.ms-excel" %>
<%
    String nombreArchivo = "ReporteCompras.xls";
    response.setHeader("Content-Disposition", "attachment;filename=" + nombreArchivo);
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Reporte Excel</title>
    </head>
    <body>
        <h1>Reporte Compras</h1>
        <table border="1" id="example1" class="table table-bordered table-striped dataTable dtr-inline" aria-describedby="example1_info">
            <thead>
                <tr>
                    <th class="sorting sorting_asc" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">Id</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">Fecha-hora</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending">Proveedor</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending">Usuario</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">TipoComprobante</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">NroComprobante</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">Total Compra</th>
                </tr>
            </thead>
            <%
                IngresoDAO dao = new IngresoDAOimpl();
                ProveedorDAO daoProveedor = new ProveedorDAOimpl();
                ArticuloDAO daoArticulo = new ArticuloDAOimpl();
                List<Ingreso> lista = dao.getAll();
                Iterator<Ingreso> iter = lista.iterator();
                Ingreso ing = null;
                while (iter.hasNext()) {
                    ing = iter.next();

            %>
            <tbody>
                <tr>
                    <td><%=ing.getIdingreso()%></td>
                    <td><%=ing.getFecha_hora()%></td>
                    <td><%=ing.getProveedor()%></td>
                    <td><%=ing.getUsuario()%></td>
                    <td><%=ing.getTipo_comprobante()%></td>
                    <td><%=ing.getNum_comprobante()%></td>
                    <td><%=ing.getTotal_compra()%></td>
                </tr>
            </tbody>
            <%}%>

            <h6>Reporte generado el: <%= Conversiones.formatearFecha(new Date())%></h6>
    </body>
</html>
