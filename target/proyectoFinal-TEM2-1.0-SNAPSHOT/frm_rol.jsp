<%
    if (session.getAttribute("usuario") != null) {
       
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="WEB-INF/header.jsp"/>

<jsp:include page="WEB-INF/sidebarMenu.jsp">
    <jsp:param name="opcion" value="v_roles"/>
</jsp:include>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Rol</h1>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="RolControlador">Roles</a></li>
                        <li class="breadcrumb-item active">Rol</li>
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
                                <h3 class="card-title">Crear nuevo rol</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                    <div class="row">
                                        <div class="col-sm-12 col-md-6">
                                            <div class="dt-buttons btn-group flex-wrap">
                                                <a href="RolControlador?action=view">
                                                    <button type="button" class="btn btn-warning">Regresar</button>
                                                </a>
                                            </div>                                                            
                                        </div>    
                                    </div>                                                    
                                    <form action="RolControlador" method="post">
                                        <input type="hidden" name="idrol" value="${rol.idrol}">                                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="form-group">
                                                       <!-- <label>Nombre de rol</label>
                                                        <input type="text" name="nombre" value="${rol.nombre}" class="form-control" placeholder="Ingresa el nombre de rol">-->
                                                    
                                                    <label for="" class="form-label">Nombre de rol</label>
                                                        <select name="nombre" class="form-control">
                                                            <option value="">--Seleccione--</option>
                                                            <option value="Administrador">Administrador</option>  
                                                            <option value="Vendedor">Vendedor</option>
                                                            <option value="Empleado">Empleado</option>
                                                            <option value="Tecnico">Tecnico</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Descripción</label>
                                                        <input type="text" name="descripcion" value="${rol.descripcion}" class="form-control" placeholder="Ingresa una descripcion">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer justify-content-between">
                                            <button type="submit" class="btn btn-primary">Guardar</button>
                                        </div>
                                    </form>
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