# Manuel Dolores Cruz
USE empleados;
SELECT SUM(salario) 
FROM salarios 
WHERE fecha_inicio >= '1999-01-01';

# ¿Cuál es el promedio anual pagado a los empleados que comenzaron
# a trabajar a partir del año 2000?
SELECT AVG(salario) 
FROM salarios 
WHERE fecha_inicio >= '2000-01-01';

# Reedondee la cantidad promedio de dinero gastado en salarios para todos los contratos
# que comenzaron a paritr del 1 de enero de 1985 (>=) con una precisión de centavos (2 decimales)

SELECT ROUND(AVG(salario),2 ) 
FROM salarios 
WHERE fecha_inicio >= '1985-01-01';

# if null (un argumento)
# coalesce (n parametros)

DROP TABLE departamentos2;
CREATE TABLE departamentos2 (
    dept_id       CHAR(5) ,
    dept_nombre   VARCHAR(100)
);

# Clona los valores de departmentos a departamentos2
INSERT INTO departamentos2 
SELECT * FROM departamentos;

SELECT * FROM departamentos2;

INSERT INTO departamentos2
VALUES ('d010', null);

# Probamos IFNULL
SELECT dept_id, IFNULL(dept_nombre,'Nombre no asignado') AS NombreDepto
FROM departamentos2;

SELECT dept_id, COALESCE(dept_nombre,'Nombre no asignado') AS NombreDepto
FROM departamentos2;

# Agregar una nueva columna
ALTER TABLE departamentos2
ADD COLUMN col_nulls INT;

# Verificar valores nulos en dos columnas con COALESCE
SELECT dept_id, dept_nombre, col_nulls, COALESCE(dept_nombre, col_nulls, 'Nombre no asignado') AS Resultado
FROM departamentos2;

# JOINS
# INNER JOIN (Devuelve valores coincidentes en ambas tablas (intersección))
SELECT * FROM departamentos
ORDER BY dept_id;

SELECT * FROM gerente_depto
ORDER BY dept_id;

SELECT g.dept_id, g.emp_id, d.dept_nombre 
FROM gerente_depto g
INNER JOIN departamentos d on g.dept_id = d.dept_id
ORDER BY g.dept_id;

DELETE FROM departamentos2 
WHERE dept_id='d002';

INSERT INTO departamentos2(dept_nombre) 
VALUES ('Analisis de datos');

INSERT INTO departamentos2(dept_id) 
VALUES ('d010'),
('d011');

# Modificamos la tabla genrente-departamentos
DROP TABLE gerente_depto2;
CREATE TABLE gerente_depto2 (
   emp_id          INT             NOT NULL,
   dept_id         CHAR(4),
   fecha_inicio    DATE,
   fecha_fin       DATE
);

INSERT INTO gerente_depto2
SELECT * FROM gerente_depto;

SELECT * FROM gerente_depto2;
SELECT * FROM departamentos2;

INSERT INTO gerente_depto2 (emp_id, fecha_inicio)
VALUES (999904, '2025-01-01'),
(999905, '2025-01-01'),
(999906, '2025-01-01'),
(999907, '2025-01-01');

SELECT g.dept_id, g.emp_id, d.dept_nombre 
FROM gerente_depto2 g
INNER JOIN departamentos2 d on g.dept_id = d.dept_id
ORDER BY g.dept_id;
# actividad Seleccione el nombre, apellido, titulo de su cargo, nombre del departamento y la fecha de inicio en que fueron asignados gerentes de su respectivo departamento para todos los gerentes con el titulo de "Senior Engineer."


# LEFT JOIN (Devuelve los registros de la tabla 
# izquierda que no esten en la derecha, pero agrega la intersección)
SELECT g.dept_id, g.emp_id, d.dept_nombre 
FROM gerente_depto2 g
LEFT JOIN departamentos2 d on g.dept_id = d.dept_id
ORDER BY g.dept_id;
# actividad: Genere una lista con información del id de empleado, salario y titulo.

# RIGHT JOIN
SELECT d.dept_nombre, g.dept_id, g.emp_id 
FROM departamentos2 d
RIGHT JOIN gerente_depto2 g on g.dept_id = d.dept_id
ORDER BY d.dept_id;

