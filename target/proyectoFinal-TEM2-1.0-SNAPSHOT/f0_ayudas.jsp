<%
    if(session.getAttribute("usuario")!=null){
    
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="WEB-INF/header.jsp"/>

<jsp:include page="WEB-INF/sidebarMenu.jsp">
    <jsp:param name="opcion" value="f0_ayudas"/>
</jsp:include>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Ayuda</h1>
                </div><!-- /.col -->
            </div><!-- /.row -->
        </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
        <section class="content">
            <div class="container-fluid">
                <!-- Botones Rojos en Ventana -->
                <div class="row">
                    <div class="col-md-12">
                        
                        <!-- Botón Rojo Administración -->
                        <button class="btn btn-danger" data-toggle="modal" data-target="#administracionModal"><strong>Administración</strong></button>
                    </div>
                </div>
                <!-- Botón Azul con Ventana de Sugerencias -->
                <div class="row mt-3">
                    <div class="col-md-12">
                        <!-- Botón Azul Sugerencia -->
                        <button class="btn btn-primary" data-toggle="modal" data-target="#sugerenciaModal"><strong>Sugerencia</strong></button>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <!-- /.Main content -->
</div>
<!-- /.content-wrapper -->

<!-- Modal para Administración -->
<div class="modal fade" id="administracionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"><strong>Administración</strong></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <strong>Supervisor:</strong> 7046220<br>
                <strong>Ingeniero de Software:</strong> 74526321<br>
                <strong>Gerente General:</strong> 74856236
            </div>
        </div>
    </div>
</div>

<!-- Modal para Sugerencia -->
<div class="modal fade" id="sugerenciaModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"><strong>Sugerencia</strong></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Aquí puedes colocar el formulario para recibir sugerencias -->
                <form action="procesar_sugerencia.jsp" method="post">
                    <label for="sugerencia">Escribe tu sugerencia:</label>
                    <textarea id="sugerencia" name="sugerencia" rows="4" cols="50"></textarea>
                    <br>
                    <input type="submit" value="Enviar Sugerencia">
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="WEB-INF/footer.jsp"/>
<%}else{
response.sendRedirect("login.jsp");
    }
%>