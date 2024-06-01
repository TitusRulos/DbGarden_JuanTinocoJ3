CREATE DATABASE Jardineria;
use Jardineria;

CREATE TABLE gama_producto(
  id_gama VARCHAR(50) PRIMARY KEY,
  descripcion_texto TEXT,
  descripcion_html TEXT,
  imagen VARCHAR(256)
  );

CREATE TABLE proveedor(
  id_proveedor INT(10) PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50)NOT NULL,
  apellido2 VARCHAR(50),
  telefono INT(10)
  );

  
CREATE TABLE producto(
  codigo_producto INT(10) PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  gama_producto VARCHAR(50) NOT NULL,
  dimensiones_producto varchar(25),
  descripcion text,
  id_proveedor_producto INT(10), 
  cantidad_stock smallint(6) NOT NULL,
  precio_venta DECIMAL(15,2) NOT NULL,
  precio_proveedor DECIMAL(15,2),
  CONSTRAINT FK_gama_producto FOREIGN KEY (gama_producto) REFERENCES gama_producto(id_gama),
  CONSTRAINT FK_proveedor FOREIGN KEY (id_proveedor_producto) REFERENCES  proveedor(id_proveedor)
  );
  
CREATE TABLE tipo_tel(
  id_tipo_tel INT(10) PRIMARY KEY,
  nombre_tipo_tel VARCHAR(50) NOT NULL,
  descripcion_tipo_tel TEXT
  );
  
CREATE TABLE contacto(
  id_contacto INT(10) PRIMARY KEY,
  nombre_contacto VARCHAR(50) NOT NULL,
  apellido1_contacto VARCHAR(50) NOT NULL,
  apellido2_contacto VARCHAR(50),
  telefono_contacto INT(10) NOT NULL,
  tipo_telefono int(10),
  Foreign Key (tipo_telefono) REFERENCES tipo_tel(id_tipo_tel)
  );
  
CREATE TABLE forma_pago(
  id_forma_pago INT(10) PRIMARY KEY,
  nombre_forma_pago VARCHAR(50) NOT NULL,
  descripcion_forma_pago TEXT
  );
  
CREATE TABLE transaccion(
  id_transaccion VARCHAR(50),
  cod_cliente INT(10) NOT NULL,
  forma_pago_trasaccion INT(10) NOT NULL,
  fecha_transaccion DATE,
  total_transaccion DECIMAL (15,2),
  CONSTRAINT FK_forma_pago FOREIGN KEY (forma_pago_trasaccion) REFERENCES forma_pago(id_forma_pago)
  );

CREATE TABLE oficina(
  codigo_oficina VARCHAR(10) PRIMARY KEY,
  ciudad varchar(30) NOT NULL,
  region varchar(50),
  pais varchar(50),
  codigo_postal VARCHAR(10) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  linea_direccion1 VARCHAR(50) NOT NULL,
  linea_direccion2 VARCHAR(50)
  );
 
CREATE TABLE empleado(
  id_empleado INT(11) PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50),
  extension_empleado VARCHAR(10) NOT NULL,
  email VARCHAR(100) NOT NULL,
  codigo_oficina_empleado VARCHAR(10) NOT NULL,
  codigo_jefe INT(11),
  puesto VARCHAR(50),
  CONSTRAINT FK_jefe_empleado foreign key (codigo_jefe) REFERENCES empleado(id_empleado),
  CONSTRAINT FK_oficina_empleado FOREIGN KEY (codigo_oficina_empleado) REFERENCES oficina(codigo_oficina)
  );

  CREATE TABLE cliente(
  id_cliente INT(10) PRIMARY KEY,
  nombre_cliente VARCHAR(50) NOT NULL,
  apellido1_cliente VARCHAR(50) NOT NULL,
  apellido2_cliente VARCHAR(50),
  id_contacto_cliente INT(10),
  telefono_cliente varchar(15) NOT NULL,
  fax VARCHAR(15) NOT NULL,
  linea_direccion1 varchar(50) NOT NULL,
  linea_direccion2 VARCHAR(50),
  region VARCHAR(50) NOT NULL,
  ciudad VARCHAR(50) NOT NULL,
  pais VARCHAR(50) NOT NULL,
  codigo_postal_cliente varchar(10),
  codigo_empleado_rep_ventas INT(10),
  limite_credito DECIMAL(15,2),
  CONSTRAINT FK_contacto FOREIGN KEY (id_contacto_cliente) REFERENCES contacto(id_contacto),
  CONSTRAINT FK_representante_ventas FOREIGN KEY (codigo_empleado_rep_ventas) REFERENCES empleado(id_empleado)
);

CREATE TABLE pedido(
  codigo_pedido INT(11) PRIMARY KEY,
  fecha_pedido DATE NOT NULL,
  fecha_esperada DATE NOT NULL,
  fecha_entrega DATE, 
  estado_pedido ENUM('Pendiente', 'Entregado', 'Enviado', 'Rechazado') NOT NULL,
  comentarios TEXT,
  tipo_pago int(10),
  constraint fk_tipo_pago foreign key (tipo_pago) references forma_pago(id_forma_pago),
  codigo_cliente_pedido INT(10) NOT NULL,
  CONSTRAINT FK_cliente_pedido FOREIGN KEY (codigo_cliente_pedido) REFERENCES cliente(id_cliente)
  );

