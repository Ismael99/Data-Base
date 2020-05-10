CREATE DATABASE demo_triggers;
USE demo_triggers;

CREATE TABLE productos(
productos_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
productos_producto VARCHAR(50) UNIQUE NOT NULL, 
productos_descripcion VARCHAR(200) NOT NULL,
productos_costo DECIMAL(6,2) NOT NULL,
productos_venta DECIMAL(6,2) NOT NULL,
productos_existencia INT(4) NOT NULL,
CONSTRAINT PK_PROD_ID PRIMARY KEY(productos_id) 
);

DESCRIBE productos;

INSERT INTO productos(productos_producto, productos_descripcion, 
productos_costo, productos_venta, productos_existencia)
VALUES 
('Acetaminofen MK', 'Acetaminofen MK 500mg',9.50 ,19 ,100),
('Amoxicilina MK', 'Amoxicilina MK 500mg',15 ,30 ,100 ),
('Clorferinamina SAIMED', 'Clorferinamina SAIMED 500MG',12 ,24 ,100 ),
('Panadol Ultra', 'Panadol Ultra 500mg',11 , 22, 100),
('Broxol 500ml', 'Ambroxol 500ml',6 ,12 ,50);

SELECT * FROM productos;


CREATE VIEW viewproductos AS
SELECT P.productos_id ID, P.productos_producto PRODUCTO, 
CONCAT('$ ', P.productos_costo) COSTO, CONCAT('$ ', P.productos_venta) VENTA,
P.productos_existencia EXISTENCIA
FROM productos P;

SELECT * FROM viewproductos;

DELIMITER $$
CREATE TRIGGER actualizarProductoVenta
BEFORE UPDATE ON productos 
FOR EACH ROW
BEGIN 
	IF NEW.productos_costo <> OLD.productos_costo THEN 
		SET NEW.productos_venta = NEW.productos_costo * 2;
	END IF;
END$$
DELIMITER ;

UPDATE productos SET productos_costo = 7 WHERE productos_id = 5;
SELECT * FROM productos


CREATE TABLE empleados 
(

empleados_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
empleados_nombres VARCHAR(50) NOT NULL,
empleados_apellidos VARCHAR(50) NOT NULL,
empleados_cargo VARCHAR(50) NOT NULL,
empleados_salario DECIMAL(7, 2) NOT NULL,
empleados_anios_laborando DECIMAL(3, 1)NOT NULL,
CONSTRAINT PK_EMP_ID PRIMARY KEY(empleados_id)
);

CREATE VIEW viewempleados AS
SELECT CONCAT(E.empleados_nombres, ' ', E.empleados_apellidos) EMPLEADO,
E.empleados_salario SALARIO, E.empleados_anios_laborando TIEMPO
FROM empleados E;

INSERT INTO empleados(empleados_nombres, empleados_apellidos, 
empleados_cargo, empleados_salario, empleados_anios_laborando)
VALUES 
('Ismael', 'Portillo', 'Desarrollador',865.50 , 1.5),
('Jose', 'Zelaya', 'Gerente',535.75 ,0.5 ),
('Manuel', 'Hernandez', 'Redes',680.40 , 3.5);

SELECT * FROM viewempleados;


DELIMITER $$
CREATE TRIGGER actualizarEmpleadosSalario
BEFORE UPDATE ON empleados 
FOR EACH ROW 
BEGIN 	
	IF NEW.empleados_anios_laborando > OLD.empleados_anios_laborando THEN 
		SET NEW.empleados_salario = OLD.empleados_salario * (1 + (NEW.empleados_anios_laborando * 2 * 0.05)); 
	END IF;
END$$
DELIMITER ;

UPDATE empleados SET empleados_anios_laborando = 4 WHERE empleados_id = 1;
SELECT * FROM productos 

SELECT * FROM empleados