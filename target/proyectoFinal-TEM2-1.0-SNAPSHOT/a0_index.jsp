

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuario") != null) {

%>
<jsp:include page="WEB-INF/header.jsp"/>

<jsp:include page="WEB-INF/sidebarMenu.jsp">
    <jsp:param name="opcion" value="a0_index"/>
</jsp:include>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">

    </div>
    <!-- /.content-header -->
    <!-- Main content -->
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <c:set var="stotal" value="0" />
                <c:forEach items="${compras}" var="valor">
                    <c:set var="stotal" value="${stotal + valor}" />
                </c:forEach>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="small-box bg-primary">
                        <div class="inner">
                            <h4 style="font-size:17px;">
                                <strong>Bs./ ${stotal}</strong>
                            </h4>
                            <p>Compras</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-bag"></i>
                        </div>
                        <a href="IngresoControlador" class="small-box-footer">Compras <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
                <c:set var="suma" value="0" />
                <c:forEach items="${ventas}" var="numero">
                    <c:set var="suma" value="${suma + numero}" />
                </c:forEach>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="small-box bg-green">
                        <div class="inner">
                            <h4 style="font-size:17px;">
                                <strong>Bs./ ${suma}</strong>
                            </h4>
                            <p>Ventas</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-bag"></i>
                        </div>
                        <a href="B1_VentaControlador" class="small-box-footer">Ventas <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header border-0">
                            <div class="d-flex justify-content-between">
                                <h3 class="card-title">Compras realializadas por mes </h3>
                            </div>
                        </div>
                        <div class="card-body">
                            <!-- /.d-flex -->
                            <div class="position-relative mb-4">
                                <canvas id="compras" height="200"></canvas>
                            </div>

                        </div>
                    </div>
                    <!-- /.card -->



                    <!-- /.card -->
                    <div class="card">
                        <div class="card-header border-0">
                            <h3 class="card-title">Stock de los productos</h3>
                            <div class="card-tools">
                                <a href="#" class="btn btn-tool btn-sm">
                                    <i class="fas fa-download"></i>
                                </a>
                                <a href="#" class="btn btn-tool btn-sm">
                                    <i class="fas fa-bars"></i>
                                </a>
                            </div>
                        </div>
                        <div class="card-body table-responsive p-0">
                            <table class="table table-striped table-valign-middle">
                                <thead>
                                    <tr>
                                        <th>Id</th>
                                        <th>Nombre de producto</th>
                                        <th>Stock</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${stockA}">
                                        <tr class="odd">
                                            <td>${item.idarticulo}</td>
                                            <td><img src="dist/img/default-150x150.png" alt="Product 1" class="img-circle img-size-32 mr-2">${item.nombre}</td>
                                            <td>${item.stock} Unidades</td>
                                        </tr>                                                                   
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col-md-6 bien -->
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header border-0">
                            <div class="d-flex justify-content-between">
                                <h3 class="card-title">Ventas por mes</h3>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="position-relative mb-4">
                                <canvas id="ventas" height="200"></canvas>
                            </div>

                        </div>
                    </div>

                    <div class="card">
                        <div class="card-header border-0">
                            <h3 class="card-title">Los productos mas vendidos</h3>
                            <div class="card-tools">
                                <a href="#" class="btn btn-tool btn-sm">
                                    <i class="fas fa-download"></i>
                                </a>
                                <a href="#" class="btn btn-tool btn-sm">
                                    <i class="fas fa-bars"></i>
                                </a>
                            </div>
                        </div>
                        <div class="card-body table-responsive p-0">
                            <table class="table table-striped table-valign-middle">
                                <thead>
                                    <tr>
                                        <th>Producto</th>
                                        <th>Precio</th>
                                        <th>Cantidad</th>
                                        <th>Precio Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${masVendido}">
                                        <tr class="odd">
                                            <td><img src="dist/img/default-150x150.png" alt="Product 1" class="img-circle img-size-32 mr-2">${item.articulo}</td>
                                            <td>Bs./ ${item.precio_venta}</td>
                                            <td>
                                                <small class="text-success mr-1">
                                                    <i class="fas fa-arrow-up"></i>
                                                    ${item.cantidad}%
                                                </small>
                                                ${item.cantidad} Unidades
                                            </td>
                                            <td>${item.subtotal}</td>
                                        </tr>                                                                   
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- /.card -->
                    <!--Fin de columna-->
                </div>
                <!-- /.col-md-6 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container-fluid -->
    </div>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->
