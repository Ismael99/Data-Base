CREATE DATABASE demo_json;
USE demo_json;

CREATE TABLE peliculas(
peliculas_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
peliculas_titulos VARCHAR(100) UNIQUE NOT NULL,
peliculas_etiquetas JSON NOT NULL,
PRIMARY KEY(peliculas_id)
);

INSERT INTO peliculas(peliculas_titulos, peliculas_etiquetas)
VALUES ('Avatar', '{"acerca": {"genero": "Accion", "Año": "2009", "Director": "James Cammeron"}}'),
('Avatar 2', '{"acerca": {"genero": "Fantasia", "Estreno": "2021", "Director": "James Cammeron"}}');

select * from peliculas;

SELECT peliculas_titulos, JSON_EXTRACT(peliculas_etiquetas, '$.acerca.genero') AS 'GENERO',
JSON_EXTRACT(peliculas_etiquetas, '$.acerca.Director') AS 'DIRECTOR',
JSON_EXTRACT(peliculas_etiquetas, '$.acerca.Año') AS 'Año',
JSON_EXTRACT(peliculas_etiquetas, '$.acerca.Estreno') AS 'ESTRENO'
FROM peliculas;


#Elimiar un valor de un dato tipo JSON
UPDATE peliculas 
SET peliculas_etiquetas = JSON_REMOVE(peliculas_etiquetas, '$.acerca.Año')
WHERE peliculas_id = 1;


SELECT peliculas_titulos,
peliculas_etiquetas->'$.acerca.genero' AS 'GENERO',
peliculas_etiquetas->'$.acerca.Director' AS 'DIRECTOR',
peliculas_etiquetas->'$.acerca.Año' AS 'AÑO',
peliculas_etiquetas->'$.acerca.Estreno' AS 'ESTRENO'
FROM peliculas;	


#ELIMINAR UN REGISTRO TIPO JSON
DELETE FROM peliculas WHERE peliculas_id = 1 AND 
JSON_EXTRACT(peliculas_etiquetas, '$.acerca.Año') = NULL;

SELECT * FROM peliculas;