CREATE TABLE detalle_pedido(
  codigo_pedido_detalle INT(10) NOT NULL,
  codigo_producto_pedido INT(10) NOT NULL,
  cantidad INT(11) NOT NULL,
  precio_unidad DECIMAL(15,2) NOT NULL,
  numero_linea SMALLINT(6) NOT NULL,
  PRIMARY KEY (codigo_pedido_detalle, codigo_producto_pedido),
  CONSTRAINT FK_producto_pedido FOREIGN KEY (codigo_producto_pedido) REFERENCES producto(codigo_producto),
  CONSTRAINT FK_codigo_pedido FOREIGN KEY (codigo_pedido_detalle) REFERENCES pedido(codigo_pedido)
  );
 
INSERT INTO gama_producto (id_gama, descripcion_texto, descripcion_html, imagen) VALUES
('GP001', 'Herramientas de jardinería', 'Descripción de herramientas de jardinería en formato HTML', 'herramientas.jpg'),
('GP002', 'Plantas de interior', 'Descripción de plantas de interior en formato HTML', 'plantas_interior.jpg'),
('GP003', 'Mobiliario de jardín', 'Descripción de mobiliario de jardín en formato HTML', 'muebles_jardin.jpg'),
('GP004', 'Decoración exterior', 'Descripción de decoración exterior en formato HTML', 'decoracion_exterior.jpg'),
('GP005', 'Iluminación para exteriores', 'Descripción de iluminación para exteriores en formato HTML', 'iluminacion_exterior.jpg'),
('GP006', 'Fertilizantes y sustratos', 'Descripción de fertilizantes y sustratos en formato HTML', 'fertilizantes.jpg'),
('GP007', 'Piscinas y accesorios', 'Descripción de piscinas y accesorios en formato HTML', 'piscinas.jpg'),
('GP008', 'Semillas y bulbos', 'Descripción de semillas y bulbos en formato HTML', 'semillas.jpg'),
('GP009', 'Muebles de terraza', 'Descripción de muebles de terraza en formato HTML', 'muebles_terraza.jpg'),
('GP010', 'Herramientas de poda', 'Descripción de herramientas de poda en formato HTML', 'herramientas_poda.jpg');

INSERT INTO proveedor (id_proveedor, nombre, apellido1, apellido2, telefono) VALUES
(1, 'Jardinería S.A.', 'González', 'Martínez', 123456789),
(2, 'Plantas del Sur', 'Díaz', 'López', 987654321),
(3, 'Muebles de Exterior', 'García', 'Pérez', 654321987),
(4, 'Iluminación Moderna', 'Rodríguez', 'Sánchez', 456789123),
(5, 'Decoraciones del Patio', 'Martínez', 'Gómez', 789123456),
(6, 'Herramientas Profesionales', 'López', 'Díaz', 321987654),
(7, 'Semillas de Calidad', 'Pérez', 'García', 654987321),
(8, 'Muebles Elegantes', 'Sánchez', 'Rodríguez', 147258369),
(9, 'Decoración Creativa', 'Gómez', 'Martínez', 258369147),
(10, 'Accesorios para Piscinas', 'Fernández', 'López', 369147258);


INSERT INTO producto (codigo_producto, nombre, gama_producto, dimensiones_producto, descripcion, id_proveedor_producto, cantidad_stock, precio_venta, precio_proveedor) VALUES
(1, 'Cortadora de césped eléctrica', 'GP001', '50x30x40 cm', 'Cortadora de césped eléctrica para uso doméstico.', 1, 20, 199.99, 150.00),
(2, 'Maceta de cerámica', 'GP004', '20x20x20 cm', 'Maceta de cerámica para plantas de interior.', 2, 100, 9.99, 5.00),
(3, 'Sillón de mimbre', 'GP003', '80x60x70 cm', 'Sillón de mimbre para exteriores.', 3, 10, 149.99, 120.00),
(4, 'Farol solar LED', 'GP005', '15x15x30 cm', 'Farol solar LED para iluminación exterior.', 4, 50, 29.99, 20.00),
(5, 'Abono orgánico', 'GP006', NULL, 'Abono orgánico para mejorar la calidad del suelo.', 5, 200, 14.99, 10.00),
(6, 'Kit de mantenimiento para piscinas', 'GP007', NULL, 'Kit de mantenimiento completo para piscinas.', 6, 5, 99.99, 80.00),
(7, 'Semillas de tomate', 'GP008', NULL, 'Semillas de tomate de la variedad "cherry".', 7, 300, 4.99, 2.50),
(8, 'Mesa de jardín plegable', 'GP003', '100x80x70 cm', 'Mesa de jardín plegable con estructura de aluminio.', 8, 20, 79.99, 60.00),
(9, 'Estacas para plantas trepadoras', 'GP004', '120 cm', 'Estacas metálicas para soportar plantas trepadoras.', 9, 50, 9.99, 7.00),
(10, 'Fertilizante líquido para césped', 'GP006', NULL, 'Fertilizante líquido concentrado para césped.', 10, 100, 19.99, 15.00);

