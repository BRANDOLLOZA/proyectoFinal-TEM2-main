<%-- 
    Document   : newjsp
    Created on : 9 nov 2023, 8:29:22
    Author     : marco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="WEB-INF/header.jsp"/>
<jsp:include page="WEB-INF/sidebarMenu.jsp">
    <jsp:param name="opcion" value="h2_permisos"/>
</jsp:include>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Permiso</h1>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Accesos</a></li>
                        <li class="breadcrumb-item active">Permiso</li>
                    </ol>
                </div><!-- /.col -->
            </div><!-- /.row -->
        </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <!-- TODO CONTENIDO -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container-fluid -->
    </div>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<!-- Control Sidebar -->
<aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
</aside>
<!-- /.control-sidebar -->

<jsp:include page="WEB-INF/footer.jsp"/>  