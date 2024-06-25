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
                    <h1 class="m-0">Articulo</h1>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Articulos</a></li>
                        <li class="breadcrumb-item active">Articulo</li>
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
                                <h3 class="card-title">Listado de Articulos</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                    <div class="row">
                                        <div class="col-sm-12 col-md-6">
                                            <div class="dt-buttons btn-group flex-wrap">
                                                <a href="D1_ArticuloControlador?action=add" >
                                                    <button type="button" class="btn btn-primary"><ion-icon name="add"></ion-icon>Nuevo</button>
                                                </a>
                                                &nbsp 
                                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                                    <a href="reportes/d1_reporteArticulo.jsp">
                                                           <button type="button" class="btn btn-success">
                                                            <i class="fa fa-table" aria-hidden="true"></i> Descargar xml
                                                            <i class="fa fa-arrow-down" aria-hidden="true"></i>

                                                        </button>
                                                    </a>
                                                </div>
                                                &nbsp 
                                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                                    <a href="D1_ArticuloControlador?action=repArticulo" target="_blank">
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
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">NOMBRE</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending">CODIGO</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending">STOCK</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">DESCRIPCION</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">CATEGORIA</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">CONDICION</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">ACCIONES</th>
                                                        <!-- <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending"></th>-->
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="item" items="${articulos}">
                                                        <tr class="odd">
                                                            <td class="dtr-control sorting_1" tabindex="0">${item.idarticulo}</td>
                                                            <td>${item.nombre}</td>
                                                            <td>${item.codigo}</td>
                                                            <td>${item.stock}</td>
                                                            <td>${item.descripcion}</td>
                                                            <td>${item.categoria}</td>
                                                            <td>${item.condicion}</td>
                                                            <td><a href="D1_ArticuloControlador?action=edit&idarticulo=${item.idarticulo}"><i class="fa-solid fa-pen-to-square"><ion-icon name="create-outline"></ion-icon></i></a>
                                                                <a href="D1_ArticuloControlador?action=delete&idarticulo=${item.idarticulo}"onclick="return(confirm('Estas seguro de eliminar'))"><i class="fa-solid fa-trash-can"><ion-icon name="trash-outline"></ion-icon></i></a></td>
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

<jsp:include page="WEB-INF/footer.jsp"/>
<%}else{
response.sendRedirect("login.jsp");
    }
%>