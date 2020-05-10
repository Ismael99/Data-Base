CREATE DATABASE demo_funciones;
USE demo_funciones;

CREATE TABLE empleados(
empleados_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
empleados_nombres VARCHAR(50) NOT NULL,
empleados_apellidos VARCHAR(50) NOT NULL,
empleados_cargo VARCHAR(100) NOT NULL,
empleados_salario DECIMAL(7, 2) NOT NULL,
CONSTRAINT PK_EMP_ID PRIMARY KEY(empleados_id)
);

DESCRIBE empleados;

INSERT INTO empleados(empleados_nombres, empleados_apellidos, empleados_cargo, empleados_salario)
VALUES 
('Anastacia', 'Rosales', 'Gerente General', 3500.00),
('Margarita', 'Portillo', 'Supervisora', 1500.00),
('Eufragio', 'Marrufo', 'Cajero', 350.00),
('Perengano', 'Juliano', 'Vigilante',300.00),
('Edison', 'Amancio', 'Sistemas',1500);

select * from empleados;

#Funcion que calcula la renta 

DELIMITER $$
CREATE FUNCTION calcularRenta(empleados_salario DECIMAL(7, 2)) RETURNS DECIMAL(7, 2)
BEGIN	
	DECLARE RENTA DECIMAL(7, 2);
	SET RENTA = empleados_salario * 0.1;
	RETURN RENTA;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION calcularAFP(empleados_salario DECIMAL(7, 2)) RETURNS DECIMAL(7, 2)
BEGIN	
	DECLARE AFP DECIMAL(7, 2);
	SET AFP = empleados_salario * 0.0725;
	RETURN AFP;
END$$
DELIMITER ;

CREATE VIEW ViewEmpleados AS
SELECT CONCAT(P.empleados_nombres , ' ', P.empleados_apellidos) EMPLEADO,
P.empleados_salario SALARIO, calcularRenta(empleados_salario) AS RENTA, calcularAFP(empleados_salario) AS AFP
FROM empleados P;

select * from ViewEmpleados;

