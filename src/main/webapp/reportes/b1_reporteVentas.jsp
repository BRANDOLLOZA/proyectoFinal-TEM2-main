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
    String nombreArchivo = "ReporteVentas.xls";
    response.setHeader("Content-Disposition", "attachment;filename=" + nombreArchivo);
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Reporte Excel</title>
    </head>
    <body>
        <h1>Reporte Ventas</h1>
        <table border="1" id="example1" class="table table-bordered table-striped dataTable dtr-inline" aria-describedby="example1_info">
            <thead>
                <tr>
                    <th class="sorting sorting_asc" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">Id</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">Fecha-hora</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending">cliente</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending">Usuario</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">TipoComprobante</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">NroComprobante</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">Total Ventas</th>
                </tr>
            </thead>
            <%
                VentaDAO dao = new VentaDAOimpl();
                ClienteDAO daoCliente = new ClienteDAOimpl();
                ArticuloDAO daoArticulo = new ArticuloDAOimpl();
                List<Venta> lista = dao.getAll();
                Iterator<Venta> iter = lista.iterator();
                Venta ven = null;
                while (iter.hasNext()) {
                    ven = iter.next();

            %>
            <tbody>
                <tr>
                    <td><%=ven.getIdventa() %></td>
                    <td><%=ven.getFecha_hora() %></td>
                    <td><%=ven.getCliente() %></td>
                    <td><%=ven.getUsuario() %></td>
                    <td><%=ven.getTipo_comprobante() %></td>
                    <td><%=ven.getNum_comprobante() %></td>
                    <td><%=ven.getTotal_venta() %></td>
                </tr>
            </tbody>
            <%}%>

            <h6>Reporte generado el: <%= Conversiones.formatearFecha(new Date())%></h6>
    </body>
</html>
