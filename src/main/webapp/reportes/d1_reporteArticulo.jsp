<%@page import="com.emergentes.modelo.Articulo"%>
<%@page import="com.emergentes.dao.CategoriaDAOimpl"%>
<%@page import="com.emergentes.dao.CategoriaDAO"%>
<%@page import="com.emergentes.dao.ArticuloDAOimpl"%>
<%@page import="com.emergentes.dao.ArticuloDAO"%>
<%@page import="com.emergentes.utiles.Conversiones, java.util.*"%>
<%@page contentType="application/vnd.ms-excel" %>
<%
    String nombreArchivo = "ReporteArticulo.xls";
    response.setHeader("Content-Disposition", "attachment;filename=" + nombreArchivo);
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Reporte Excel</title>
    </head>
    <body>
        <h1>Reporte clientes</h1>
        <table border="1" id="example1" class="table table-bordered table-striped dataTable dtr-inline" aria-describedby="example1_info">
            <thead>
                <tr>
                    <th class="sorting sorting_asc" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">Id</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">nombre</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending">Codigo</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending">Stock</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">Descripcion</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">categoria</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">Condicion</th>
                </tr>
            </thead>
            <%
                ArticuloDAO dao = new ArticuloDAOimpl();
                CategoriaDAO daoCat = new CategoriaDAOimpl();
                List<Articulo> lista = dao.getAll();
                Iterator<Articulo> iter = lista.iterator();
                Articulo art = null;
                while (iter.hasNext()) {
                    art = iter.next();

            %>
            <tbody>
                <tr>
                    <td><%=art.getIdarticulo() %></td>
                    <td><%=art.getNombre() %></td>
                    <td><%=art.getCodigo() %></td>
                    <td><%=art.getStock() %></td>
                    <td><%=art.getDescripcion() %></td>
                    <td><%=art.getCategoria() %></td>
                    <td><%=art.getCondicion() %></td>
                </tr>
            </tbody>
            <%}%>

            <h6>Reporte generado el: <%= Conversiones.formatearFecha(new Date())%></h6>
    </body>
</html>