INSERT INTO tipo_tel (id_tipo_tel, nombre_tipo_tel, descripcion_tipo_tel) VALUES
(1, 'Móvil', 'Número de teléfono móvil.'),
(2, 'Fijo', 'Número de teléfono fijo.'),
(3, 'Trabajo', 'Número de teléfono del trabajo.');

INSERT INTO contacto (id_contacto, nombre_contacto, apellido1_contacto, apellido2_contacto, telefono_contacto, tipo_telefono) VALUES
(1, 'Juan', 'González', 'Martínez', 123456789, 1),
(2, 'María', 'Díaz', 'López', 987654321, 2),
(3, 'Pedro', 'García', 'Pérez', 654321987, 1),
(4, 'Laura', 'Rodríguez', 'Sánchez', 456789123, 2),
(5, 'Ana', 'Martínez', 'Gómez', 789123456, 1),
(6, 'Carlos', 'López', 'Díaz', 321987654, 2),
(7, 'Sofía', 'Pérez', 'García', 654987321, 1),
(8, 'Pablo', 'Sánchez', 'Rodríguez', 147258369, 2),
(9, 'Elena', 'Gómez', 'Martínez', 258369147, 1),
(10, 'Miguel', 'Fernández', 'López', 369147258, 2);

INSERT INTO forma_pago (id_forma_pago, nombre_forma_pago, descripcion_forma_pago) VALUES
(1, 'Tarjeta de crédito', 'Pago realizado con tarjeta de crédito.'),
(2, 'Transferencia bancaria', 'Pago realizado mediante transferencia bancaria.'),
(3, 'Paypal', 'Pago realizado a través de la plataforma Paypal.'),
(4, 'Cheque', 'Pago realizado mediante cheque.'),
(5, 'Efectivo', 'Pago realizado en efectivo.'),
(6, 'Pago a plazos', 'Pago realizado en cuotas mensuales.'),
(7, 'Pago con puntos', 'Pago realizado utilizando puntos acumulados en el programa de fidelización.'),
(8, 'Criptomoneda', 'Pago realizado con una criptomoneda como Bitcoin o Ethereum.'),
(9, 'Giro postal', 'Pago realizado mediante giro postal.'),
(10, 'Cargo en cuenta', 'Pago realizado cargando el importe a una cuenta bancaria.');

INSERT INTO transaccion (id_transaccion, cod_cliente, forma_pago_trasaccion, fecha_transaccion, total_transaccion) VALUES
('TRX001', 1, 3, '2023-05-10', 150.00),
('TRX002', 2, 1, '2023-05-12', 250.00),
('TRX003', 3, 2, '2023-05-15', 180.00),
('TRX004', 4, 5, '2023-05-18', 50.00),
('TRX005', 5, 4, '2023-05-20', 120.00),
('TRX006', 6, 6, '2023-05-22', 300.00),
('TRX007', 7, 7, '2023-05-25', 70.00),
('TRX008', 8, 8, '2023-05-28', 400.00),
('TRX009', 9, 9, '2023-05-30', 90.00),
('TRX010', 10, 10, '2023-06-02', 600.00);

INSERT INTO oficina (codigo_oficina, ciudad, region, pais, codigo_postal, telefono, linea_direccion1, linea_direccion2) VALUES
('OF011', 'Londres', NULL, 'Reino Unido', 'W1A 1AA', '+44 20 1234 5678', '123 Oxford Street', 'Suite 101'),
('OF012', 'París', NULL, 'Francia', '75001', '+33 1 2345 6789', '15 Rue de Rivoli', NULL),
('OF013', 'Berlín', NULL, 'Alemania', '10178', '+49 30 3456 7890', 'Alexanderplatz 1', 'Eingang A'),
('OF014', 'Roma', NULL, 'Italia', '00184', '+39 06 4567 8901', 'Piazza di Spagna, 1', 'Scala B'),
('OF015', 'Ámsterdam', NULL, 'Países Bajos', '1012 JW', '+31 20 5678 9012', 'Dam Square 1', 'Floor 2'),
('OF016', 'Tokio', NULL, 'Japón', '100-8111', '+81 3 6789 0123', '1 Chome-1-1 Marunouchi', 'Marunouchi Building'),
('OF017', 'Sídney', 'Nueva Gales del Sur', 'Australia', '2000', '+61 2 9012 3456', '1 Martin Place', 'Level 10'),
('OF018', 'Toronto', 'Ontario', 'Canadá', 'M5H 1J9', '+1 416-345-6789', '100 King Street West', 'Suite 500'),
('OF019', 'Ciudad de México', 'CDMX', 'México', '06100', '+52 55 7890 1234', 'Paseo de la Reforma 250', 'Torre Ejecutiva'),
('OF020', 'São Paulo', 'São Paulo', 'Brasil', '01001-000', '+55 11 1234 5678', 'Avenida Paulista, 100', 'Andar 25');

