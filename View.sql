CREATE DATABASE ventas;
USE ventas;

CREATE TABLE estados(
estados_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
estados_estado VARCHAR(25) UNIQUE NOT NULL,
estados_corto CHAR(5) UNIQUE NOT NULL,
estados_creado DATETIME DEFAULT CURRENT_TIMESTAMP,
estados_modificado DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT PK_EST_ID PRIMARY KEY(estados_id) 
)

DESCRIBE estados;

INSERT INTO  estados(estados_estado, estados_corto)
VALUES
('ACTIVO', 'AC'),
('INACTIVO', 'IN'),
('BLOQUEADO', 'BL');

SELECT * FROM estados;


CREATE TABLE roles(
roles_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
roles_rol VARCHAR(25) UNIQUE NOT NULL, 
roles_corto VARCHAR(5) UNIQUE NOT NULL,
roles_descripcion VARCHAR(500) NOT NULL,
roles_creado DATETIME DEFAULT CURRENT_TIMESTAMP,
roles_modificado DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
estados_id INT UNSIGNED NOT NULL DEFAULT 1,
CONSTRAINT PK_ROL_ID PRIMARY KEY(roles_id),
CONSTRAINT FK_ROL_EST FOREIGN KEY(estados_id) 
REFERENCES estados(estados_id) ON UPDATE CASCADE ON DELETE RESTRICT      
)

DESCRIBE roles;


INSERT INTO roles (roles_rol, roles_corto, roles_descripcion)
VALUES
('ADMINISTRADOR', 'ADMIN', 'Administrador de la empresa, usualmente este usuario solo debe de ser asignado al/los propietarios y administrador/res que esta posea.'),
('GERENTE', 'GTE', 'Gerente se asigna a un tipo de usuario, que haces las veces de gerente de una empresa, sucursal o área.'),
('SUPERVISOR', 'SUP', 'Supervisor, se asigna a un tipo de usuario, que haces las veces de un supervisor de una empresa, sucursal o área.'),
('DIGITADOR', 'DIG', 'Digitador, se asigna a un tipo de usuario, que haces las veces de digitador de una empresa, sucursal o área.'),
('VENDEDOR', 'VEN', 'Vendedor, se asigna a un tipo de usuario que vende a tiempo completo, posiblemente gane comisiones.'),
('ENTRENAMIENTO', 'ENT', 'Entrenamiento, se asigna a usuarios que estan en proceso de entrenamiento dentro de una empresa.'),
('VENDEDOR TEMPORAL', 'VTEMP', 'Vendedor temporal, se asignan a vendedrores que se contratarán por un período temporal y que ya han pasado el proceso de entrenamiento.');

SELECT *FROM roles;

CREATE VIEW ViewRolesActivos AS
SELECT R.roles_id ID, R.roles_rol ROL, R.roles_corto ABR, 
R.roles_descripcion DESCRIPCION, E.estados_corto ESTADO
FROM roles R
JOIN estados E USING(estados_id)
WHERE R.estados_id=1;

SELECT * FROM ViewRolesActivos;


CREATE TABLE privilegios (
privilegios_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
privilegios_privilegio VARCHAR(500) UNIQUE NOT NULL,
privilegios_creado DATETIME DEFAULT CURRENT_TIMESTAMP,
privilegios_modificado DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
estados_id INT UNSIGNED NOT NULL DEFAULT 1,
CONSTRAINT PK_PRIV_ID PRIMARY KEY(privilegios_id),
CONSTRAINT FK_PRIV_EST FOREIGN KEY(estados_id) 
REFERENCES estados(estados_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

DESCRIBE privilegios;

INSERT INTO privilegios(privilegios_privilegio)
VALUES 
('Super Admin'),
('Ver Productos'), ('Agregar Productos'), ('Modificar Productos'),('Eliminar Productos'), ('CRUD Productos'), 
('Ver Estados'), ('Agregar Estados'), ('Modificar Estados'),('Eliminar Estados'), ('CRUD Estados'),
('Ver Roles'), ('Agregar Roles'), ('Modificar Roles'),('Eliminar Roles'), ('CRUD Roles'),
('Ver Empleados'), ('Agregar Empleados'), ('Modificar Empleados'),('Eliminar Empleados'), ('CRUD Empleados'),
('Ver Usuarios'), ('Agregar Usuarios'), ('Modificar Usuarios'),('Eliminar Usuarios'), ('CRUD Usuarios'),
('Ver Promociones'), ('Agregar Promociones'), ('Modificar Promociones'),('Eliminar Promociones'), ('CRUD Promociones'),
('Ver Ventas'), ('Agregar Ventas'), ('Modificar Ventas'),('Eliminar Ventas'), ('CRUD Ventas'),
('Ver Clientes'), ('Agregar Clientes'), ('Modificar Clientes'),('Eliminar Clientes'), ('CRUD Clientes'),
('Ver Proveedores'), ('Agregar Proveedores'), ('Modificar Proveedores'),('Eliminar Proveedores'), ('CRUD Proveedores'),
('Ver Cotizaciones'), ('Agregar Cotizaciones'), ('Modificar Cotizaciones'),('Eliminar Cotizaciones'), ('CRUD Cotizaciones'),
('Ver Inventario'), ('Agregar Inventario'), ('Modificar Inventario'),('Eliminar Inventario'), ('CRUD Inventario'),
('Ver Marcas'), ('Agregar Marcas'), ('Modificar Marcas'),('Eliminar Marcas'), ('CRUD Marcas'),
('Ver Descuentos'), ('Agregar Descuentos'), ('Modificar Descuentos'),('Eliminar Descuentos'), ('CRUD Descuentos');

SELECT *FROM privilegios 

DROP VIEW ViewPrivilegiosActivos

CREATE VIEW ViewPrivilegiosActivos AS
SELECT P.privilegios_id ID, P.privilegios_privilegio PRIVILEGIO, 
E.estados_corto ESTADO
FROM privilegios P
JOIN estados E USING(estados_id)
WHERE P.estados_id=1;

SELECT * FROM ViewPrivilegiosActivos