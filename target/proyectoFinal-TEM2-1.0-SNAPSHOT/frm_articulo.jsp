<%
    if(session.getAttribute("usuario")!=null){
    
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="WEB-INF/header.jsp"/>
<jsp:include page="WEB-INF/sidebarMenu.jsp">
    <jsp:param name="opcion" value="articulo"/>
</jsp:include>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Articulos</h1>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="D1_ArticuloControlador?action=view">Articulos</a></li>
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
                                <h3 class="card-title">Crear nuevo articulo</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body"> 
                                <div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                    <div class="row">
                                        <div class="col-sm-12 col-md-6">
                                                <a href="D1_ArticuloControlador?action=view">
                                                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#modal-lg">
                                                        Regresar
                                                    </button>
                                                </a>                                                          
                                        </div>    
                                    </div>                                                    
                                    <form class="needs-validation" novalidate action="D1_ArticuloControlador" method="post">
                                        <input type="hidden" name="idarticulo" value="${articulo.idarticulo}">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Código</label>
                                                        <input required type="text" name="codigo" value="${articulo.codigo}" class="form-control" placeholder="Ingresa código">
                                                        <div class="invalid-feedback">Ingresar código del producto</div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Nombre de artículo</label>
                                                        <input required type="text" name="nombre" value="${articulo.nombre}" class="form-control" placeholder="Ingresa nombre de artículo">
                                                        <div class="invalid-feedback">Ingresar nombre del producto</div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Stock</label>
                                                        <input required type="numeric" name="stock" value="${articulo.stock}" class="form-control" placeholder="Ingresa el stock">
                                                        <div class="invalid-feedback">Ingresar stock del producto</div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Descripcion</label>
                                                        <input required type="text" name="descripcion" value="${articulo.descripcion}" class="form-control" placeholder="Ingresa una descripción">
                                                        <div class="invalid-feedback">Ingresar descripción del producto</div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label>Categoria</label>
                                                <select required name="idcategoria" class="form-control">
                                                    <option value="">--Seleccione--</option>
                                                    <c:forEach var="item" items="${lista_categorias}">
                                                        <option value="${item.idcategoria}" 
                                                                <c:if test="${articulo.idcategoria== item.idcategoria}">
                                                                    selected
                                                                </c:if>
                                                                >${item.nombre}</option>                            
                                                    </c:forEach>
                                                </select>
                                                <div class="invalid-feedback">Seleccionar categoria del producto</div>
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