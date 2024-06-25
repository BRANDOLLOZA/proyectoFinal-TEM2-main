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
    <!-- Main content -->
    <br
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
                                <form class="needs-validation" novalidate action="B1_VentaControlador" method="post">
                                    <input type="hidden" name="idventa" value="${venta.idventa}">

                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <input type="hidden"name="idusuario" value="${usuario.idusuario}">
                                                <div class="form-group">
                                                    <label for="" class="form-label">Cliente</label>
                                                    <select required name="idcliente" class="form-control">
                                                        <option value="">--Seleccione--</option>
                                                        <c:forEach var="item" items="${lista_clientes}">
                                                            <option value="${item.idpersona}" 
                                                                    <c:if test="${venta.idcliente== item.idpersona}">
                                                                        selected
                                                                    </c:if>
                                                                    >${item.nombre}</option>                            
                                                        </c:forEach>
                                                    </select>
                                                    <div class="invalid-feedback">Seleccionar un cliente </div>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <!-- text input -->
                                                <div class="form-group">
                                                    <label>Fecha</label>
                                                    <input type="date" name="fecha_hora" value="${venta.fecha_hora}" class="form-control" required placeholder="Ingresa fecha">
                                                    <div class="invalid-feedback">Seleccionar una fecha </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>Tipo Comprobante(*):</label>
                                                    <select required name="tipo_comprobante" id="tipo_comprobante" class="form-control selectpicker" required="">
                                                        <option value="">--Seleccione--</option>
                                                        <option value="Boleta">Boleta</option>
                                                        <option value="Factura">Factura</option>
                                                        <option value="Ticket">Ticket</option>
                                                    </select>
                                                    <div class="invalid-feedback">Seleccionar tipo de comprobante </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <!-- text input -->
                                                <div class="form-group">
                                                    <label>Serie</label>
                                                    <input type="text" name="serie_comprobante" value="${venta.serie_comprobante}" class="form-control" required placeholder="Ingresa serie de comprobante">
                                                    <div class="invalid-feedback">Ingresar serie de comprobante </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <!-- text input -->
                                                <div class="form-group">
                                                    <label>Número</label>
                                                    <input type="numeric" name="num_comprobante" value="${venta.num_comprobante}" class="form-control"required placeholder="Ingresa número">
                                                    <div class="invalid-feedback">Ingresar numero de comprobante </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <a data-toggle="modal" href="#myModal">           
                                                <button id="btnAgregarArt" type="button" class="btn btn-primary"> <span class="fa fa-plus"></span> Agregar Artículos</button>
                                            </a>
                                        </div>

                                        <div class="col-lg-12 col-sm-12 col-md-12 col-xs-12">
                                            <table id="detalles" class="table table-striped table-bordered table-condensed table-hover">
                                                <thead style="background-color:#A9D0F5">
                                                <th>Opciones</th>
                                                <th>Artículo</th>
                                                <th>Cantidad</th>
                                                <th>Precio Venta</th>
                                                <th>Descuento</th>
                                                <th>Sub Total </th>
                                                <th></th>
                                                </thead>
                                                <tfoot>
                                                <th>TOTAL</th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>

                                                <th><h4 id="total">Bs</h4><input type="hidden" name="total_venta" id="total_venta"></th> 
                                                </tfoot>
                                                <tbody>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="modal-footer justify-content-between">
                                        <button class="btn btn-primary" type="submit" id="btnGuardar"><i class="fa fa-save"></i> Guardar</button>
                                        <a href="B1_VentaControlador?action=view">
                                            <button id="btnCancelar" class="btn btn-danger" type="button"><i class="fa fa-arrow-circle-left"></i> Cancelar</button>
                                        </a>
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
<!-- MODAL inicio -->
<div class="modal fade" id="myModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Informacion cliente</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="card-body">
                    <table id="example1" class="table table-bordered table-striped dataTable dtr-inline" aria-describedby="example1_info">
                        <thead>
                            <tr>
                                <th sorting_asc" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">ID</th>
                                <th tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">Nombre</th>
                                <th tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">Categoria</th>
                                <th tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending">Codigo</th>
                                <th tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending">Stock</th>
                                <th tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">Precio Venta</th>
                                <th tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">Operación</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${articulos}">
                                <tr class="odd">
                                    <td class="dtr-control sorting_1" tabindex="0">${item.idarticulo}</td>
                                    <td>${item.nombre}</td>
                                    <td>${item.categoria}</td>
                                    <td>${item.codigo}</td>
                                    <td>${item.stock}</td>
                                    <td>${item.precio_venta}</td>
                                    <td><button id="btn" class="btn btn-success" onclick="agregarDetalle(${item.idarticulo}, '${item.nombre}', ${item.precio_venta})"><ion-icon name="add"></ion-icon> Agregar</button></td>
                                </tr>                                                                   
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
</div>
<!-- MODAL fin -->

<jsp:include page="WEB-INF/footer.jsp"/>
<script>
    $(document).ready(function () {
        $('#example1').DataTable();
    });

    var cont = 0;
    function agregarDetalle(idarticulo, articulo, precio_venta)
    {
        var cantidad = 1;
        var descuento = 0;

        if (idarticulo != "")
        {
            var subtotal = cantidad * precio_venta;
            var fila = '<tr class="filas" id="fila' + cont + '">' +
                    '<td><button type="button" class="btn btn-danger" onclick="eliminarDetalle(' + cont + ')">X</button></td>' +
                    '<td><input type="hidden" name="idarticulo[]" value="' + idarticulo + '">' + articulo + '</td>' +
                    '<td><input type="number" name="cantidad[]" id="cantidad[]" value="' + cantidad + '"></td>' +
                    '<td><input type="number" name="precio_venta[]" id="precio_venta[]" value="' + precio_venta + '"></td>' +
                    '<td><input type="number" name="descuento[]" value="' + descuento + '"></td>' +
                    '<td><span name="subtotal" id="subtotal' + cont + '">' + subtotal + '</span></td>' +
                    '<td><button type="button" onclick="modificarSubototales()" class="btn btn-info"><ion-icon name="logo-ionic"></ion-icon></button></td>' +
                    '</tr>';
            cont++;
            detalles = detalles + 1;
            $('#detalles').append(fila);
            // modificarSubototales();
        } else
        {
            alert("Error al ingresar el detalle, revisar los datos del artículo");
        }
    }

    function modificarSubototales()
    {
        var cant = document.getElementsByName("cantidad[]");
        var prec = document.getElementsByName("precio_venta[]");
        var desc = document.getElementsByName("descuento[]");
        var sub = document.getElementsByName("subtotal");

        for (var i = 0; i < cant.length; i++) {
            var inpC = cant[i];
            var inpP = prec[i];
            var inpD = desc[i];
            var inpS = sub[i];

            inpS.value = (inpC.value * inpP.value) - inpD.value;
            document.getElementsByName("subtotal")[i].innerHTML = inpS.value;
        }
        calcularTotales();

    }

    function calcularTotales() {
        var sub = document.getElementsByName("subtotal");
        var total = 0.0;

        for (var i = 0; i < sub.length; i++) {
            total += document.getElementsByName("subtotal")[i].value;
        }
        $("#total").html("Bs/. " + total);
        $("#total_venta").val(total);
        evaluar();
    }

    function evaluar() {
        if (detalles > 0)
        {
            $("#btnGuardar").show();
        } else
        {
            $("#btnGuardar").show();
            cont = 0;
        }
    }

    function eliminarDetalle(indice) {
        $("#fila" + indice).remove();
        calcularTotales();
        detalles = detalles - 1;
        evaluar()
    }
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

<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }
%>


