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
                    <h1 class="m-0">Usuarios</h1>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="H1_UsuarioControlador?action=view">Usuario</a></li>
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
                                <h3 class="card-title">Crear nuevo usuario</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body"> 
                                <div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                    <div class="row">
                                        <div class="col-sm-12 col-md-6">
                                            <div class="dt-buttons btn-group flex-wrap">
                                                <a href="H1_UsuarioControlador?action=view">
                                                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#modal-lg">
                                                        Regresar
                                                    </button>
                                                </a>
                                            </div>                                                            
                                        </div>    
                                    </div>                                                    
                                    <form class="needs-validation" novalidate action="H1_UsuarioControlador" method="post">
                                        <input type="hidden" name="idusuario" value="${usuario.idusuario}">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Nombres y Apellidos</label>
                                                        <input required type="text" name="nombre" value="${usuario.nombre}" class="form-control" placeholder="Ingresa el nombre">
                                                        <div class="invalid-feedback">Ingresar Nombre de usuario</div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Carnet de Identidad</label>
                                                        <input required type="number" name="ci_documento" value="${usuario.ci_documento}" class="form-control" placeholder="Ingresa tu CI">
                                                        <div class="invalid-feedback">Ingresar Cédula de Identidad del usuairo</div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Email</label>
                                                        <input required type="email" name="email" value="${usuario.email}" class="form-control" placeholder="Ingresa el email">
                                                        <div class="invalid-feedback">Ingresar correo</div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Cargo</label>
                                                        <input required type="text" name="cargo" value="${usuario.cargo}" class="form-control" placeholder="Ingresa Cargo que ocupa">
                                                        <div class="invalid-feedback">Ingresar cargo</div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Usuario</label>
                                                        <input required type="text" name="login" value="${usuario.login}" class="form-control" placeholder="Ingresa el usuario">
                                                        <div class="invalid-feedback">Ingresar usuario</div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Contraseña</label>
                                                        <input required type="password" name="clave" value="${usuario.clave}" class="form-control" placeholder="Ingresa una contraseña">
                                                        <div class="invalid-feedback">Ingresar Contraseña</div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="" class="form-label">Rol</label>
                                                <select required name="idrol" class="form-control">
                                                    <option value="">--Seleccione--</option>
                                                    <c:forEach var="item" items="${lista_roles}">
                                                        <option value="${item.idrol}" 
                                                                <c:if test="${usuario.idrol== item.idrol}">
                                                                    selected
                                                                </c:if>
                                                                >${item.nombre}</option>                            
                                                    </c:forEach>
                                                </select>
                                                <div class="invalid-feedback">Seleccionar Rol de usuario</div>
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
     //script de validadcion
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
    // fin de escript de validacion
    </script>
<%}else{
response.sendRedirect("login.jsp");
    }
%>