INSERT INTO empleado (id_empleado, nombre, apellido1, apellido2, extension_empleado, email, codigo_oficina_empleado, codigo_jefe, puesto) VALUES
(101, 'John', 'Smith', NULL, '101', 'john.smith@example.com', 'OF011', NULL, 'Gerente de Ventas'),
(102, 'Maria', 'García', 'López', '102', 'maria.garcia@example.com', 'OF012', 101, 'Supervisor de Ventas'),
(103, 'David', 'Johnson', NULL, '103', 'david.johnson@example.com', 'OF013', 101, 'Especialista en Marketing'),
(104, 'Anna', 'Martínez', 'Gómez', '104', 'anna.martinez@example.com', 'OF014', 102, 'Representante de Ventas'),
(105, 'Michael', 'Chen', NULL, '105', 'michael.chen@example.com', 'OF015', 102, 'Representante de Ventas'),
(106, 'Sophie', 'Dupont', NULL, '106', 'sophie.dupont@example.com', 'OF016', 101, 'Contador'),
(107, 'Andreas', 'Müller', NULL, '107', 'andreas.muller@example.com', 'OF017', 101, 'Gerente de Almacén'),
(108, 'Isabella', 'Fernández', 'López', '108', 'isabella.fernandez@example.com', 'OF018', 101, 'Analista de Datos'),
(109, 'Juan', 'Silva', NULL, '109', 'juan.silva@example.com', 'OF019', 101, 'Desarrollador Web'),
(110, 'Sophia', 'Kim', NULL, '110', 'sophia.kim@example.com', 'OF020', 102, 'Diseñador Gráfico');


INSERT INTO cliente (id_cliente, nombre_cliente, apellido1_cliente, apellido2_cliente, id_contacto_cliente, telefono_cliente, fax, linea_direccion1, linea_direccion2, region, ciudad, pais, codigo_postal_cliente, codigo_empleado_rep_ventas, limite_credito) VALUES
(501, 'Juan', 'Gómez', NULL, 1, '123456789', '123456789', 'Calle Mayor, 1', NULL, 'Comunidad de Madrid', 'Madrid', 'España', '28001', 104, 1000.00),
(502, 'María', 'Rodríguez', 'Martínez', 2, '987654321', '987654321', 'Plaza España, 5', NULL, 'Cataluña', 'Barcelona', 'España', '08001', 105, 1500.00),
(503, 'David', 'López', 'Pérez', 3, '654321987', '654321987', 'Avenida Libertad, 10', NULL, 'Andalucía', 'Sevilla', 'España', '41001', 106, 2000.00),
(504, 'Ana', 'García', 'Fernández', 4, '456789123', '456789123', 'Calle Alameda, 15', NULL, 'Valencia', 'Valencia', 'España', '46001', 107, 2500.00),
(505, 'Carlos', 'Martínez', NULL, 5, '789123456', '789123456', 'Calle Gran Vía, 20', NULL, 'País Vasco', 'Bilbao', 'España', '48001', 108, 3000.00),
(506, 'Laura', 'Díaz', NULL, 6, '321987654', '321987654', 'Calle Mayor, 25', NULL, 'Andalucía', 'Málaga', 'España', '29001', 109, 3500.00),
(507, 'Pablo', 'Pérez', 'Gómez', 7, '654987321', '654987321', 'Paseo del Puerto, 30', NULL, 'Comunidad Valenciana', 'Alicante', 'España', '03001', 110, 4000.00),
(508, 'Elena', 'Gómez', 'Hernández', 8, '147258369', '147258369', 'Avenida Diagonal, 35', NULL, 'Cataluña', 'Tarragona', 'España', '43001', 104, 4500.00),
(509, 'Miguel', 'Hernández', 'Pérez', 9, '258369147', '258369147', 'Paseo de Gracia, 40', NULL, 'Castilla-La Mancha', 'Toledo', 'España', '45001', 105, 5000.00),
(510, 'Sofía', 'López', NULL, 10, '369147258', '369147258', 'Calle Mayor, 45', NULL, 'Andalucía', 'Granada', 'España', '18001', 106, 5500.00);

INSERT INTO pedido (codigo_pedido, fecha_pedido, fecha_esperada, fecha_entrega, estado_pedido, comentarios, tipo_pago, codigo_cliente_pedido) VALUES
(1001, '2024-01-10', '2024-01-15', '2024-01-17', 'Entregado', 'Todo en perfecto estado.', 1, 501),
(1002, '2024-02-15', '2024-02-20', '2024-02-22', 'Entregado', 'Entrega rápida.', 2, 502),
(1003, '2024-03-20', '2024-03-25', '2024-03-28', 'Entregado', 'Cliente satisfecho.', 3, 503),
(1004, '2024-04-25', '2024-04-30', NULL, 'Pendiente', 'En espera de confirmación.', 4, 504),
(1005, '2024-05-01', '2024-05-05', NULL, 'Pendiente', 'Producto fuera de stock.', 5, 505),
(1006, '2024-06-10', '2024-06-15', NULL, 'Pendiente', 'Cliente solicita cambio.', 6, 506),
(1007, '2024-07-15', '2024-07-20', NULL, 'Pendiente', 'Pago a plazos.', 7, 507),
(1008, '2024-08-20', '2024-08-25', NULL, 'Pendiente', 'Cliente utiliza puntos de fidelidad.', 8, 508),
(1009, '2024-09-25', '2024-09-30', NULL, 'Pendiente', 'Cliente pide factura.', 9, 509),
(1010, '2024-10-30', '2024-11-05', NULL, 'Pendiente', 'Cliente desea entrega en domicilio.', 10, 510);

