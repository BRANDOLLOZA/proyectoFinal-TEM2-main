<%
    if (session.getAttribute("usuario") != null) {

%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="WEB-INF/header.jsp"/>

<jsp:include page="WEB-INF/sidebarMenu.jsp">
    <jsp:param name="opcion" value="b2_clientes"/>
</jsp:include>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Clientes</h1>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Ventas</a></li>
                        <li class="breadcrumb-item active">Clientes</li>
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
                                <h3 class="card-title">Tabla de clientes</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body"> 
                                <div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                    <div class="row">
                                        <div class="col-sm-12 col-md-6">
                                            <div class="dt-buttons btn-group flex-wrap">
                                                <a href="B2_ClienteControlador?action=view">
                                                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#modal-lg">
                                                        Regresar
                                                    </button>
                                                </a>
                                            </div>                                                            
                                        </div>    
                                    </div>                                                    
                                    <form class="needs-validation" novalidate action="B2_ClienteControlador" method="post" >
                                        <input type="hidden" name="idpersona" value="${cliente.idpersona}">

                                        <div class="card-body">
                                            <div class="form-group">
                                                <label>Tipo persona</label>
                                                <input  type="text" name="tipo_persona" value="${cliente.tipo_persona != null ? 'Cliente' : cliente.tipo_persona}" class="form-control"  readonly>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label for="nameId" class="form-label">Nombre Apellido</label>
                                                        <input type="text" name="nombre" value="${cliente.nombre}" class="form-control" id="nameId" required placeholder="Ingresa el nombre">
                                                       <!-- <div class="valid-feedback">Dodo bien</div>-->
                                                        <div class="invalid-feedback">Es obligatorio ingresar el nombre de cliente </div>
                                                    </div>

                                                </div>
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Cédula de Identidad</label>
                                                        <input type="number" name="ci_documento" value="${cliente.ci_documento}" class="form-control" required placeholder="Ingresa tu CI">
                                                        <div class="invalid-feedback">Ingresa Cédula de Identidad</div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Direccion</label>
                                                        <input type="text" name="direccion" value="${cliente.direccion}" class="form-control" required placeholder="Ingresa el departamento">
                                                        <div class="invalid-feedback">Ingresa direción</div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Teléfono</label>
                                                        <input type="number" name="telefono" value="${cliente.telefono}" class="form-control" required placeholder="Ingresa Nro telefono o Celular">
                                                         <div class="invalid-feedback">Ingresa teléfono del cliente</div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- text input -->
                                            <div class="form-group">
                                                <label>Correo</label>
                                                <input type="email" name="email" value="${cliente.email}" class="form-control" required placeholder="Ingresa tu correo">
                                                 <div class="invalid-feedback">Ingresa correo del cliente</div>
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
<script>
    // Example starter JavaScript for disabling form submissions if there are invalid fields
    (function () {
        'use strict'

        // Fetch all the forms we want to apply custom Bootstrap validation styles to
        var forms = document.querySelectorAll('.needs-validation')

        // Loop over them and prevent submission
        Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }

                        form.classList.add('was-validated')
                    }, false)
                })
    })()
</script>
<%} else {
        response.sendRedirect("login.jsp");
    }
%>