# LEFT JOIN
# ¿Cuál es el id del genrente con mas salario? ¿Cuánto gana al año?
SELECT CONCAT('El empleado ', g.emp_id, ' del depto ', g.dept_id, ' gana $', s.salario) as MejorSalario
FROM gerente_depto g
LEFT JOIN salarios s on g.emp_id = s.emp_id
ORDER BY s.salario DESC LIMIT 1;

# CROSS JOIN (Se comporta como minner join mysql)

SELECT g.*, d.*
FROM gerente_depto g
INNER JOIN departamentos d ON g.dept_id = d.dept_id
ORDER BY g.emp_id, d.dept_id;

SELECT g.*, d.*
FROM gerente_depto g
CROSS JOIN departamentos d ON g.dept_id = d.dept_id
ORDER BY g.emp_id, d.dept_id;

SELECT g.*, d.*
FROM gerente_depto g
CROSS JOIN departamentos d 
ORDER BY g.emp_id, d.dept_id;

SELECT 
	g.*, e.*, d.*
FROM
	gerente_depto g
    CROSS JOIN
    departamentos d
    INNER JOIN
    empleados e ON g.emp_id=e.emp_id
ORDER BY g.emp_id, d.dept_id;

# ¿Cúal es el salario promedio de cada departamento?
# actividad: el salario promedio por género?

SELECT d.dept_nombre, ROUND(AVG(s.salario), 2) as PromedioDepto
FROM departamentos d
INNER JOIN gerente_depto g ON g.dept_id = d.dept_id
INNER JOIN salarios s ON g.emp_id = s.emp_id
GROUP BY d.dept_nombre
HAVING PromedioDepto > 70000
ORDER BY PromedioDepto DESC;

# Union (No genera repetidos)
# Union all (genera repetidos)

CREATE TABLE empleados2 (
    emp_id      INT,
    fecha_naci  DATE,
    nombre      VARCHAR(14),
    apellido   VARCHAR(16),
    genero      ENUM ('M','F'),    
    f_contra    DATE
);
DROP TABLE empleados2;

SELECT * FROM empleados2;
INSERT INTO empleados2
SELECT * FROM empleados LIMIT 10;

INSERT INTO empleados2
VALUES (10005, '1955-01-21', 'Kyoichi', 'Maliniak', 'M', '1989-09-12');

SELECT 
	e.emp_id, 
    e.nombre, 
	e.apellido, 
	null as dept_id, 
	null as fecha_inicio
FROM empleados2 e
UNION SELECT
	null as emp_id, 
    null as nombre, 
	null as apellido, 
	g.dept_id, 
	g.fecha_inicio
FROM gerente_depto g;

SELECT 
	e.emp_id, 
    e.nombre, 
	e.apellido, 
	null as dept_id, 
	null as fecha_inicio
FROM empleados2 e
UNION ALL SELECT
	null as emp_id, 
    null as nombre, 
	null as apellido, 
	g.dept_id, 
	g.fecha_inicio
FROM gerente_depto g;
	
# actividad: Una las tablas empleados y gerentes de departamento, seleccionando 
# la fecha de contratación, nombre, apellido (tabla empleados) y el ID de departamento 
# (tabla gerentes) para el ID de empleado 10010

# Subquery
# Saber los nombre y apellidos de los gerentes
# Saber el id de los gerentes
SELECT g.emp_id
FROM gerente_depto g;

# Nombres y apellidos de los empleados

SELECT e.nombre, e.apellido
FROM empleados e;

# Conjuntar la información
SELECT e.nombre, e.apellido
FROM empleados e
WHERE e.emp_id 
IN (SELECT g.emp_id FROM gerente_depto g);

# Ejemplo de varias líneas

SELECT
	GRUPOA.*
FROM
    (SELECT
		e.emp_id AS IDEmpleado,
		MIN(ed.dept_id) AS IDDepartamento,
		(SELECT 
			emp_id
		FROM
			gerente_depto
		WHERE
			emp_id = 110800) AS IDGerente
	FROM
		empleados e 
			INNER JOIN
		empleados_depto ed ON e.emp_id = ed.emp_id
	WHERE 
		e.emp_id <= 10010
	GROUP BY e.emp_id
	ORDER BY e.emp_id ASC) AS GRUPOA
UNION SELECT
	GRUPOB.*