INSERT INTO detalle_pedido (codigo_pedido_detalle, codigo_producto_pedido, cantidad, precio_unidad, numero_linea) VALUES
(1001, 1, 2, 25.00, 1),
(1001, 2, 1, 50.00, 2),
(1002, 3, 3, 30.00, 1),
(1002, 4, 2, 40.00, 2),
(1003, 5, 1, 20.00, 1),
(1003, 6, 4, 15.00, 2),
(1004, 7, 2, 35.00, 1),
(1005, 8, 3, 45.00, 1),
(1006, 9, 1, 60.00, 1),
(1007, 10, 2, 70.00, 1);


--Consultas sobre una tabla

--1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

select codigo_oficina, ciudad as ciudad_oficina from oficina;

-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

select ciudad as ciudad_oficina , telefono as telefono_oficina from oficina where pais= "España";

-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
jefe tiene un código de jefe igual a 7.

select nombre as nombre_empleado, apellido1 as apellido_1_empleado, apellido2 as apellido2_empleado, email from empleado where codigo_jefe = 7;

-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
empresa.

select puesto, nombre, apellido1 as apellido_1_empleado, apellido2 as apellido_2_empleado, email from empleado where codigo_jefe is null;

-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
empleados que no sean representantes de ventas.

SELECT nombre AS nombre_empleado, apellido1 AS primer_apellido, apellido2 AS segundo_apellido, puesto 
FROM empleado 
WHERE puesto <> 'representante de ventas';

-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
select nombre_cliente from cliente where pais = "España";

-- 7. Devuelve un listado con los distintos estados por los que puede pasar un
-- pedido.

select distinct estado_pedido from pedido;

/* 8. Devuelve un listado con el código de cliente de aquellos clientes que
realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
• Utilizando la función YEAR de MySQL.
• Utilizando la función DATE_FORMAT de MySQL.
• Sin utilizar ninguna de las funciones anteriores */

SELECT DISTINCT cod_cliente
FROM transaccion
WHERE YEAR(fecha_transaccion) = 2008;

SELECT DISTINCT cod_cliente
FROM transaccion
WHERE DATE_FORMAT(fecha_transaccion, '%Y') = '2008';

SELECT DISTINCT cod_cliente
FROM transaccion
WHERE fecha_transaccion >= '2008-01-01'
AND fecha_transaccion < '2009-01-01';

/* 9. Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos que no han sido entregados a
tiempo*/

SELECT codigo_pedido, codigo_cliente_pedido, fecha_esperada, fecha_entrega 
FROM pedido 
WHERE fecha_entrega > fecha_esperada AND estado_pedido != 'Entregado';

/*
10. Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
menos dos días antes de la fecha esperada.
*/

SELECT codigo_pedido, codigo_cliente_pedido, fecha_esperada, fecha_entrega 
FROM pedido 
WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2; 

-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

SELECT codigo_pedido, fecha_pedido, estado_pedido
FROM pedido
WHERE estado_pedido = 'Rechazado' AND YEAR(fecha_pedido) = 2009;

/*
12. Devuelve un listado de todos los pedidos que han sido entregados en el
mes de enero de cualquier año.
*/

select codigo_pedido from pedido where month(fecha_entrega) = 1;

/*
13. Devuelve un listado con todos los pagos que se realizaron en el
año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
*/

select codigo_pedido, f.nombre_forma_pago as forma_pago, fecha_pedido 
from pedido p 
join forma_pago f 
on f.id_forma_pago = p.tipo_pago 
where f.nombre_forma_pago = "Paypal" 
and year(fecha_pedido) = 2008 order by date(fecha_pedido) asc;

/* 14. Devuelve un listado con todas las formas de pago que aparecen en la
tabla pago. Tenga en cuenta que no deben aparecer formas de pago
repetidas.*/

SELECT DISTINCT nombre_forma_pago
FROM forma_pago;


/*
15. Devuelve un listado con todos los productos que pertenecen a la
gama Ornamentales y que tienen más de 100 unidades en stock. El listado
deberá estar ordenado por su precio de venta, mostrando en primer lugar
los de mayor precio.
*/
SELECT *
FROM producto
WHERE gama_producto = 'Ornamentales' AND cantidad_stock > 100
ORDER BY precio_venta DESC;


--16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
--cuyo representante de ventas tenga el código de empleado 11 o 30.

SELECT *
FROM cliente
WHERE ciudad = 'Madrid' AND codigo_empleado_rep_ventas IN (11, 30);


--Consultas multitabla (Composición interna)

--1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.

SELECT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c, empleado e
WHERE c.codigo_empleado_rep_ventas = e.id_empleado;

--2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.

SELECT DISTINCT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c, empleado e, pago p
WHERE c.id_cliente = p.id_cliente
AND c.codigo_empleado_rep_ventas = e.id_empleado;

--3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.

SELECT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c, empleado e
WHERE c.codigo_empleado_rep_ventas = e.id_empleado
AND c.id_cliente NOT IN (SELECT id_cliente FROM pago);

--4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

SELECT DISTINCT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
FROM cliente c, empleado e, pago p, oficina o
WHERE c.id_cliente = p.id_cliente
AND c.codigo_empleado_rep_ventas = e.id_empleado
AND e.codigo_oficina = o.codigo_oficina;

