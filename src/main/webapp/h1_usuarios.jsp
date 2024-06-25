<%
    if (session.getAttribute("usuario") != null) {
      
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
                    <h1 class="m-0">Usuarios</h1>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Usuario</a></li>
                        <li class="breadcrumb-item active">Usuario</li>
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
                                <h3 class="card-title">Listado de Usuarios</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                    <div class="row">
                                        <div class="col-sm-12 col-md-6">
                                            <div class="dt-buttons btn-group flex-wrap">
                                                <a href="H1_UsuarioControlador?action=add" >
                                                    <button type="button" class="btn btn-primary"><ion-icon name="add"></ion-icon>Nuevo</button>
                                                </a>
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
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending">CI</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending">EMAIL</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">CARGO</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">USUARIO</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">ROL</th>
                                                        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">ACCIONES</th>
                                                        <!-- <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending"></th>-->
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="item" items="${usuarios}">
                                                        <tr class="odd">
                                                            <td class="dtr-control sorting_1" tabindex="0">${item.idusuario}</td>
                                                            <td>${item.nombre}</td>
                                                            <td>${item.ci_documento}</td>
                                                            <td>${item.email}</td>
                                                            <td>${item.cargo}</td>
                                                            <td>${item.login}</td>
                                                            <td>${item.rol_nombre}</td>
                                                            <td><a href="H1_UsuarioControlador?action=edit&idusuario=${item.idusuario}"><i class="fa-solid fa-pen-to-square"><ion-icon name="create-outline"></ion-icon></i></a>
                                                                <a href="H1_UsuarioControlador?action=delete&idusuario=${item.idusuario}"onclick="return(confirm('Estas seguro de eliminar'))"><i class="fa-solid fa-trash-can"><ion-icon name="trash-outline"></ion-icon></i></a></td>
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
<%}else{
response.sendRedirect("login.jsp");
    }
%>