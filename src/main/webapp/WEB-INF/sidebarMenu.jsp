<%
    String opcion = request.getParameter("opcion");
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Sidebar -->
<div class="sidebar">

    <!-- Sidebar user panel (optional) USUARIO MASCULINO -->
    <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
            <img src="https://www.show.news/__export/1567201752167/sites/debate/img/2019/08/30/gato_png_crop1567201738546.jpg_839202635.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
            <a href="#" class="d-block">${usuario.nombre}-${usuario.rolC.nombre}</a>
        </div>
    </div>


    <!-- Sidebar Menu -->
    <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
            <!-- Add icons to the links using the .nav-icon class
                 with font-awesome or any other icon font library -->

            <li class="nav-item">
                <a href="A0_IndexControlador" class="nav-link">
                    <i class="nav-icon fas fa-th"></i>
                    <p>
                        Inicio
                        <span class="right badge badge-danger">New</span>
                    </p>
                </a>
            </li>


            <li class="nav-item">
                <a href="#" class="nav-link">
                    <i class="nav-icon fas fa-chart-pie"></i>
                    <p>
                        Ventas
                        <i class="right fas fa-angle-left"></i>
                    </p>
                </a>
                <ul class="nav nav-treeview">
                    <li class="nav-item">
                        <a href="B1_VentaControlador" class="nav-link">
                            <i class="far fa-circle nav-icon"></i>
                            <p>Ventas</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="B2_ClienteControlador" class="nav-link <%=(opcion.equals("clientes") ? "active" : "")%>">
                            <i class="far fa-circle nav-icon"></i>
                            <p>Clientes</p>
                        </a>
                    </li>
                </ul>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <i class="nav-icon fas fa-tree"></i>
                    <p>
                        Compras
                        <i class="fas fa-angle-left right"></i>
                    </p>
                </a>
                <ul class="nav nav-treeview">
                    <li class="nav-item">
                        <a href="IngresoControlador" class="nav-link">
                            <i class="far fa-circle nav-icon"></i>
                            <p>Compras</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="C2_ProveedorControlador" class="nav-link">
                            <i class="far fa-circle nav-icon"></i>
                            <p>Proveedores</p>
                        </a>
                    </li>
                </ul>
            </li>
            <!--inicio de almacen-->
            <c:set var="variable2" value="${usuario.rolC.nombre}"/>
            <c:if test="${variable2 == 'Administrador'||variable2 == 'Técnico'}">
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-edit"></i>
                        <p>
                            Almacen
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="D1_ArticuloControlador" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Articulos</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="D2_CategoriaControlador" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Categorias</p>
                            </a>
                        </li>
                    </ul>
                </li>
            </c:if>
            <!--fin de almacen-->
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <i class="nav-icon fas fa-table"></i>
                    <p>
                        Reportes
                        <i class="fas fa-angle-left right"></i>
                    </p>
                </a>
                <ul class="nav nav-treeview">
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="far fa-circle nav-icon"></i>
                            <p>Consultas Ventas</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="far fa-circle nav-icon"></i>
                            <p>Consultas Compras</p>
                        </a>
                    </li>
                </ul>
            </li>
            <li class="nav-header">OTRAS OPCIONES</li>
            <li class="nav-item">
                <a href="AyudaControlador" class="nav-link">
                    <i class="nav-icon fas fa-calendar-alt"></i>
                    <p>
                        Ayuda
                        <span class="badge badge-info right">2</span>
                    </p>
                </a>
            </li>
            <li class="nav-item">
                <a href="AcercaControlador" class="nav-link">
                    <i class="nav-icon far fa-image"></i>
                    <p>
                        Acerca De..
                    </p>
                </a>
            </li>
            <c:if test="${usuario.rolC.nombre == 'Administrador'}">
                <li class="nav-header">CONFIGURACIONES</li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-circle"></i>
                        <p>
                            Accesos
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="H1_UsuarioControlador" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Usuarios</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="RolControlador" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Rol</p>
                            </a>
                        </li>
                    </ul>
                </li>


                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-circle"></i>
                        <p>
                            Auditoria
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="AuditoriaControlador?action=view1" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Auditoria Ventas</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="AuditoriaControlador?action=view2" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Auditoria Compras</p>
                            </a>
                        </li>
                    </ul>
                </li>
            </c:if>
        </ul>
    </nav>
    <!-- /.sidebar-menu -->
</div>
<!-- /.sidebar -->
</aside>