--5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
FROM cliente c, empleado e, oficina o
WHERE c.codigo_empleado_rep_ventas = e.id_empleado
AND e.codigo_oficina = o.codigo_oficina
AND c.id_cliente NOT IN (SELECT id_cliente FROM pago);

--6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

SELECT DISTINCT o.direccion
FROM oficina o, cliente c
WHERE c.codigo_oficina = o.codigo_oficina
AND c.ciudad = 'Fuenlabrada';

--7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
FROM cliente c, empleado e, oficina o
WHERE c.codigo_empleado_rep_ventas = e.id_empleado
AND e.codigo_oficina = o.codigo_oficina;

--8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

SELECT e1.nombre AS empleado_nombre, e2.nombre AS jefe_nombre
FROM empleado e1, empleado e2
WHERE e1.id_jefe = e2.id_empleado;

--9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.

SELECT e1.nombre AS empleado_nombre, e2.nombre AS jefe_nombre, e3.nombre AS jefe_de_jefe_nombre
FROM empleado e1
JOIN empleado e2 ON e1.id_jefe = e2.id_empleado
JOIN empleado e3 ON e2.id_jefe = e3.id_empleado;

--10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

SELECT DISTINCT c.nombre_cliente
FROM cliente c, pedido p
WHERE c.id_cliente = p.id_cliente
AND p.fecha_entrega > p.fecha_estimada_entrega;

--11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

SELECT DISTINCT c.nombre_cliente, gp.nombre_gama
FROM cliente c, pedido p, detalle_pedido dp, producto pr, gama_producto gp
WHERE c.id_cliente = p.id_cliente
AND p.numero_pedido = dp.numero_pedido
AND dp.codigo_producto = pr.codigo_producto
AND pr.codigo_gama = gp.codigo_gama;

--Consultas multitabla (Composición externa)

--1. Devuelve un listado que muestre solamente los clientes que no han
--realizado ningún pago.
SELECT c.*
FROM cliente c
LEFT JOIN transaccion t ON c.id_cliente = t.cod_cliente
WHERE t.cod_cliente IS NULL;

--2. Devuelve un listado que muestre solamente los clientes que no han
--realizado ningún pedido.

SELECT c.*
FROM cliente c
LEFT JOIN transaccion t ON c.id_cliente = t.cod_cliente
WHERE t.cod_cliente IS NULL;

--3. Devuelve un listado que muestre los clientes que no han realizado ningún
--pago y los que no han realizado ningún pedido.

SELECT c.*
FROM cliente c
LEFT JOIN transaccion t ON c.id_cliente = t.cod_cliente
LEFT JOIN pedido p ON c.id_cliente = p.codigo_cliente_pedido
WHERE t.cod_cliente IS NULL AND p.codigo_pedido IS NULL;


--4. Devuelve un listado que muestre solamente los empleados que no tienen
--una oficina asociada.

SELECT e.*
FROM empleado e
LEFT JOIN oficina o ON e.codigo_oficina_empleado = o.codigo_oficina
WHERE e.codigo_oficina_empleado IS NULL;

--5. Devuelve un listado que muestre solamente los empleados que no tienen un
--cliente asociado.

SELECT e.*
FROM empleado e
LEFT JOIN cliente c ON e.id_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_empleado_rep_ventas IS NULL;

--6. Devuelve un listado que muestre solamente los empleados que no tienen un
--cliente asociado junto con los datos de la oficina donde trabajan.

select e.nombre, e.apellido1, o.*
from empleado e 
left join cliente c on c.codigo_empleado_rep_ventas = e.id_empleado 
left join oficina o on o.codigo_oficina = e.id_empleado 
where c.codigo_empleado_rep_ventas is null ;

--7. Devuelve un listado que muestre los empleados que no tienen una oficina
--asociada y los que no tienen un cliente asociado.

SELECT e.nombre, e.apellido1 
FROM empleado e 
LEFT JOIN oficina o ON o.codigo_oficina = e.codigo_oficina_empleado 
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = e.id_empleado
WHERE e.codigo_oficina_empleado IS NULL AND c.codigo_empleado_rep_ventas IS NULL;


--8. Devuelve un listado de los productos que nunca han aparecido en un
--pedido.

SELECT *
FROM producto
WHERE codigo_producto NOT IN (SELECT DISTINCT codigo_producto_pedido FROM detalle_pedido);


/**9. Devuelve un listado de los productos que nunca han aparecido en un
pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
producto.
**/

SELECT p.nombre, p.descripcion, g.imagen
FROM producto p join gama_producto g on p.gama_producto = g.id_gama
WHERE codigo_producto NOT IN (SELECT DISTINCT codigo_producto_pedido FROM detalle_pedido);


/**10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
hayan sido los representantes de ventas de algún cliente que haya realizado
la compra de algún producto de la gama Frutales.
**/

SELECT *
FROM oficina o
WHERE codigo_oficina NOT IN (
    SELECT DISTINCT codigo_oficina_empleado
    FROM empleado
    WHERE id_empleado IN (
        SELECT DISTINCT codigo_empleado_rep_ventas
        FROM cliente
        JOIN transaccion ON cliente.id_cliente = transaccion.cod_cliente
        JOIN detalle_pedido ON transaccion.id_transaccion = detalle_pedido.codigo_pedido_detalle
        JOIN producto ON detalle_pedido.codigo_producto_pedido = producto.codigo_producto
        WHERE producto.gama_producto = 'Frutales'
    )
);


