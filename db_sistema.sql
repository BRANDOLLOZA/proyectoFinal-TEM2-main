-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-06-2024 a las 20:28:06
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_sistema`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE `articulo` (
  `idarticulo` int(11) NOT NULL,
  `idcategoria` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `articulo`
--

INSERT INTO `articulo` (`idarticulo`, `idcategoria`, `codigo`, `nombre`, `stock`, `descripcion`, `imagen`, `condicion`) VALUES
(1, 1, '12345', 'Leche', 16, 'dasfkjl', '1686661105.png', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idcategoria`, `nombre`, `descripcion`, `condicion`) VALUES
(1, 'Lacteos', 'todo tipo de lacteos', 1),
(3, 'Carnes', 'Todo tipo de carnes', 1),
(4, 'Fideos', 'Todo tipo de fideos', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ingreso`
--

CREATE TABLE `detalle_ingreso` (
  `iddetalle_ingreso` int(11) NOT NULL,
  `idingreso` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_compra` decimal(11,2) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `detalle_ingreso`
--

INSERT INTO `detalle_ingreso` (`iddetalle_ingreso`, `idingreso`, `idarticulo`, `cantidad`, `precio_compra`, `precio_venta`) VALUES
(1, 1, 1, 10, 10.00, 15.00);

--
-- Disparadores `detalle_ingreso`
--
DELIMITER $$
CREATE TRIGGER `actualizado_detalle_ingresoAuditoria` AFTER UPDATE ON `detalle_ingreso` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO detalle_ingresoAuditoria (iddetalle_ingreso,idingreso,idarticulo,cantidad,precio_compra,precio_venta,usuarioAud,fechaAud,estadoAud)
    VALUES (OLD.iddetalle_ingreso,OLD.idingreso, OLD.idarticulo,OLD.cantidad,OLD.precio_compra,OLD.precio_venta,usuarioAud,fecha_actual, 'ACTUALIZADO');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `eliminar_detalle_ingresoAuditoria` BEFORE DELETE ON `detalle_ingreso` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO detalle_ingresoAuditoria (iddetalle_ingreso,idingreso,idarticulo,cantidad,precio_compra,precio_venta,usuarioAud,fechaAud,estadoAud)
    VALUES (OLD.iddetalle_ingreso,OLD.idingreso, OLD.idarticulo,OLD.cantidad,OLD.precio_compra,OLD.precio_venta,usuarioAud, fecha_actual,'ELIMINADO');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `nuevo_detalle_ingresoAuditoria` AFTER INSERT ON `detalle_ingreso` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO detalle_ingresoAuditoria (iddetalle_ingreso,idingreso,idarticulo,cantidad,precio_compra,precio_venta,usuarioAud,fechaAud,estadoAud)
    VALUES (NEW.iddetalle_ingreso, NEW.idingreso, NEW.idarticulo,NEW.cantidad,NEW.precio_compra,NEW.precio_venta,usuarioAud,fecha_actual,'NUEVO');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_updStockIngreso` AFTER INSERT ON `detalle_ingreso` FOR EACH ROW BEGIN
 UPDATE articulo SET stock = stock + NEW.cantidad 
 WHERE articulo.idarticulo = NEW.idarticulo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ingresoauditoria`
--

CREATE TABLE `detalle_ingresoauditoria` (
  `iddetalle_ingreso` int(11) NOT NULL,
  `idingreso` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_compra` decimal(11,2) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `usuarioAud` varchar(20) NOT NULL,
  `fechaAud` datetime NOT NULL,
  `estadoAud` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `detalle_ingresoauditoria`
--

INSERT INTO `detalle_ingresoauditoria` (`iddetalle_ingreso`, `idingreso`, `idarticulo`, `cantidad`, `precio_compra`, `precio_venta`, `usuarioAud`, `fechaAud`, `estadoAud`) VALUES
(1, 1, 1, 10, 10.00, 15.00, 'root@localhost', '2024-06-18 02:18:25', 'NUEVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `iddetalle_venta` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`iddetalle_venta`, `idventa`, `idarticulo`, `cantidad`, `precio_venta`, `descuento`) VALUES
(1, 1, 1, 10, 20.00, 0.00),
(2, 2, 1, 3, 45.00, 0.00),
(3, 2, 1, 1, 45.00, 0.00);

--
-- Disparadores `detalle_venta`
--
DELIMITER $$
CREATE TRIGGER `actualizado_detalle_ventaAuditoria` AFTER UPDATE ON `detalle_venta` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO detalle_ventaauditoria (iddetalle_venta, idventa, idarticulo, cantidad, precio_venta, descuento,usuarioAud,fechaAud,estadoAud)
    VALUES (OLD.iddetalle_venta, OLD.idventa, OLD.idarticulo,OLD.cantidad,OLD.precio_venta,OLD.descuento,usuarioAud, fecha_actual, 'ACTUALIZADO');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `eliminar_detalle_ventaAuditoria` BEFORE DELETE ON `detalle_venta` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO detalle_ventaauditoria (iddetalle_venta, idventa, idarticulo, cantidad, precio_venta, descuento,usuarioAud,fechaAud,estadoAud)
    VALUES (OLD.iddetalle_venta, OLD.idventa, OLD.idarticulo,OLD.cantidad,OLD.precio_venta,OLD.descuento,usuarioAud, fecha_actual, 'ELIMINADO');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `nuevo_detalle_ventaAuditoria` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO detalle_ventaauditoria (iddetalle_venta, idventa, idarticulo, cantidad, precio_venta, descuento,usuarioAud,fechaAud,estadoAud)
    VALUES (NEW.iddetalle_venta, NEW.idventa, NEW.idarticulo,NEW.cantidad,NEW.precio_venta,NEW.descuento,usuarioAud, fecha_actual,'NUEVO');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_updStockVenta` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
 UPDATE articulo SET stock = stock - NEW.cantidad 
 WHERE articulo.idarticulo = NEW.idarticulo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ventaauditoria`
--

CREATE TABLE `detalle_ventaauditoria` (
  `iddetalle_venta` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) NOT NULL,
  `usuarioAud` varchar(20) NOT NULL,
  `fechaAud` datetime NOT NULL,
  `estadoAud` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso`
--

CREATE TABLE `ingreso` (
  `idingreso` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `total_compra` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `ingreso`
--

INSERT INTO `ingreso` (`idingreso`, `idproveedor`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `total_compra`, `estado`) VALUES
(1, 17, 1, 'Factura', '0002', '22352', '2024-05-15 00:00:00', 100.00, 'Aceptado');

--
-- Disparadores `ingreso`
--
DELIMITER $$
CREATE TRIGGER `actualizado_ingresoAuditoria` AFTER UPDATE ON `ingreso` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO ingresoAuditoria (idingreso, idproveedor, idusuario, tipo_comprobante, serie_comprobante, num_comprobante,fecha_hora,total_compra,estado,usuarioAud,fechaAud,estadoAud)
    VALUES (OLD.idingreso, OLD.idproveedor, OLD.idusuario,OLD.tipo_comprobante,OLD.serie_comprobante,OLD.num_comprobante,OLD.fecha_hora,OLD.total_compra,OLD.estado,usuarioAud,fecha_actual,'ACTUALIZADO');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `eliminar_ingresoAuditoria` BEFORE DELETE ON `ingreso` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO personaAuditoria (idingreso, idproveedor, idusuario, tipo_comprobante, serie_comprobante, num_comprobante,fecha_hora,total_compra,estado,usuarioAud,fechaAud,estadoAud)
    VALUES (OLD.idingreso, OLD.idproveedor, OLD.idusuario,OLD.tipo_comprobante,OLD.serie_comprobante,OLD.num_comprobante,OLD.fecha_hora,OLD.total_compra,OLD.estado,usuarioAud, fecha_actual,'ELIMINADO');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `nuevo_ingresoAuditoria` AFTER INSERT ON `ingreso` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO ingresoAuditoria (idingreso, idproveedor, idusuario, tipo_comprobante, serie_comprobante, num_comprobante,fecha_hora,total_compra,estado,usuarioAud,fechaAud,estadoAud)
    VALUES (NEW.idingreso, NEW.idproveedor, NEW.idusuario,NEW.tipo_comprobante,NEW.serie_comprobante,NEW.num_comprobante,NEW.fecha_hora,NEW.total_compra,NEW.estado, usuarioAud, fecha_actual,'NUEVO');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingresoauditoria`
--

CREATE TABLE `ingresoauditoria` (
  `idingreso` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `total_compra` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `usuarioAud` varchar(20) NOT NULL,
  `fechaAud` datetime NOT NULL,
  `estadoAud` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `ingresoauditoria`
--

INSERT INTO `ingresoauditoria` (`idingreso`, `idproveedor`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `total_compra`, `estado`, `usuarioAud`, `fechaAud`, `estadoAud`) VALUES
(1, 17, 1, 'Factura', '0002', '22352', '2024-05-15 00:00:00', 100.00, 'Aceptado', 'root@localhost', '2024-06-18 02:18:25', 'NUEVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idpersona` int(11) NOT NULL,
  `tipo_persona` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `ci_documento` varchar(20) DEFAULT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `tipo_persona`, `nombre`, `ci_documento`, `direccion`, `telefono`, `email`) VALUES
(1, 'Cliente', 'Juan', '4343543', 'fasdf', '75555555', 'ndbhalerao91@gmail.com'),
(2, 'Cliente', 'Pedro', '123456', 'La Paz', '7654321', 'kare@mail.com'),
(3, 'Cliente', 'maria', '123456', 'La Paz', '7654321', 'kare@mail.com'),
(17, 'Proveedor', 'Elton Laura', '10015263', 'Camino a Viacha NÂº 1234', '63199940', 'elr1905@gmail.com'),
(18, 'Proveedor', 'Idol', '7001253', 'Villa Alemania NÂº 123', '73038062', 'idol@gmail.com');

--
-- Disparadores `persona`
--
DELIMITER $$
CREATE TRIGGER `actualizado_personaAuditoria` AFTER UPDATE ON `persona` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO personaAuditoria (idpersona, tipo_persona, nombre, ci_documento, direccion, telefono,email,usuarioAud,fechaAud,estadoAud)
    VALUES (OLD.idpersona, OLD.tipo_persona, OLD.nombre,OLD.ci_documento,OLD.direccion,OLD.telefono,OLD.email,  usuarioAud, fecha_actual, 'ACTUALIZADO');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `eliminar_personaAuditoria` BEFORE DELETE ON `persona` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO personaAuditoria (idpersona, tipo_persona, nombre, ci_documento, direccion, telefono,email,usuarioAud,fechaAud,estadoAud)
    VALUES (OLD.idpersona, OLD.tipo_persona, OLD.nombre,OLD.ci_documento,OLD.direccion,OLD.telefono,OLD.email, usuarioAud, fecha_actual, 'ELIMINADO');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `nuevo_personaAuditoria` AFTER INSERT ON `persona` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO personaAuditoria (idpersona, tipo_persona, nombre, ci_documento, direccion, telefono,email,usuarioAud,fechaAud,estadoAud)
    VALUES (NEW.idpersona, NEW.tipo_persona, NEW.nombre,NEW.ci_documento,NEW.direccion,NEW.telefono,NEW.email,  usuarioAud, fecha_actual, 'NUEVO');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personaauditoria`
--

CREATE TABLE `personaauditoria` (
  `idpersona` int(11) NOT NULL,
  `tipo_persona` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `ci_documento` varchar(20) DEFAULT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `usuarioAud` varchar(20) NOT NULL,
  `fechaAud` datetime NOT NULL,
  `estadoAud` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `personaauditoria`
--

INSERT INTO `personaauditoria` (`idpersona`, `tipo_persona`, `nombre`, `ci_documento`, `direccion`, `telefono`, `email`, `usuarioAud`, `fechaAud`, `estadoAud`) VALUES
(5, 'Cliente', 'Maria', '123456', 'La Paz', '7654321', 'kare@mail.com', 'root@localhost', '0000-00-00 00:00:00', 'ELIMINADO'),
(6, 'Cliente', 'Maria', '123456', 'La Paz', '7654321', 'kare@mail.com', 'root@localhost', '2024-06-09 19:02:04', 'ELIMINADO'),
(0, 'Cliente', 'maria', '123456', 'La Paz', '7654321', 'kare@mail.com', 'root@localhost', '2024-06-09 00:00:00', 'NUEVO'),
(0, 'Cliente', 'maria', '123456', 'La Paz', '7654321', 'kare@mail.com', 'root@localhost', '2024-06-09 19:07:12', 'ELIMINADO'),
(0, 'Cliente', 'maria', '123456', 'La Paz', '7654321', 'kare@mail.com', 'root@localhost', '2024-06-09 19:10:20', 'NUEVO'),
(0, 'Cliente', 'maria', '123456', 'La Paz', '7654321', 'kare@mail.com', 'root@localhost', '2024-06-09 19:12:03', 'NUEVO'),
(11, 'Cliente', 'maria', '123456', 'La Paz', '7654321', 'kare@mail.com', 'root@localhost', '2024-06-09 19:12:42', 'ELIMINADO'),
(10, 'Cliente', 'maria', '123456', 'La Paz', '7654321', 'kare@mail.com', 'root@localhost', '2024-06-09 19:15:07', 'ELIMINADO'),
(0, 'Cliente', 'maria', '123456', 'La Paz', '7654321', 'kare@mail.com', 'root@localhost', '2024-06-09 15:18:57', 'NUEVO'),
(8, 'Cliente', 'maria', '123456', 'La Paz', '7654321', 'kare@mail.com', 'root@localhost', '2024-06-15 00:00:00', 'ACTUALIZADO'),
(8, 'Cliente', 'Pedrito', '123456', 'La Paz', '7654321', 'kare@mail.com', 'root@localhost', '2024-06-15 00:00:00', 'ACTUALIZADO'),
(8, 'Cliente', 'Pedro', '123456', 'La Paz', '7654321', 'kare@mail.com', 'root@localhost', '2024-06-15 00:00:00', 'ACTUALIZADO'),
(12, 'Cliente', 'maria', '123456', 'La Paz', '7654321', 'kare@mail.com', 'root@localhost', '2024-06-15 19:27:04', 'ELIMINADO'),
(8, 'Cliente', 'Carlos', '123456', 'La Paz', '7654321', 'kare@mail.com', 'root@localhost', '2024-06-15 19:29:37', 'ELIMINADO'),
(16, 'Cliente', 'Marihuana', '123456', 'La Paz', '7654321', 'huana@mail.com', 'root@localhost', '0202-06-15 19:34:52', 'NUEVO'),
(16, 'Cliente', 'Marihuana', '123456', 'La Paz', '7654321', 'huana@mail.com', 'root@localhost', '2024-06-15 19:35:47', 'ACTUALIZADO'),
(16, 'Cliente', 'paTRICIO', '123456', 'La Paz', '7654321', 'huana@mail.com', 'root@localhost', '2024-06-15 19:37:24', 'ELIMINADO'),
(17, 'Proveedor', 'Elton Laura', '10015263', 'Camino a Viacha NÂº 1234', '63199940', 'elr1905@gmail.com', 'root@localhost', '2024-06-18 02:14:44', 'NUEVO'),
(18, 'Proveedor', 'Idol', '7001253', 'Villa Alemania NÂº 123', '73038062', 'idol@gmail.com', 'root@localhost', '2024-06-18 02:15:57', 'NUEVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `idrol` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`idrol`, `nombre`, `descripcion`) VALUES
(1, 'Administrador', 'Privilegios completos'),
(2, 'Empleado', 'Tiene privilegios para realizar transacciones sobre el sistema y generar reportes'),
(3, 'Tecnico', 'Todo el sistema');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `ci_documento` varchar(20) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `cargo` varchar(20) DEFAULT NULL,
  `login` varchar(20) NOT NULL,
  `clave` varchar(64) NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1,
  `idrol` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nombre`, `ci_documento`, `email`, `cargo`, `login`, `clave`, `condicion`, `idrol`) VALUES
(1, 'Santos Tarqui', '6011689', '17isantf@gmail.com', 'Ingeniero Sistemas', 'admin', '21232f297a57a5a743894a0e4a801fc3', 1, 1);

--
-- Disparadores `usuario`
--
DELIMITER $$
CREATE TRIGGER `actualizado_usuarioAuditoria` AFTER UPDATE ON `usuario` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO usuarioAuditoria (idusuario,nombre,ci_documento,email,cargo,login,clave,condicion,idrol,usuarioAud,fechaAud,estadoAud)
    VALUES (OLD.idusuario, OLD.nombre, OLD.ci_documento,OLD.email,OLD.cargo,OLD.login,OLD.clave,OLD.condicion,OLD.idrol,usuarioAud,fecha_actual,'ACTUALIZADO');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `eliminar_usuarioAuditoria` BEFORE DELETE ON `usuario` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO usuarioAuditoria (idusuario,nombre,ci_documento,email,cargo,login,clave,condicion,idrol,usuarioAud,fechaAud,estadoAud)
    VALUES (OLD.idusuario, OLD.nombre, OLD.ci_documento,OLD.email,OLD.cargo,OLD.login,OLD.clave,OLD.condicion,OLD.idrol,usuarioAud,fecha_actual,'ELIMINADO');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `nuevo_usuarioAuditoria` AFTER INSERT ON `usuario` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO usuarioAuditoria (idusuario,nombre,ci_documento,email,cargo,login,clave,condicion,idrol,usuarioAud,fechaAud,estadoAud)
    VALUES (NEW.idusuario, NEW.nombre, NEW.ci_documento,NEW.email,NEW.cargo,NEW.login,NEW.clave,NEW.condicion,NEW.idrol,usuarioAud,fecha_actual,'NUEVO');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarioauditoria`
--

CREATE TABLE `usuarioauditoria` (
  `idusuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `ci_documento` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `cargo` varchar(30) DEFAULT NULL,
  `login` varchar(30) DEFAULT NULL,
  `clave` varchar(64) DEFAULT NULL,
  `condicion` varchar(20) DEFAULT NULL,
  `idrol` varchar(50) DEFAULT NULL,
  `usuarioAud` varchar(20) NOT NULL,
  `fechaAud` datetime NOT NULL,
  `estadoAud` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `usuarioauditoria`
--

INSERT INTO `usuarioauditoria` (`idusuario`, `nombre`, `ci_documento`, `email`, `cargo`, `login`, `clave`, `condicion`, `idrol`, `usuarioAud`, `fechaAud`, `estadoAud`) VALUES
(1, 'Santos Tarqui', '6011689', '17isantf@gmail.com', 'Ingeniero Sistemas', 'admin', 'admin', '1', '1', 'root@localhost', '2024-06-15 19:58:42', 'ACTUALIZADO'),
(2, 'Stefany Miranda', '9982345', 'smiranda@mail.com', 'contadora', 'admin2', 'admin2', '1', '2', 'root@localhost', '2024-06-15 19:59:46', 'ELIMINADO'),
(1, 'Santos Tarqui', '6011689', '17isantf@gmail.com', 'Ingeniero Sistemas', 'admin', 'admin', '1', '1', 'root@localhost', '2024-06-18 01:59:48', 'ACTUALIZADO'),
(1, 'Santos Tarqui', '6011689', '17isantf@gmail.com', 'Ingeniero Sistemas', 'admin', '21232f297a57a5a743894a0e4a801fc3', '1', '1', 'root@localhost', '2024-06-24 19:58:50', 'ACTUALIZADO'),
(1, 'Elton Laura', '6011689', '17isantf@gmail.com', 'Ingeniero Sistemas', 'admin', '21232f297a57a5a743894a0e4a801fc3', '1', '1', 'root@localhost', '2024-06-25 14:22:32', 'ACTUALIZADO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `idventa` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(10) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `total_venta` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`idventa`, `idcliente`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `total_venta`, `estado`) VALUES
(1, 1, 1, 'Boleta', '454', '0001', '2023-06-13 00:00:00', 200.00, 'Aceptado'),
(2, 1, 1, 'Ticket', '454', '0001', '2023-11-09 00:00:00', 180.00, 'Anulado');

--
-- Disparadores `venta`
--
DELIMITER $$
CREATE TRIGGER `actualizado_ventaAuditoria` AFTER UPDATE ON `venta` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO ventaauditoria (idventa, idcliente, idusuario,tipo_comprobante,serie_comprobante,num_comprobante,fecha_hora,total_venta,estado,usuarioAud,fechaAud,estadoAud)
    VALUES (OLD.idventa, OLD.idcliente, OLD.idusuario,OLD.tipo_comprobante,OLD.serie_comprobante,OLD.num_comprobante,OLD.fecha_hora,OLD.total_venta,OLD.estado,usuarioAud,fecha_actual,'ACTUALIZADO');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `eliminar_ventaAuditoria` BEFORE DELETE ON `venta` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO ventaauditoria (idventa, idcliente, idusuario,tipo_comprobante,serie_comprobante,num_comprobante,fecha_hora,total_venta,estado,usuarioAud,fechaAud,estadoAud)
    VALUES (OLD.idventa, OLD.idcliente, OLD.idusuario,OLD.tipo_comprobante,OLD.serie_comprobante,OLD.num_comprobante,OLD.fecha_hora,OLD.total_venta,OLD.estado,usuarioAud,fecha_actual,'ELIMINADO');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `nuevo_ventaAuditoria` AFTER INSERT ON `venta` FOR EACH ROW BEGIN
    DECLARE usuarioAud VARCHAR(50);
    DECLARE fecha_actual DATETIME;
    DECLARE estadoAud VARCHAR(50);
    
    SELECT USER() INTO usuarioAud;
    SET fecha_actual = NOW();

    INSERT INTO ventaauditoria (idventa, idcliente, idusuario,tipo_comprobante,serie_comprobante,num_comprobante,fecha_hora,total_venta,estado,usuarioAud,fechaAud,estadoAud)
    VALUES (NEW.idventa, NEW.idcliente, NEW.idusuario,NEW.tipo_comprobante,NEW.serie_comprobante,NEW.num_comprobante,NEW.fecha_hora,NEW.total_venta,NEW.estado, usuarioAud,fecha_actual,'NUEVO');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventaauditoria`
--

CREATE TABLE `ventaauditoria` (
  `idventa` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `total_venta` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `usuarioAud` varchar(20) NOT NULL,
  `fechaAud` varchar(20) NOT NULL,
  `estadoAud` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `ventaauditoria`
--

INSERT INTO `ventaauditoria` (`idventa`, `idcliente`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `total_venta`, `estado`, `usuarioAud`, `fechaAud`, `estadoAud`) VALUES
(2, 1, 1, 'Ticket', '454', '0001', '2023-11-09 00:00:00', 180.00, 'Aceptado', 'root@localhost', '2023-11-15 20:26:42', 'ACTUALIZADO');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`idarticulo`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  ADD KEY `fk_articulo_categoria_idx` (`idcategoria`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indices de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD PRIMARY KEY (`iddetalle_ingreso`),
  ADD KEY `fk_detalle_ingreso_ingreso_idx` (`idingreso`),
  ADD KEY `fk_detalle_ingreso_articulo_idx` (`idarticulo`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`iddetalle_venta`),
  ADD KEY `fk_detalle_venta_venta_idx` (`idventa`),
  ADD KEY `fk_detalle_venta_articulo_idx` (`idarticulo`);

--
-- Indices de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`idingreso`),
  ADD KEY `fk_ingreso_persona_idx` (`idproveedor`),
  ADD KEY `fk_ingreso_usuario_idx` (`idusuario`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`idrol`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `login_UNIQUE` (`login`),
  ADD KEY `fk_usuario_rol` (`idrol`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`idventa`),
  ADD KEY `fk_venta_persona_idx` (`idcliente`),
  ADD KEY `fk_venta_usuario_idx` (`idusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulo`
--
ALTER TABLE `articulo`
  MODIFY `idarticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  MODIFY `iddetalle_ingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `iddetalle_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `idingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `idrol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `idventa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `fk_articulo_categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`);

--
-- Filtros para la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD CONSTRAINT `fk_detalle_ingreso_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`),
  ADD CONSTRAINT `fk_detalle_ingreso_ingreso` FOREIGN KEY (`idingreso`) REFERENCES `ingreso` (`idingreso`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `fk_detalle_venta_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`),
  ADD CONSTRAINT `fk_detalle_venta_venta` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`);

--
-- Filtros para la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD CONSTRAINT `fk_ingreso_persona` FOREIGN KEY (`idproveedor`) REFERENCES `persona` (`idpersona`),
  ADD CONSTRAINT `fk_ingreso_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_rol` FOREIGN KEY (`idrol`) REFERENCES `rol` (`idrol`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fk_venta_persona` FOREIGN KEY (`idcliente`) REFERENCES `persona` (`idpersona`),
  ADD CONSTRAINT `fk_venta_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
