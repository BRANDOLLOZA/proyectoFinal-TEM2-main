<%
    if(session.getAttribute("usuario")!=null){
    
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="WEB-INF/header.jsp"/>
<jsp:include page="WEB-INF/sidebarMenu.jsp">
    <jsp:param name="opcion" value="usuarios"/>
</jsp:include>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Ventas</h1>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Ventas</a></li>
                        <li class="breadcrumb-item active">Venta</li>
                    </ol>
                </div><!-- /.col -->
            </div><!-- /.row -->
        </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <!-- /ESTO SE TIENE QUE MODIFICAR -->
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Listado de ventas</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                    <div class="row">
                                        <div class="col-sm-12 col-md-6">
                                            <div class="dt-buttons btn-group flex-wrap">
                                                <a href="B1_VentaControlador?action=add" >
                                                    <button type="button" class="btn btn-primary"><ion-icon name="add"></ion-icon>Nuevo</button>
                                                </a>&nbsp
                                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                                    <a href="reportes/b1_reporteVentas.jsp">
                                                        <button type="button" class="btn btn-success">
                                                            <i class="fa fa-table" aria-hidden="true"></i> Descargar xml
                                                            <i class="fa fa-arrow-down" aria-hidden="true"></i>

                                                        </button>
                                                    </a>
                                                </div> &nbsp 
                                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                                    <a href="B1_VentaControlador?action=repVenta" target="_blank">
                                                        <button type="button" class="btn btn-warning">
                                                            <i class="fa fa-file" aria-hidden="true"></i> Descargar PDF
                                                            <i class="fa fa-arrow-down" aria-hidden="true"></i>
                                                        </button>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <br>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <table id="example1" class="table table-bordered table-striped dataTable dtr-inline" aria-describedby="example1_info">
                                                <thead>
                                                    <tr>
                                                        <th class="sorting sorting_asc" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">ID</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">FECHA</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending">CLIENTE</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending">USUARIO</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">DOCUMENTO</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">NUMERO</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">TOTAL VENTA</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">ACCIONES</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="item" items="${ventas}">
                                                        <tr class="odd">
                                                            <td class="dtr-control sorting_1" tabindex="0">${item.idventa}</td>
                                                            <td>${item.fecha_hora}</td>
                                                            <td>${item.cliente}</td>
                                                            <td>${item.usuario}</td>
                                                            <td>${item.tipo_comprobante}</td>
                                                            <td>${item.num_comprobante}</td>
                                                            <td>${item.total_venta}</td>
                                                            <td><a href="B1_VentaControlador?action=detalle_venta&idventa=${item.idventa}"><i style="color: #dfd80c;"><ion-icon name="chevron-forward-circle"></ion-icon></i>Ver</a>
                                                            <!--<a href="B1_VentaControlador?action=delete&idventa=${item.idventa}"onclick="return(confirm('Estas seguro de eliminar'))"><i class="fa-solid fa-trash-can"><ion-icon name="trash-outline"></ion-icon></i></a></td>-->
                                                        </tr>                                                                   
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                </div>
                                <!-- /.card-body -->
                            </div>
                            <!-- /ESTO SE TIENE QUE MODIFICAR -->
                            <!-- /.card -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.container-fluid -->
        </section>
    </div>
    <!-- /.Main content -->
</div>
<!-- /.content-wrapper -->
<jsp:include page="WEB-INF/footer.jsp"/>

<%
    }  
else{
response.sendRedirect("login.jsp");
}
%>