--11. Devuelve un listado con los clientes que han realizado algún pedido pero no
--han realizado ningún pago.

select c.nombre_cliente from cliente c 
left join pedido p on c.id_cliente = p.codigo_cliente_pedido 
where tipo_pago is null;

--12. Devuelve un listado con los datos de los empleados que no tienen clientes
--asociados y el nombre de su jefe asociado.

SELECT e.*, jefe.nombre AS nombre_jefe, jefe.apellido1 AS apellido1_jefe
FROM empleado e
LEFT JOIN empleado jefe ON e.codigo_jefe = jefe.id_empleado
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = e.id_empleado
WHERE c.codigo_empleado_rep_ventas IS NULL;


--Consultas resumen

--1. ¿Cuántos empleados hay en la compañía?

SELECT COUNT(*) AS total_empleados FROM empleado;

--2. ¿Cuántos clientes tiene cada país?

SELECT pais, COUNT(*) AS total_clientes 
FROM cliente 
GROUP BY pais;

--3. ¿Cuál fue el pago medio en 2009?

SELECT AVG(total_transaccion) AS pago_medio 
FROM transaccion 					no tenemos 2009 en db
WHERE YEAR(fecha_transaccion) = 2009;


--4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.

SELECT estado_pedido, COUNT(*) AS total_pedidos 
FROM pedido 
GROUP BY estado_pedido 
ORDER BY total_pedidos DESC;

--5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.

SELECT 
  MAX(precio_venta) AS precio_mas_caro,
  MIN(precio_venta) AS precio_mas_barato 
FROM producto;

--6. Calcula el número de clientes que tiene la empresa.

SELECT COUNT(*) AS total_clientes FROM cliente;

--7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

SELECT COUNT(*) AS total_clientes_madrid 
FROM cliente 
WHERE ciudad = 'Madrid';

--8. ¿Cuántos clientes tiene cada una de las ciudades que empiezan por M?

SELECT ciudad, COUNT(*) AS total_clientes 
FROM cliente 
WHERE ciudad LIKE 'M%' 
GROUP BY ciudad;

--9. Devuelve el nombre de los representantes de ventas y el número de clientes al que 
--atiende cada uno.

SELECT e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, COUNT(c.id_cliente) AS total_clientes 
FROM cliente c 
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.id_empleado 
GROUP BY e.id_empleado, e.nombre, e.apellido1;

--10. Calcula el número de clientes que no tiene asignado representante de ventas.

SELECT COUNT(*) AS clientes_sin_representante 
FROM cliente 
WHERE codigo_empleado_rep_ventas IS NULL;

--11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. 
--El listado deberá mostrar el nombre y los apellidos de cada cliente.

SELECT 
  c.nombre_cliente, 
  c.apellido1_cliente, 
  c.apellido2_cliente, 
  MIN(t.fecha_transaccion) AS primer_pago, 
  MAX(t.fecha_transaccion) AS ultimo_pago 
FROM cliente c 
JOIN transaccion t ON c.id_cliente = t.cod_cliente 
GROUP BY c.id_cliente, c.nombre_cliente, c.apellido1_cliente, c.apellido2_cliente;

--12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.

SELECT 
  codigo_pedido_detalle, 
  COUNT(DISTINCT codigo_producto_pedido) AS productos_diferentes 
FROM detalle_pedido 
GROUP BY codigo_pedido_detalle;

--13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.

SELECT 
  codigo_pedido_detalle, 
  SUM(cantidad) AS cantidad_total_productos 
FROM detalle_pedido 
GROUP BY codigo_pedido_detalle;

--14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido.

SELECT 
  p.nombre, 
  SUM(dp.cantidad) AS total_unidades_vendidas 
FROM detalle_pedido dp 
JOIN producto p ON dp.codigo_producto_pedido = p.codigo_producto 
GROUP BY p.codigo_producto 
ORDER BY total_unidades_vendidas DESC 
LIMIT 20;

--15. Facturación total de la empresa (base imponible, IVA y total facturado)

SELECT 
    SUM(dp.cantidad * p.precio_unidad) AS base_imponible,
    SUM(dp.cantidad * p.precio_unidad) * 0.21 AS iva,
    SUM(dp.cantidad * p.precio_unidad) * 1.21 AS total_facturado
FROM 
    detalle_pedido dp
JOIN 
    producto p ON dp.codigo_producto_pedido = p.codigo_producto;


--16. Facturación total de la empresa agrupada por código de producto

SELECT 
    dp.codigo_producto_pedido,
    SUM(dp.cantidad * p.precio_unidad) AS base_imponible,
    SUM(dp.cantidad * p.precio_unidad) * 0.21 AS iva,
    SUM(dp.cantidad * p.precio_unidad) * 1.21 AS total_facturado
FROM 
    detalle_pedido dp
JOIN 
    producto p ON dp.codigo_producto_pedido = p.codigo_producto
GROUP BY 
    dp.codigo_producto_pedido;

--17. Facturación total de la empresa agrupada por código de producto, filtrada por códigos que 
--empiecen por "OR"

