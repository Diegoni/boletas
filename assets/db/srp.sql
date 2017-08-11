-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-08-2017 a las 15:29:37
-- Versión del servidor: 10.1.9-MariaDB
-- Versión de PHP: 5.6.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `srp`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `afiliados`
--

CREATE TABLE `afiliados` (
  `id_afiliado` bigint(20) NOT NULL,
  `nombre` varchar(128) NOT NULL,
  `apellido` varchar(128) NOT NULL,
  `dni` varchar(11) NOT NULL,
  `cuit` varchar(16) NOT NULL,
  `calle` varchar(128) NOT NULL,
  `numero` int(11) NOT NULL,
  `piso` int(11) NOT NULL,
  `departamento` int(11) NOT NULL,
  `id_provincia` int(11) NOT NULL,
  `id_localidad` int(11) NOT NULL,
  `codigo_postal` int(11) NOT NULL,
  `telefono` varchar(64) NOT NULL,
  `email` varchar(128) NOT NULL,
  `codigo_afiliado` int(11) NOT NULL,
  `id_ente` int(11) NOT NULL,
  `fecha_alta` date NOT NULL,
  `id_archivo` int(11) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `user_add` int(11) NOT NULL,
  `user_upd` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `afiliados_entes`
--

CREATE TABLE `afiliados_entes` (
  `id_afiliado_ente` bigint(20) NOT NULL,
  `id_afiliado` int(11) NOT NULL,
  `id_ente` int(11) NOT NULL,
  `codigo_afiliado` bigint(11) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alertas`
--

CREATE TABLE `alertas` (
  `id_alerta` int(11) NOT NULL,
  `alerta` varchar(128) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_ente` int(11) NOT NULL,
  `visto` tinyint(4) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `user_add` int(11) NOT NULL,
  `user_upd` int(11) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivos`
--

CREATE TABLE `archivos` (
  `id_archivo` int(11) NOT NULL,
  `nombre` varchar(64) NOT NULL,
  `extension` varchar(8) NOT NULL,
  `path` varchar(128) NOT NULL,
  `size` float NOT NULL,
  `tipo` varchar(32) NOT NULL,
  `full_path` varchar(128) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_ente` int(11) NOT NULL,
  `id_origen` int(11) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `user_add` int(11) NOT NULL,
  `user_upd` int(11) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `archivos`
--

INSERT INTO `archivos` (`id_archivo`, `nombre`, `extension`, `path`, `size`, `tipo`, `full_path`, `id_usuario`, `id_ente`, `id_origen`, `date_add`, `date_upd`, `user_add`, `user_upd`, `eliminado`) VALUES
(1, 'admin-2016_08_29 20_52_29', '.xls', 'C:/xampp/htdocs/srp/uploads/entes/', 653, 'application/vnd.ms-excel', 'C:/xampp/htdocs/srp/uploads/entes/Entes-2016_08_29 20_52_29.xls', 1, 0, 1, '2016-08-29 20:52:29', '2016-08-29 20:52:29', 1, 1, 0),
(2, 'usuario-2017_03_23 15_16_11', '.xls', 'C:/xampp/htdocs/srp/uploads/afiliados/', 10.35, 'application/vnd.openxmlformats-o', 'C:/xampp/htdocs/srp/uploads/afiliados/usuario-2017_03_23 15_16_11.xls', 2, 430, 1, '2017-03-23 15:16:11', '2017-03-23 15:16:11', 2, 2, 0),
(3, 'usuario-2017_03_23 15_17_30', '.xls', 'C:/xampp/htdocs/srp/uploads/afiliados/', 10.35, 'application/vnd.openxmlformats-o', 'C:/xampp/htdocs/srp/uploads/afiliados/usuario-2017_03_23 15_17_30.xls', 2, 192, 1, '2017-03-23 15:17:30', '2017-03-23 15:17:30', 2, 2, 0),
(4, 'usuario-2017_03_23 15_18_42', '.xls', 'C:/xampp/htdocs/srp/uploads/afiliados/', 25.5, 'application/vnd.ms-excel', 'C:/xampp/htdocs/srp/uploads/afiliados/usuario-2017_03_23 15_18_42.xls', 2, 192, 1, '2017-03-23 15:18:42', '2017-03-23 15:18:42', 2, 2, 0),
(5, 'usuario-2017_03_23 15_20_44', '.xls', 'C:/xampp/htdocs/srp/uploads/afiliados/', 448.98, 'application/vnd.openxmlformats-o', 'C:/xampp/htdocs/srp/uploads/afiliados/usuario-2017_03_23 15_20_44.xls', 2, 192, 1, '2017-03-23 15:20:44', '2017-03-23 15:20:44', 2, 2, 0),
(6, 'tarjetas720-2017-03-27_19_49_20', '.txt', '../../uploads/tarjetas/', 20, 'file', 'C:/xampp/htdocs/srp/uploads/tarjetas/tarjetas720-2017-03-27_19_49_20.txt', 2, 0, 2, '2017-03-27 19:49:20', '2017-03-27 19:49:20', 2, 2, 0),
(7, 'tarjetas720-2017-03-27_19_50_27', '.txt', '../../uploads/tarjetas/', 20, 'file', 'C:/xampp/htdocs/srp/uploads/tarjetas/tarjetas720-2017-03-27_19_50_27.txt', 2, 0, 2, '2017-03-27 19:50:27', '2017-03-27 19:50:27', 2, 2, 0),
(8, 'tarjetas720-2017-03-27_20_00_07', '.txt', '../../uploads/tarjetas/', 20, 'file', 'C:/xampp/htdocs/srp/uploads/tarjetas/tarjetas720-2017-03-27_20_00_07.txt', 2, 0, 2, '2017-03-27 20:00:07', '2017-03-27 20:00:07', 2, 2, 0),
(9, 'usuario-2017_05_23 13_56_47', '.xls', 'C:/xampp/htdocs/srp/uploads/afiliados/', 448.98, 'application/vnd.openxmlformats-o', 'C:/xampp/htdocs/srp/uploads/afiliados/usuario-2017_05_23 13_56_47.xls', 2, 430, 1, '2017-05-23 13:56:47', '2017-05-23 13:56:47', 2, 2, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivos_origen`
--

CREATE TABLE `archivos_origen` (
  `id_origen` int(11) NOT NULL,
  `origen` varchar(32) NOT NULL,
  `eliminado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `archivos_origen`
--

INSERT INTO `archivos_origen` (`id_origen`, `origen`, `eliminado`) VALUES
(1, 'Upload', 0),
(2, 'Create', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barcore`
--

CREATE TABLE `barcore` (
  `id_barcore` int(11) NOT NULL,
  `width` decimal(11,2) NOT NULL,
  `height` int(11) NOT NULL,
  `id_formato` int(11) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `size_x` int(11) NOT NULL,
  `size_y` int(11) NOT NULL,
  `canvas_x` int(11) NOT NULL,
  `canvas_y` int(11) NOT NULL,
  `date_upd` datetime NOT NULL,
  `user_upd` int(11) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `barcore`
--

INSERT INTO `barcore` (`id_barcore`, `width`, `height`, `id_formato`, `id_tipo`, `size_x`, `size_y`, `canvas_x`, `canvas_y`, `date_upd`, `user_upd`, `eliminado`) VALUES
(1, '3.00', 90, 1, 9, 920, 100, 460, 50, '2016-03-08 14:54:56', 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barcore_formatos`
--

CREATE TABLE `barcore_formatos` (
  `id_formato` int(11) NOT NULL,
  `formato` varchar(64) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `barcore_formatos`
--

INSERT INTO `barcore_formatos` (`id_formato`, `formato`, `eliminado`) VALUES
(1, 'css', 0),
(2, 'bmp', 0),
(3, 'svg', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barcore_tipos`
--

CREATE TABLE `barcore_tipos` (
  `id_tipo` int(11) NOT NULL,
  `tipo` varchar(32) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `barcore_tipos`
--

INSERT INTO `barcore_tipos` (`id_tipo`, `tipo`, `eliminado`) VALUES
(1, 'ean8', 0),
(2, 'ean13', 0),
(3, 'upc', 0),
(4, 'std25', 0),
(5, 'int25', 0),
(6, 'code11', 0),
(7, 'code39', 0),
(8, 'code93', 0),
(9, 'code128', 0),
(10, 'codabar', 0),
(11, 'msi', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `boletas`
--

CREATE TABLE `boletas` (
  `id_boleta` bigint(20) NOT NULL,
  `id_afiliado` int(11) NOT NULL,
  `cod_afiliado` varchar(64) NOT NULL,
  `nro_cuota` int(11) NOT NULL,
  `fecha_venc_1` date NOT NULL,
  `importe_venc_1` double NOT NULL,
  `fecha_venc_2` date NOT NULL,
  `importe_venc_2` double NOT NULL,
  `id_ente` int(11) NOT NULL,
  `cod_ente` int(11) NOT NULL,
  `cod_convenio` int(11) NOT NULL,
  `pago` tinyint(4) NOT NULL,
  `id_lote` int(11) NOT NULL,
  `codigo_barra` varchar(128) NOT NULL,
  `date_add` datetime NOT NULL,
  `user_add` int(11) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `config`
--

CREATE TABLE `config` (
  `id_config` int(11) NOT NULL,
  `mensaje_login` text NOT NULL,
  `comparar_decimales` tinyint(4) NOT NULL,
  `alertas` tinyint(4) NOT NULL,
  `alerta_pago_iguales` tinyint(4) NOT NULL,
  `alerta_pago_no_ingresado` tinyint(4) NOT NULL,
  `alerta_pago_no_ingresado_tarjetas` tinyint(4) NOT NULL,
  `alerta_codigo_no_existe_tarjetas` tinyint(4) NOT NULL,
  `alerta_codigo_no_existe` tinyint(4) NOT NULL,
  `alerta_afiliado_incompleto` tinyint(4) NOT NULL,
  `alerta_afiliado_existente` tinyint(4) NOT NULL,
  `alerta_login_no_entes` tinyint(4) NOT NULL,
  `alerta_login_user_dlt` tinyint(4) NOT NULL,
  `delete_afiliado_boleta` tinyint(4) NOT NULL,
  `delete_ente_boleta` tinyint(4) NOT NULL,
  `boletas_cantidad` int(11) NOT NULL,
  `boletas_dias` int(11) NOT NULL,
  `boletas_pagos` int(11) NOT NULL,
  `tarjetas_dias` int(11) NOT NULL,
  `input_max` int(11) NOT NULL,
  `importe_max` int(11) NOT NULL,
  `usar_min_fecha` tinyint(4) NOT NULL,
  `min_fecha` int(11) NOT NULL,
  `maximo_afiliados_importacion` int(11) NOT NULL,
  `maximo_afiliados_alertas` int(11) NOT NULL,
  `maximo_afiliados_boletas` int(11) NOT NULL,
  `usuarios_delete` tinyint(4) NOT NULL,
  `entes_delete` tinyint(4) NOT NULL,
  `url_conexion_siris` varchar(255) NOT NULL,
  `date_upd` datetime NOT NULL,
  `user_upd` int(11) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `config`
--

INSERT INTO `config` (`id_config`, `mensaje_login`, `comparar_decimales`, `alertas`, `alerta_pago_iguales`, `alerta_pago_no_ingresado`, `alerta_pago_no_ingresado_tarjetas`, `alerta_codigo_no_existe_tarjetas`, `alerta_codigo_no_existe`, `alerta_afiliado_incompleto`, `alerta_afiliado_existente`, `alerta_login_no_entes`, `alerta_login_user_dlt`, `delete_afiliado_boleta`, `delete_ente_boleta`, `boletas_cantidad`, `boletas_dias`, `boletas_pagos`, `tarjetas_dias`, `input_max`, `importe_max`, `usar_min_fecha`, `min_fecha`, `maximo_afiliados_importacion`, `maximo_afiliados_alertas`, `maximo_afiliados_boletas`, `usuarios_delete`, `entes_delete`, `url_conexion_siris`, `date_upd`, `user_upd`, `eliminado`) VALUES
(1, '<p>Comunicarse con los n&uacute;meros del Banco.</p>\r\n', 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 40, 20, 65, 60, 64, 9, 1, 0, 5001, 400, 500, 1, 1, 'http://172.31.24.178/WsSiris_26/emp_6100.php', '2017-08-10 19:04:25', 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `config_archivos`
--

CREATE TABLE `config_archivos` (
  `id_config` int(11) NOT NULL,
  `dias_warning` int(11) NOT NULL,
  `dias_danger` int(11) NOT NULL,
  `mensaje_warning` int(11) NOT NULL,
  `mensaje_danger` int(11) NOT NULL,
  `pagos_size` int(11) NOT NULL,
  `pagos_type` varchar(32) NOT NULL,
  `afiliados_size` int(11) NOT NULL,
  `afiliados_type` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `config_archivos`
--

INSERT INTO `config_archivos` (`id_config`, `dias_warning`, `dias_danger`, `mensaje_warning`, `mensaje_danger`, `pagos_size`, `pagos_type`, `afiliados_size`, `afiliados_type`) VALUES
(1, 7, 14, 5000, 10000, 1000, 'txt', 1000, 'xls');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `convenios`
--

CREATE TABLE `convenios` (
  `id_convenio` int(11) NOT NULL,
  `cod_convenio` tinyint(4) NOT NULL,
  `convenio` varchar(32) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `convenios`
--

INSERT INTO `convenios` (`id_convenio`, `cod_convenio`, `convenio`, `eliminado`) VALUES
(1, 0, 'Banco Provincia', 0),
(2, 1, 'Provincia Net', 0),
(3, 2, 'Banco Provincia y Provincia net', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emails`
--

CREATE TABLE `emails` (
  `id_email` int(11) NOT NULL,
  `mail_to` varchar(128) NOT NULL,
  `mail_copy` varchar(255) NOT NULL,
  `mail_subject` varchar(128) NOT NULL,
  `message` text NOT NULL,
  `mail_from` varchar(128) NOT NULL,
  `debugger` text NOT NULL,
  `date_add` datetime NOT NULL,
  `user_add` int(11) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entes`
--

CREATE TABLE `entes` (
  `id_ente` bigint(20) NOT NULL,
  `codigo` int(11) NOT NULL,
  `nombre` varchar(128) NOT NULL,
  `cuit` varchar(16) NOT NULL,
  `telefono` varchar(64) NOT NULL,
  `id_convenio` int(11) NOT NULL,
  `id_leyenda` int(11) NOT NULL,
  `comentario` text,
  `img` varchar(128) NOT NULL,
  `id_impresion` int(11) NOT NULL DEFAULT '1',
  `boletas` tinyint(4) NOT NULL,
  `tarjetas` tinyint(4) NOT NULL,
  `imprime_cuota` tinyint(4) NOT NULL,
  `bloquear` tinyint(4) NOT NULL,
  `modalidad` int(11) NOT NULL,
  `fecha_alta` date NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `user_add` int(11) NOT NULL,
  `user_upd` int(11) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entes_usuarios`
--

CREATE TABLE `entes_usuarios` (
  `id_ente_usuario` int(11) NOT NULL,
  `id_ente` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `user_add` int(11) NOT NULL,
  `user_upd` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `feriados`
--

CREATE TABLE `feriados` (
  `id_feriado` int(11) NOT NULL,
  `feriado` varchar(64) NOT NULL,
  `fecha` date NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `feriados`
--

INSERT INTO `feriados` (`id_feriado`, `feriado`, `fecha`, `eliminado`) VALUES
(1, 'Día de la bandera', '2016-06-20', 0),
(2, 'Martín Miguel de Güemes', '2016-06-17', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impresiones`
--

CREATE TABLE `impresiones` (
  `id_impresion` int(11) NOT NULL,
  `impresion` text NOT NULL,
  `x_hoja` int(11) NOT NULL,
  `date_upd` datetime NOT NULL,
  `user_upd` int(11) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `impresiones`
--

INSERT INTO `impresiones` (`id_impresion`, `impresion`, `x_hoja`, `date_upd`, `user_upd`, `eliminado`) VALUES
(1, '<table border="1" cellpadding="1" cellspacing="1" style="width:100%">\n	<tbody>\n		<tr>\n			<td>Ente</td>\n			<td>#ente#</td>\n		</tr>\n		<tr>\n			<td>Codigo ente</td>\n			<td>#codigo_ente#</td>\n		</tr>\n		<tr>\n			<td>Codigo #leyenda#</td>\n			<td>#codigo_afiliado#</td>\n		</tr>\n		<tr>\n			<td>Nombre #leyenda#</td>\n			<td>#nombre#</td>\n		</tr>\n		<tr>\n			<td>Apellido #leyenda#</td>\n			<td>#apellido#</td>\n		</tr>\n		<tr>\n			<td>Primer vencimiento</td>\n			<td>#fecha_venc_1#</td>\n		</tr>\n		<tr>\n			<td>Primer importe</td>\n			<td>#importe_venc_1#</td>\n		</tr>\n		<tr>\n			<td>Segundo vencimiento</td>\n			<td>#fecha_venc_2#</td>\n		</tr>\n		<tr>\n			<td>Segundo importe</td>\n			<td>#importe_venc_2#</td>\n		</tr>\n	</tbody>\n</table>\n', 3, '2017-07-28 16:28:18', 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impresiones_campos`
--

CREATE TABLE `impresiones_campos` (
  `id_campo` int(11) NOT NULL,
  `opcion` varchar(64) NOT NULL,
  `campo` varchar(64) NOT NULL,
  `cadena` varchar(64) NOT NULL,
  `formato` varchar(11) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `impresiones_campos`
--

INSERT INTO `impresiones_campos` (`id_campo`, `opcion`, `campo`, `cadena`, `formato`, `eliminado`) VALUES
(1, 'Nombre', 'nombre', '#nombre#', '', 0),
(2, 'Apellido', 'apellido', '#apellido#', '', 0),
(3, 'Fecha primer vencimiento', 'fecha_venc_1', '#fecha_venc_1#', 'date', 0),
(4, 'Fecha segundo vencimiento', 'fecha_venc_2', '#fecha_venc_2#', 'date', 0),
(5, 'Importe primer vencimiento', 'importe_venc_1', '#importe_venc_1#', 'importe', 0),
(6, 'Importe segundo vencimiento', 'importe_venc_2', '#importe_venc_2#', 'importe', 0),
(7, 'Codigo de barra', 'codigo_barra', '#codigo_barra#', '', 0),
(8, 'Ente', 'ente', '#ente#', '', 0),
(9, 'Código afiliado', 'codigo_afiliado', '#codigo_afiliado#', '', 0),
(10, 'Código ente', 'codigo_ente', '#codigo_ente#', '', 0),
(11, 'Leyenda', 'leyenda', '#leyenda#', '', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `leyendas`
--

CREATE TABLE `leyendas` (
  `id_leyenda` int(11) NOT NULL,
  `leyenda` varchar(64) NOT NULL,
  `letra_leyenda` varchar(1) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `leyendas`
--

INSERT INTO `leyendas` (`id_leyenda`, `leyenda`, `letra_leyenda`, `eliminado`) VALUES
(1, 'Afiliado', 'C', 0),
(2, 'Legajo', 'C', 0),
(3, 'Empleado', 'C', 0),
(4, 'Alumno', 'E', 0),
(5, 'Socio', 'C', 0),
(6, 'Adherente', 'C', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localidades`
--

CREATE TABLE `localidades` (
  `id_localidad` int(4) NOT NULL,
  `localidad` varchar(60) NOT NULL,
  `codigo_postal` int(4) NOT NULL,
  `id_provincia` smallint(2) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_usuarios`
--

CREATE TABLE `logs_usuarios` (
  `id_log` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `ip_login` varchar(32) NOT NULL,
  `action` varchar(32) NOT NULL,
  `tabla` varchar(32) NOT NULL,
  `registro` varchar(32) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lotes`
--

CREATE TABLE `lotes` (
  `id_lote` bigint(20) NOT NULL,
  `nombre` varchar(128) NOT NULL,
  `nro_cuota` int(11) NOT NULL,
  `fecha_venc_1` date NOT NULL,
  `importe_venc_1` double NOT NULL,
  `fecha_venc_2` date NOT NULL,
  `importe_venc_2` double NOT NULL,
  `id_ente` int(11) NOT NULL,
  `date_add` datetime NOT NULL,
  `user_add` int(11) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lotes`
--

INSERT INTO `lotes` (`id_lote`, `nombre`, `nro_cuota`, `fecha_venc_1`, `importe_venc_1`, `fecha_venc_2`, `importe_venc_2`, `id_ente`, `date_add`, `user_add`, `eliminado`) VALUES
(1, '', 0, '2016-12-26', 50, '2017-01-02', 90, 430, '2016-12-14 17:59:36', 2, 0),
(2, '', 1, '2016-12-21', 50, '2016-12-29', 90, 430, '2016-12-21 12:34:42', 2, 0),
(3, 'Test de lote', 1, '2017-05-23', 100, '2017-05-31', 200, 430, '2017-05-23 13:45:50', 2, 0),
(4, 'Primero C Abril', 1, '2017-06-01', 100, '2017-07-07', 200, 430, '2017-05-23 14:15:26', 2, 0),
(5, 'Test tabla', 2, '2017-06-01', 500, '2017-06-09', 600, 430, '2017-05-26 16:23:14', 2, 0),
(6, 'Prueba de tabla 01', 3, '2017-06-01', 100, '2017-06-09', 200, 430, '2017-06-01 14:10:08', 2, 0),
(7, 'Test con 1000 boletas', 1, '2017-07-03', 100, '2017-07-14', 200, 430, '2017-06-01 14:26:59', 2, 0),
(8, '200', 4, '2017-07-03', 100, '2017-07-07', 200, 430, '2017-06-01 15:38:15', 2, 0),
(9, 'Test 01', 1, '2017-07-03', 100, '2017-07-07', 120, 190, '2017-06-01 16:26:27', 2, 0),
(10, '', 0, '2017-06-01', 10, '2017-06-02', 20, 430, '2017-06-01 16:41:21', 2, 1),
(11, '', 0, '2017-06-01', 10, '2017-06-02', 20, 430, '2017-06-01 16:43:32', 2, 1),
(12, '', 0, '2017-06-08', 100, '2017-06-09', 150, 430, '2017-06-01 16:48:18', 2, 1),
(13, 'eRROR', 8, '2017-07-03', 666, '2017-07-04', 6666, 430, '2017-06-01 16:48:53', 2, 1),
(14, 'eRROR', 8, '2017-07-03', 666, '2017-07-04', 6666, 430, '2017-06-01 16:50:23', 2, 1),
(15, 'todos los clientes', 1, '2017-08-01', 120, '2017-08-10', 140, 430, '2017-07-19 20:05:34', 2, 0),
(16, 'test 01 01', 1, '2017-08-01', 100, '2017-09-08', 120, 430, '2017-07-19 20:12:53', 2, 0),
(17, '88', 88, '2017-07-24', 100, '2017-07-26', 120, 430, '2017-07-19 20:21:58', 2, 0),
(18, 'Test pdf', 10, '2017-08-01', 200, '2017-08-04', 300, 430, '2017-07-21 15:10:28', 2, 0),
(19, 'Test pdf', 10, '2017-08-01', 300, '2017-08-10', 350, 430, '2017-07-21 15:13:20', 2, 0),
(20, '123', 123, '2017-08-14', 100, '2017-08-18', 200, 430, '2017-07-21 15:17:52', 2, 0),
(21, '123', 123, '2017-08-01', 100, '2017-08-11', 120, 430, '2017-07-21 15:21:46', 2, 0),
(22, '351351', 153153, '2017-08-08', 3120, '2017-09-06', 4310, 430, '2017-07-21 15:22:45', 2, 0),
(23, '16186168', 165168, '2017-08-01', 100, '2017-08-10', 200, 430, '2017-07-21 15:25:25', 2, 0),
(24, '10', 2, '2017-08-01', 50, '2017-09-04', 90, 430, '2017-07-21 15:38:50', 2, 0),
(25, '32103', 1032, '2017-07-28', 100, '2017-08-07', 200, 430, '2017-07-21 16:18:24', 2, 0),
(26, '3210', 132, '2017-07-24', 100, '2017-07-25', 120, 430, '2017-07-24 20:07:57', 2, 0),
(27, '', 0, '2017-07-25', 10, '2017-07-28', 20, 430, '2017-07-24 20:16:43', 2, 0),
(28, '', 2, '2017-07-27', 50, '2017-07-28', 90, 430, '2017-07-24 20:17:59', 2, 0),
(29, '', 0, '2017-07-28', 1032, '2017-08-02', 32103, 430, '2017-07-24 20:18:48', 2, 0),
(30, '', 0, '2017-08-08', 120, '2017-08-11', 130, 430, '2017-07-24 20:19:46', 2, 0),
(31, '1', 1, '2017-09-05', 100, '2017-10-10', 120, 430, '2017-07-28 16:07:59', 2, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id_notificacion` int(11) NOT NULL,
  `op` varchar(1) NOT NULL,
  `empresa` varchar(4) NOT NULL,
  `flags` varchar(6) NOT NULL,
  `descripcion` varchar(128) NOT NULL,
  `hash` varchar(128) NOT NULL,
  `result` varchar(128) NOT NULL,
  `date_add` datetime NOT NULL,
  `user_add` int(11) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos_boletas`
--

CREATE TABLE `pagos_boletas` (
  `id_pago` bigint(20) NOT NULL,
  `id_boleta` int(11) NOT NULL,
  `agencia` int(11) NOT NULL,
  `terminal` int(11) NOT NULL,
  `nro_transaccion` int(11) NOT NULL,
  `fechapago` date NOT NULL,
  `importe` double NOT NULL,
  `codigo_pago` varchar(128) NOT NULL,
  `id_archivo` int(11) NOT NULL,
  `date_add` datetime NOT NULL,
  `user_add` int(11) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos_tarjetas`
--

CREATE TABLE `pagos_tarjetas` (
  `id_pago` int(11) NOT NULL,
  `id_tarjeta` int(11) NOT NULL,
  `agencia` int(11) NOT NULL,
  `terminal` int(11) NOT NULL,
  `nro_transaccion` int(11) NOT NULL,
  `fecha_pago` date NOT NULL,
  `importe` float NOT NULL,
  `id_archivo` int(11) NOT NULL,
  `date_add` datetime NOT NULL,
  `user_add` int(11) NOT NULL,
  `eliminado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfiles`
--

CREATE TABLE `perfiles` (
  `id_perfil` int(11) NOT NULL,
  `perfil` varchar(64) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `perfiles`
--

INSERT INTO `perfiles` (`id_perfil`, `perfil`, `eliminado`) VALUES
(1, 'Banco', 0),
(2, 'Ente', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `id_permiso` int(11) NOT NULL,
  `id_perfil` tinyint(11) NOT NULL,
  `seccion` varchar(64) NOT NULL,
  `ver` tinyint(11) NOT NULL,
  `agregar` tinyint(11) NOT NULL,
  `modificar` tinyint(11) NOT NULL,
  `eliminar` tinyint(11) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id_permiso`, `id_perfil`, `seccion`, `ver`, `agregar`, `modificar`, `eliminar`, `eliminado`) VALUES
(1, 1, 'afiliados', 0, 0, 0, 0, 0),
(2, 1, 'boletas', 0, 0, 0, 0, 0),
(3, 1, 'config', 1, 0, 0, 0, 0),
(4, 1, 'entes', 1, 1, 1, 1, 0),
(5, 1, 'home', 1, 0, 0, 0, 0),
(6, 1, 'usuarios', 1, 1, 1, 1, 0),
(7, 2, 'afiliados', 1, 1, 1, 1, 0),
(8, 2, 'boletas', 1, 0, 0, 0, 0),
(9, 2, 'config', 0, 0, 0, 0, 0),
(10, 2, 'entes', 1, 0, 0, 0, 0),
(11, 2, 'home', 1, 0, 0, 0, 0),
(12, 2, 'usuarios', 0, 0, 0, 0, 0),
(13, 1, 'pagos_boletas', 0, 0, 0, 0, 0),
(14, 2, 'pagos_boletas', 1, 0, 0, 0, 0),
(15, 2, 'diccionarios', 0, 0, 0, 0, 0),
(16, 1, 'diccionarios', 1, 1, 1, 1, 0),
(17, 1, 'tarjetas', 0, 0, 0, 0, 0),
(18, 2, 'tarjetas', 1, 1, 1, 1, 0),
(19, 1, 'pagos_tarjetas', 0, 0, 0, 0, 0),
(20, 2, 'pagos_tarjetas', 1, 0, 0, 0, 0),
(21, 1, 'archivos', 1, 1, 1, 1, 0),
(22, 2, 'archivos', 0, 0, 0, 0, 0),
(23, 1, 'leyendas', 1, 1, 1, 1, 0),
(24, 2, 'leyendas', 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provincias`
--

CREATE TABLE `provincias` (
  `id_provincia` smallint(2) NOT NULL,
  `provincia` varchar(50) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `provincias`
--

INSERT INTO `provincias` (`id_provincia`, `provincia`, `eliminado`) VALUES
(1, 'Buenos Aires', 0),
(2, 'Capital Federal', 0),
(3, 'Catamarca', 0),
(4, 'Chaco', 0),
(5, 'Chubut', 0),
(6, 'Córdoba', 0),
(7, 'Corrientes', 0),
(8, 'Entre Ríos', 0),
(9, 'Formosa', 0),
(10, 'Jujuy', 0),
(11, 'La Pampa', 0),
(12, 'La Rioja', 0),
(13, 'Mendoza', 0),
(14, 'Misiones', 0),
(15, 'Neuquén', 0),
(16, 'Río Negro', 0),
(17, 'Salta', 0),
(18, 'San Juan', 0),
(19, 'San Luis', 0),
(20, 'Santa Cruz', 0),
(21, 'Santa Fé', 0),
(22, 'Santiago del Estero', 0),
(23, 'Tierra del Fuego', 0),
(24, 'Tucumán', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarjetas`
--

CREATE TABLE `tarjetas` (
  `id_tarjeta` int(11) NOT NULL,
  `id_afiliado` int(11) NOT NULL,
  `cod_afiliado` bigint(11) NOT NULL,
  `id_ente` int(11) NOT NULL,
  `cod_ente` int(11) NOT NULL,
  `codigo_barra` varchar(32) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `user_add` int(11) NOT NULL,
  `user_upd` int(11) NOT NULL,
  `eliminado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tarjetas`
--

INSERT INTO `tarjetas` (`id_tarjeta`, `id_afiliado`, `cod_afiliado`, `id_ente`, `cod_ente`, `codigo_barra`, `date_add`, `date_upd`, `user_add`, `user_upd`, `eliminado`) VALUES
(1, 5005, 2147483647, 720, 227, '620010227998866556', '2017-03-27 19:49:19', '2017-03-27 19:49:19', 2, 2, 0),
(2, 5006, 20341111112, 720, 227, '620010227203411113', '2017-03-27 20:00:06', '2017-03-27 20:00:06', 2, 2, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `usuario` varchar(128) NOT NULL,
  `pass` varchar(128) NOT NULL,
  `id_perfil` int(11) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `user_add` int(11) NOT NULL,
  `user_upd` int(11) NOT NULL,
  `last_login` datetime NOT NULL,
  `ip_login` varchar(32) NOT NULL,
  `navegador` varchar(64) NOT NULL,
  `sistema` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `usuario`, `pass`, `id_perfil`, `date_add`, `date_upd`, `eliminado`, `user_add`, `user_upd`, `last_login`, `ip_login`, `navegador`, `sistema`) VALUES
(1, 'admin', 'yNfLtMvNvw==', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, 0, '2017-08-10 19:04:36', '::1', 'Chrome', 'Windows 10'),
(2, 'usuario', 'yNfLtMvNvw==', 2, '2016-06-21 14:26:34', '2016-12-14 17:56:56', 0, 1, 1, '2017-08-10 17:19:41', '::1', 'Chrome', 'Windows 10'),
(3, 'cgonzalez', 'tNu5hLzZ', 2, '2016-08-29 20:52:32', '2016-08-29 20:52:32', 0, 1, 1, '0000-00-00 00:00:00', '', '', ''),
(4, 'acabrejos', 'w9m7xcaY', 2, '2016-08-29 20:52:32', '2016-08-29 20:52:32', 0, 1, 1, '0000-00-00 00:00:00', '', '', ''),
(5, 'jcanteros', 'utK7usjF', 2, '2016-08-29 20:52:33', '2016-08-29 20:52:33', 0, 1, 1, '0000-00-00 00:00:00', '', '', ''),
(6, 'jdimarco', 'h9q8usbK', 2, '2016-08-29 20:52:38', '2016-08-29 20:52:38', 0, 1, 1, '0000-00-00 00:00:00', '', '', ''),
(7, 'mjulianelli', 'tcrGxryb', 2, '2016-08-29 20:52:39', '2016-08-29 20:52:39', 0, 1, 1, '0000-00-00 00:00:00', '', '', ''),
(8, 'egordiu', 'x5aNv8fa', 2, '2016-08-29 20:53:09', '2016-08-29 20:53:09', 0, 1, 1, '0000-00-00 00:00:00', '', '', ''),
(9, 'logonzalez', 'xNe3ur2c', 2, '2016-08-29 20:53:20', '2016-08-29 20:53:20', 0, 1, 1, '0000-00-00 00:00:00', '', '', ''),
(10, 'pvera', 'iZ3By77Y', 2, '2016-08-29 20:53:20', '2016-08-29 20:53:20', 0, 1, 1, '0000-00-00 00:00:00', '', '', ''),
(11, 'ctorres', 't8e/ib7M', 2, '2016-08-29 20:53:36', '2016-08-29 20:53:36', 0, 1, 1, '0000-00-00 00:00:00', '', '', ''),
(12, 'dpastrana', 'hdbKyIrV', 2, '2016-08-29 20:53:37', '2016-08-29 20:53:37', 0, 1, 1, '0000-00-00 00:00:00', '', '', ''),
(13, 'vmollo', 'w9HDvJHe', 2, '2016-08-29 20:53:38', '2016-08-29 20:53:38', 0, 1, 1, '0000-00-00 00:00:00', '', '', ''),
(14, 'mmugnolo', 't8rGuJDN', 2, '2016-08-29 20:53:39', '2016-08-29 20:53:39', 0, 1, 1, '0000-00-00 00:00:00', '', '', ''),
(15, 'gregairaz', 't8/LtYvR', 2, '2016-08-29 20:54:41', '2016-08-29 20:54:41', 0, 1, 1, '0000-00-00 00:00:00', '', '', '');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `afiliados`
--
ALTER TABLE `afiliados`
  ADD PRIMARY KEY (`id_afiliado`);

--
-- Indices de la tabla `afiliados_entes`
--
ALTER TABLE `afiliados_entes`
  ADD PRIMARY KEY (`id_afiliado_ente`);

--
-- Indices de la tabla `alertas`
--
ALTER TABLE `alertas`
  ADD PRIMARY KEY (`id_alerta`);

--
-- Indices de la tabla `archivos`
--
ALTER TABLE `archivos`
  ADD PRIMARY KEY (`id_archivo`);

--
-- Indices de la tabla `archivos_origen`
--
ALTER TABLE `archivos_origen`
  ADD PRIMARY KEY (`id_origen`);

--
-- Indices de la tabla `barcore`
--
ALTER TABLE `barcore`
  ADD PRIMARY KEY (`id_barcore`);

--
-- Indices de la tabla `barcore_formatos`
--
ALTER TABLE `barcore_formatos`
  ADD PRIMARY KEY (`id_formato`);

--
-- Indices de la tabla `barcore_tipos`
--
ALTER TABLE `barcore_tipos`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Indices de la tabla `boletas`
--
ALTER TABLE `boletas`
  ADD PRIMARY KEY (`id_boleta`);

--
-- Indices de la tabla `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`id_config`);

--
-- Indices de la tabla `config_archivos`
--
ALTER TABLE `config_archivos`
  ADD PRIMARY KEY (`id_config`);

--
-- Indices de la tabla `convenios`
--
ALTER TABLE `convenios`
  ADD PRIMARY KEY (`id_convenio`);

--
-- Indices de la tabla `emails`
--
ALTER TABLE `emails`
  ADD PRIMARY KEY (`id_email`);

--
-- Indices de la tabla `entes`
--
ALTER TABLE `entes`
  ADD PRIMARY KEY (`id_ente`);

--
-- Indices de la tabla `entes_usuarios`
--
ALTER TABLE `entes_usuarios`
  ADD PRIMARY KEY (`id_ente_usuario`);

--
-- Indices de la tabla `feriados`
--
ALTER TABLE `feriados`
  ADD PRIMARY KEY (`id_feriado`);

--
-- Indices de la tabla `impresiones`
--
ALTER TABLE `impresiones`
  ADD PRIMARY KEY (`id_impresion`);

--
-- Indices de la tabla `impresiones_campos`
--
ALTER TABLE `impresiones_campos`
  ADD PRIMARY KEY (`id_campo`);

--
-- Indices de la tabla `leyendas`
--
ALTER TABLE `leyendas`
  ADD PRIMARY KEY (`id_leyenda`);

--
-- Indices de la tabla `localidades`
--
ALTER TABLE `localidades`
  ADD PRIMARY KEY (`id_localidad`),
  ADD KEY `cp` (`codigo_postal`);

--
-- Indices de la tabla `logs_usuarios`
--
ALTER TABLE `logs_usuarios`
  ADD PRIMARY KEY (`id_log`);

--
-- Indices de la tabla `lotes`
--
ALTER TABLE `lotes`
  ADD PRIMARY KEY (`id_lote`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id_notificacion`);

--
-- Indices de la tabla `pagos_boletas`
--
ALTER TABLE `pagos_boletas`
  ADD PRIMARY KEY (`id_pago`);

--
-- Indices de la tabla `pagos_tarjetas`
--
ALTER TABLE `pagos_tarjetas`
  ADD PRIMARY KEY (`id_pago`);

--
-- Indices de la tabla `perfiles`
--
ALTER TABLE `perfiles`
  ADD PRIMARY KEY (`id_perfil`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`id_permiso`);

--
-- Indices de la tabla `provincias`
--
ALTER TABLE `provincias`
  ADD PRIMARY KEY (`id_provincia`);

--
-- Indices de la tabla `tarjetas`
--
ALTER TABLE `tarjetas`
  ADD PRIMARY KEY (`id_tarjeta`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `afiliados`
--
ALTER TABLE `afiliados`
  MODIFY `id_afiliado` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `afiliados_entes`
--
ALTER TABLE `afiliados_entes`
  MODIFY `id_afiliado_ente` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `alertas`
--
ALTER TABLE `alertas`
  MODIFY `id_alerta` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `archivos`
--
ALTER TABLE `archivos`
  MODIFY `id_archivo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `archivos_origen`
--
ALTER TABLE `archivos_origen`
  MODIFY `id_origen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `barcore`
--
ALTER TABLE `barcore`
  MODIFY `id_barcore` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `barcore_formatos`
--
ALTER TABLE `barcore_formatos`
  MODIFY `id_formato` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `barcore_tipos`
--
ALTER TABLE `barcore_tipos`
  MODIFY `id_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT de la tabla `boletas`
--
ALTER TABLE `boletas`
  MODIFY `id_boleta` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `config`
--
ALTER TABLE `config`
  MODIFY `id_config` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `config_archivos`
--
ALTER TABLE `config_archivos`
  MODIFY `id_config` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `convenios`
--
ALTER TABLE `convenios`
  MODIFY `id_convenio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `emails`
--
ALTER TABLE `emails`
  MODIFY `id_email` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `entes`
--
ALTER TABLE `entes`
  MODIFY `id_ente` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `entes_usuarios`
--
ALTER TABLE `entes_usuarios`
  MODIFY `id_ente_usuario` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `feriados`
--
ALTER TABLE `feriados`
  MODIFY `id_feriado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `impresiones`
--
ALTER TABLE `impresiones`
  MODIFY `id_impresion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `impresiones_campos`
--
ALTER TABLE `impresiones_campos`
  MODIFY `id_campo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT de la tabla `leyendas`
--
ALTER TABLE `leyendas`
  MODIFY `id_leyenda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `logs_usuarios`
--
ALTER TABLE `logs_usuarios`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `lotes`
--
ALTER TABLE `lotes`
  MODIFY `id_lote` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id_notificacion` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `pagos_boletas`
--
ALTER TABLE `pagos_boletas`
  MODIFY `id_pago` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `pagos_tarjetas`
--
ALTER TABLE `pagos_tarjetas`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `perfiles`
--
ALTER TABLE `perfiles`
  MODIFY `id_perfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT de la tabla `tarjetas`
--
ALTER TABLE `tarjetas`
  MODIFY `id_tarjeta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
