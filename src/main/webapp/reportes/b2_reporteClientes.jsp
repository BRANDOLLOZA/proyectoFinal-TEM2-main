<%@page import="com.emergentes.modelo.Persona"%>
<%@page import="com.emergentes.dao.ClienteDAOimpl"%>
<%@page import="com.emergentes.dao.ClienteDAO"%>
<%@page import="com.emergentes.utiles.Conversiones, java.util.*"%>
<%@page contentType="application/vnd.ms-excel" %>
<%
    String nombreArchivo = "ReporteClientes.xls";
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
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">Tipo Pesona</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending">Nombre</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending">CI</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">Direccion</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">Telefono</th>
                    <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">Email</th>
                </tr>
            </thead>
            <%
                ClienteDAO dao = new ClienteDAOimpl();
                List<Persona> lista1 = dao.getAll();
                Iterator<Persona> iter = lista1.iterator();
                Persona per = null;
                while (iter.hasNext()) {
                    per = iter.next();

            %>
            <tbody>
                <tr>
                    <td><%=per.getIdpersona()%></td>
                    <td><%=per.getTipo_persona()%></td>
                    <td><%=per.getNombre()%></td>
                    <td><%=per.getCi_documento()%></td>
                    <td><%=per.getDireccion()%></td>
                    <td><%=per.getTelefono()%></td>
                    <td><%=per.getEmail()%></td>                
                </tr>
            </tbody>
            <%}%>
            
            <h6>Reporte generado el: <%= Conversiones.formatearFecha(new Date())%></h6>
    </body>
</html>