SELECT 
    dp.codigo_producto_pedido,
    SUM(dp.cantidad * p.precio_unidad) AS base_imponible,
    SUM(dp.cantidad * p.precio_unidad) * 0.21 AS iva,
    SUM(dp.cantidad * p.precio_unidad) * 1.21 AS total_facturado
FROM 
    detalle_pedido dp
JOIN 
    producto p ON dp.codigo_producto_pedido = p.codigo_producto
WHERE 
    dp.codigo_producto_pedido LIKE 'OR%'
GROUP BY 
    dp.codigo_producto_pedido;

/**18. Lista las ventas totales de los productos que hayan facturado más de 3000 
euros. Se mostrará el nombre, unidades vendidas, total facturado y total 
facturado con impuestos (21% IVA).
**/

SELECT 
    p.nombre,
    SUM(dp.cantidad) AS unidades_vendidas,
    SUM(dp.cantidad * p.precio_unidad) AS total_facturado,
    SUM(dp.cantidad * p.precio_unidad) * 1.21 AS total_facturado_con_iva
FROM 
    detalle_pedido dp
JOIN 
    producto p ON dp.codigo_producto_pedido = p.codigo_producto
GROUP BY 
    p.codigo_producto, p.nombre
HAVING 
    total_facturado > 3000;

--19. Muestre la suma total de todos los pagos que se realizaron para cada uno 
--de los años que aparecen en la tabla pagos.

SELECT 
    YEAR(fecha_pago) AS ano,
    SUM(cantidad_pago) AS total_pago_anual
FROM 
    pago
GROUP BY 
    YEAR(fecha_pago);

--Subconsultas

--1. Devuelve el nombre del cliente con mayor límite de crédito.

SELECT nombre
FROM cliente
WHERE limite_credito = (SELECT MAX(limite_credito) FROM cliente);

--2.  Devuelve el nombre del producto que tenga el precio de venta más caro.


SELECT nombre
FROM producto
WHERE precio_unidad = (SELECT MAX(precio_unidad) FROM producto);

/**3. Devuelve el nombre del producto del que se han vendido más unidades. 
(Tenga en cuenta que tendrá que calcular cuál es el número total de 
unidades que se han vendido de cada producto a partir de los datos de la 
tabla detalle_pedido)
**/

SELECT p.nombre
FROM producto p
JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto_pedido
GROUP BY p.nombre
ORDER BY SUM(dp.cantidad) DESC
LIMIT 1;

--4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya 
realizado. (Sin utilizar INNER JOIN).

SELECT nombre
FROM cliente c
WHERE limite_credito > (SELECT SUM(cantidad_pago) FROM pago WHERE codigo_cliente = c.codigo_cliente);

--5. Devuelve el producto que más unidades tiene en stock

SELECT nombre
FROM producto
WHERE cantidad_stock = (SELECT MAX(cantidad_stock) FROM producto);

--6. Devuelve el producto que menos unidades tiene en stock.

SELECT nombre
FROM producto
WHERE cantidad_stock = (SELECT MIN(cantidad_stock) FROM producto);

--7. Devuelve el nombre, los apellidos y el email de los empleados que están a 
--cargo de Alberto Soria.
 
SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe = (SELECT codigo_empleado FROM empleado WHERE nombre = 'Alberto' AND apellido1 = 'Soria');

--Consultas variadas

/**1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos 
pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no 
han realizado ningún pedido.
**/

SELECT c.nombre AS nombre_cliente, 
       COUNT(dp.codigo_pedido) AS numero_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
GROUP BY c.nombre;

/**2. Devuelve un listado con los nombres de los clientes y el total pagado por 
cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han 
realizado ningún pago.
**/
SELECT c.nombre AS nombre_cliente, 
       COALESCE(SUM(p.cantidad_pago), 0) AS total_pagado
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
GROUP BY c.nombre;

--3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 
--ordenados alfabéticamente de menor a mayor.

SELECT DISTINCT c.nombre
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE YEAR(p.fecha_pedido) = 2008
ORDER BY c.nombre;

/**4. Devuelve el nombre del cliente, el nombre y primer apellido de su 
representante de ventas y el número de teléfono de la oficina del 
representante de ventas, de aquellos clientes que no hayan realizado ningún 
pago.
**/
SELECT c.nombre AS nombre_cliente, 
       e.nombre AS nombre_representante, 
       e.apellido1 AS apellido_representante, 
       o.telefono AS telefono_oficina
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE NOT EXISTS (SELECT 1 FROM pago p WHERE c.codigo_cliente = p.codigo_cliente);

--5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el 
--nombre y primer apellido de su representante de ventas y la ciudad donde 
--está su oficina.

SELECT c.nombre AS nombre_cliente, 
       e.nombre AS nombre_representante, 
       e.apellido1 AS apellido_representante, 
       o.ciudad AS ciudad_oficina
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

--6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos 
--empleados que no sean representante de ventas de ningún cliente.

SELECT e.nombre, 
       e.apellido1, 
       e.apellido2, 
       e.cargo, 
       o.telefono
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

--7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el 
--número de empleados que tiene.

SELECT o.ciudad, 
       COUNT(e.codigo_empleado) AS numero_empleados
FROM oficina o
JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
GROUP BY o.ciudad;




