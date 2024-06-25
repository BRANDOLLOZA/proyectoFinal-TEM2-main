<%
    if (session.getAttribute("usuario") != null) {

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
                <div class="card">

                    <div class="card-body"> 
                        <div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
                            <div class="row">   
                                <div class="col-ms-12">
                                    <h1>Que ayuda requieres saber...</h1>  
                                </div>
                            </div>
                            <!-- Botón Información General -->
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <button class="btn btn-secondary" data-toggle="modal" data-target="#infoGeneralModal">Información General</button>
                                </div>
                            </div>
                            <!-- Botón Información Detallada -->
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <button class="btn btn-warning" data-toggle="modal" data-target="#infoDetalladaModal">Información Detallada</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <!-- /.Main content -->
</div>
<!-- /.content-wrapper -->

<!-- Modal Información General -->
<div class="modal fade" id="infoGeneralModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"><strong>Información General</strong></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p><strong>Empresa:</strong> Sistema de Ventas Web</p>
                <p><strong>Descripción de Productos:</strong> El sistema se especializa en la venta de productos de consumo, incluyendo dulces, lácteos y refrescos.</p>
                <p><strong>Requisitos del Sistema:</strong></p>
                <ul>
                    <li><strong>Navegador compatible:</strong> Se recomienda el uso de Google Chrome.</li>
                    <li><strong>Conexión a Internet estable.</strong></li>
                </ul>
                <p><strong>Historial de Actualizaciones:</strong></p>
                <p>Versión 0.23 (Primera versión): aun no se actualizo por ser su creacion inicial</p>
                <p><strong>Agradecimientos por las colaboraciones a:</strong></p>
                <p>Santos, Elton e Idol, Docente de TEM-2 y compañeros de 8D.</p>
                <p><strong>Redes Sociales:</strong></p>
                <ul>
                    <li><strong>WhatsApp:</strong> <a href="https://wa.link/ztmop7" target="_blank">https://wa.link/ztmop7</a></li>
                    <li><strong>Github:</strong> <a href="https://github.com/Elton/proyectoFinal" target="_blank">https://github.com/Marco-T2/proyectoFinal-TEM2</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Modal Información Detallada -->
<div class="modal fade" id="infoDetalladaModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"><strong>Información Detallada</strong></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p><strong>Datos de Contacto:</strong></p>
                <ul>
                    <li> 17isantf@gmail.com</li>
                    <li> elton@gmail.com</li>
                    <li> idol@gmail.com</li>
                </ul>
                <p><strong>Equipo de Personas:</strong></p>
                <ul>
                    <li> Santos Ysrrael Tarqui Fernandez</li>
                    <li> Elton Laura Rojas</li>
                    <li> Randol Idol Loza Cahuaya</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<jsp:include page="WEB-INF/footer.jsp"/> 
<%} else {
        response.sendRedirect("login.jsp");
    }
%>