<!-- Main Footer -->
<jsp:include page="WEB-INF/footer.jsp"/>

<script type="text/javascript">
    var ctx = document.getElementById("ventas").getContext('2d');
    var compras = new Chart(ctx, {
    type: 'bar',
            data: {
            labels: [<c:forEach items="${meses}" var="mes" varStatus="status">
            '${mes}'<c:if test="${!status.last}">,</c:if>
    </c:forEach>],
                    datasets: [{
                    label:'Ventas por mes en Bs.',
                            data: [<c:forEach items="${ventas}" var="item" varStatus="status">
        ${item}<c:if test="${!status.last}">,</c:if>
    </c:forEach>],
                            backgroundColor: [
                                    'rgba(255, 99, 132, 0.2)',
                                    'rgba(54, 162, 235, 0.2)',
                                    'rgba(255, 206, 86, 0.2)',
                                    'rgba(75, 192, 192, 0.2)',
                                    'rgba(153, 102, 255, 0.2)',
                                    'rgba(255, 159, 64, 0.2)',
                                    'rgba(255, 99, 132, 0.2)',
                                    'rgba(54, 162, 235, 0.2)',
                                    'rgba(255, 206, 86, 0.2)',
                                    'rgba(75, 192, 192, 0.2)'
                            ],
                            borderColor: [
                                    'rgba(255,99,132,1)',
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(255, 206, 86, 1)',
                                    'rgba(75, 192, 192, 1)',
                                    'rgba(153, 102, 255, 1)',
                                    'rgba(255, 159, 64, 1)',
                                    'rgba(255,99,132,1)',
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(255, 206, 86, 1)',
                                    'rgba(75, 192, 192, 1)'
                            ],
                            borderWidth: 1
                    }]
            },
            options: {
            scales: {
            yAxes: [{
            ticks: {
            beginAtZero:true
            }
            }]
            }
            }
    });
    var ctx = document.getElementById("compras").getContext('2d');
    var ventas = new Chart(ctx, {
    type: 'bar',
            data: {
            labels: [<c:forEach items="${mescompra}" var="mesc" varStatus="status">
            '${mesc}'<c:if test="${!status.last}">,</c:if>
    </c:forEach>],
                    datasets: [{
                    label: 'Compras en Bs./ por Mes',
                            data: [<c:forEach items="${compras}" var="compra" varStatus="status">
        ${compra}<c:if test="${!status.last}">,</c:if>
    </c:forEach>],
                            backgroundColor: [
                                    'rgba(255, 99, 132, 0.2)',
                                    'rgba(54, 162, 235, 0.2)',
                                    'rgba(255, 206, 86, 0.2)',
                                    'rgba(75, 192, 192, 0.2)',
                                    'rgba(153, 102, 255, 0.2)',
                                    'rgba(255, 159, 64, 0.2)',
                                    'rgba(255, 99, 132, 0.2)',
                                    'rgba(54, 162, 235, 0.2)',
                                    'rgba(255, 206, 86, 0.2)',
                                    'rgba(75, 192, 192, 0.2)'
                            ],
                            borderColor: [
                                    'rgba(255,99,132,1)',
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(255, 206, 86, 1)',
                                    'rgba(75, 192, 192, 1)',
                                    'rgba(153, 102, 255, 1)',
                                    'rgba(255, 159, 64, 1)',
                                    'rgba(255,99,132,1)',
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(255, 206, 86, 1)',
                                    'rgba(75, 192, 192, 1)'
                            ],
                            borderWidth: 1
                    }]
            },
            options: {
            scales: {
            yAxes: [{
            ticks: {
            beginAtZero:true
            }
            }]
            }
            }
    });
</script>

<%    } else {
        response.sendRedirect("login.jsp");
    }
%>
