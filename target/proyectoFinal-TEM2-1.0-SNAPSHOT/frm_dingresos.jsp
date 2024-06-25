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
                    <h1 class="m-0">Ingresos</h1>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Ingresos</a></li>
                        <li class="breadcrumb-item active">Ingreso</li>
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
                                <h3 class="card-title">Listado de detalle de compras</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                    <div class="row">
                                        <div class="col-sm-12 col-md-6">
                                            <div class="dt-buttons btn-group flex-wrap">
                                                <a href="IngresoControlador" >
                                                    <button type="button" class="btn btn-success">Regresar</button>
                                                </a>
                                            </div>
                                            &nbsp;
                                            <a href="IngresoControlador?action=repDetalleCompra&idingreso=${ingreso.idingreso}" target="_blank">

                                                <button type="button" class="btn btn-warning">
                                                    <i class="fa fa-file" aria-hidden="true"></i> Descargar PDF
                                                    <i class="fa fa-arrow-down" aria-hidden="true"></i>
                                                </button>
                                            </a>
                                        </div>
                                    </div>
                                    <form action="IngresoControlador" method="post">
                                        <input type="hidden" name="idventa" value="${ingreso.idingreso}">

                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="form-group">
                                                        <label for="" class="form-label">Proveedor</label>
                                                        <select disabled name="idproveedor" class="form-control">
                                                            <option value="">${ingreso.proveedor}</option>

                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Fecha</label>
                                                        <input disabled type="date" name="fecha_hora" value="${ingreso.fecha_hora}" class="form-control" placeholder="Ingresa fecha">
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <div class="form-group">
                                                        <label>Tipo Comprobante(*):</label>
                                                        <input disabled type="text"  value="${ingreso.tipo_comprobante}" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="col-sm-4">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Serie</label>
                                                        <input disabled type="text" name="serie_comprobante" value="${ingreso.serie_comprobante}" class="form-control" placeholder="Ingresa serie de comprobante">
                                                    </div>
                                                </div>
                                                <div class="col-sm-4">
                                                    <!-- text input -->
                                                    <div class="form-group">
                                                        <label>Número</label>
                                                        <input disabled type="text" name="num_comprobante" value="${ingreso.num_comprobante}" class="form-control" placeholder="Ingresa número">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12 col-sm-12 col-md-12 col-xs-12">
                                                <table id="detalles" class="table table-striped table-bordered table-condensed table-hover">
                                                    <thead style="background-color:#A9D0F5">
                                                    <th>id</th>
                                                    <th>Articuculo</th>
                                                    <th>Cantidad</th>
                                                    <th>Precio compra</th>
                                                    <th>Precio venta</th>
                                                    <th>Sub total</th>
                                                    </thead>
                                                    <c:forEach var="item" items="${d_ingresos}">
                                                        <tr>
                                                            <td>${item.idingreso}</td>
                                                            <td>${item.articulo}</td>
                                                            <td>${item.cantidad}</td>
                                                            <td>${item.precio_compra}</td>
                                                            <td>${item.precio_venta}</td>
                                                            <td>${item.subtotal}</td>
                                                        </tr>                                                              
                                                    </c:forEach>
                                                    <tfoot>
                                                    <th colspan="5">TOTAL</th>
                                                    <th>Bs. ${ingreso.total_compra}</th> 
                                                    </tfoot>
                                                    <tbody>

                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="modal-footer justify-content-between">
                                            <a href="IngresoControlador?action=view">
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

<jsp:include page="WEB-INF/footer.jsp"/> 
<%} else {
        response.sendRedirect("login.jsp");
    }
%>