FROM
    (SELECT
		e.emp_id AS IDEmpleado,
		MIN(ed.dept_id) AS IDDepartamento,
		(SELECT 
			emp_id
		FROM
			gerente_depto
		WHERE
			emp_id = 110854) AS IDGerente
	FROM
		empleados e 
			INNER JOIN
		empleados_depto ed ON e.emp_id = ed.emp_id
	WHERE 
		e.emp_id > 10010
	GROUP BY e.emp_id
	ORDER BY e.emp_id ASC
    LIMIT 10) AS GRUPOB 
    UNION SELECT
	GRUPOC.*
FROM
    (SELECT
		e.emp_id AS IDEmpleado,
		MIN(ed.dept_id) AS IDDepartamento,
		(SELECT 
			emp_id
		FROM
			gerente_depto
		WHERE
			emp_id = 110854) AS IDGerente
	FROM
		empleados e 
			INNER JOIN
		empleados_depto ed ON e.emp_id = ed.emp_id
	WHERE 
		e.emp_id = 110800
	GROUP BY e.emp_id) AS GRUPOC
    UNION SELECT
	GRUPOD.*
FROM
    (SELECT
		e.emp_id AS IDEmpleado,
		MIN(ed.dept_id) AS IDDepartamento,
		(SELECT 
			emp_id
		FROM
			gerente_depto
		WHERE
			emp_id = 110800 ) AS IDGerente
	FROM
		empleados e 
			INNER JOIN
		empleados_depto ed ON e.emp_id = ed.emp_id
	WHERE 
		e.emp_id = 110854
	GROUP BY e.emp_id) AS GRUPOD;
    
# Actividad para el jueves agregar a la consulta: 
# nombre de empleado, nombre del departamento, gerente a cargo del empleado


CREATE TABLE Empleados_gerentes (
	emp_id INT NOT NULL,
    dept_id CHAR(5) NOT NULL,
    gerente_id INT NOT NULL
);
DROP TABLE empleados_gerentes;

INSERT INTO empleados_gerentes
SELECT 
	unionGrupos.*
    FROM (SELECT
	GRUPOA.*
FROM
    (SELECT
		e.emp_id AS IDEmpleado,
		MIN(ed.dept_id) AS IDDepartamento,
		(SELECT 
			emp_id
		FROM
			gerente_depto
		WHERE
			emp_id = 110800) AS IDGerente
	FROM
		empleados e 
			INNER JOIN
		empleados_depto ed ON e.emp_id = ed.emp_id
	WHERE 
		e.emp_id <= 10010
	GROUP BY e.emp_id
	ORDER BY e.emp_id ASC) AS GRUPOA
UNION SELECT
	GRUPOB.*
FROM
    (SELECT
		e.emp_id AS IDEmpleado,
		MIN(ed.dept_id) AS IDDepartamento,
		(SELECT 
			emp_id
		FROM
			gerente_depto
		WHERE
			emp_id = 110854) AS IDGerente
	FROM
		empleados e 
			INNER JOIN
		empleados_depto ed ON e.emp_id = ed.emp_id
	WHERE 
		e.emp_id > 10010
	GROUP BY e.emp_id
	ORDER BY e.emp_id ASC
    LIMIT 10) AS GRUPOB 
    UNION SELECT
	GRUPOC.*
FROM
    (SELECT
		e.emp_id AS IDEmpleado,
		MIN(ed.dept_id) AS IDDepartamento,
		(SELECT 
			emp_id
		FROM
			gerente_depto
		WHERE
			emp_id = 110854) AS IDGerente
	FROM
		empleados e 
			INNER JOIN
		empleados_depto ed ON e.emp_id = ed.emp_id
	WHERE 
		e.emp_id = 110800
	GROUP BY e.emp_id) AS GRUPOC
    UNION SELECT
	GRUPOD.*
FROM
    (SELECT
		e.emp_id AS IDEmpleado,
		MIN(ed.dept_id) AS IDDepartamento,
		(SELECT 
			emp_id
		FROM
			gerente_depto
		WHERE
			emp_id = 110800 ) AS IDGerente
	FROM
		empleados e 
			INNER JOIN
		empleados_depto ed ON e.emp_id = ed.emp_id
	WHERE 
		e.emp_id = 110854
	GROUP BY e.emp_id) AS GRUPOD) as unionGrupos;
    
SELECT * FROM empleados_gerentes;