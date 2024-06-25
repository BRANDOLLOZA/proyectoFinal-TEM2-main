<%@page import="com.emergentes.modelo.Categoria"%>
<%@page import="com.emergentes.dao.CategoriaDAOimpl"%>
<%@page import="com.emergentes.dao.CategoriaDAO"%>
<%@page import="com.emergentes.utiles.Conversiones, java.util.*"%>
<%@page contentType="application/vnd.ms-excel" %>
<%
    String nombreArchivo = "ReporteCategoria.xls";
    response.setHeader("Content-Disposition", "attachment;filename=" + nombreArchivo);
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Reporte Excel</title>
    </head>
    <body>
        <h1>Reporte Categoria</h1>
        <table border="1" id="example1" class="table table-bordered table-striped dataTable dtr-inline" aria-describedby="example1_info">
            <thead>
                <tr>
                    <th class="sorting sorting_asc" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">Id</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">Nombre</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending">Descripcion</th>
                </tr>
            </thead>
            <%
                CategoriaDAO dao = new CategoriaDAOimpl();
                List<Categoria> lista = dao.getAll();
                Iterator<Categoria> iter = lista.iterator();
                Categoria cat = null;
                while (iter.hasNext()) {
                    cat = iter.next();

            %>
            <tbody>
                <tr>
                    <td><%=cat.getIdcategoria()%></td>
                    <td><%=cat.getNombre()%></td>
                    <td><%=cat.getDescripcion()%></td>              
                </tr>
            </tbody>
            <%}%>

            <h6>Reporte generado el: <%= Conversiones.formatearFecha(new Date())%></h6>
    </body>
</html>
