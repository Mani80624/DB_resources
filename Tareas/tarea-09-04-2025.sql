# Actividad: Seleccione el nombre, apellido, titulo de su cargo, nombre del departamento y 
# la fecha de inicio en que fueron asignados gerentes de su respectivo departamento 
# para todos los gerentes con el titulo de "Senior Engineer."
SELECT t.titulo, e.nombre, e.apellido, g.fecha_inicio, d.dept_nombre
FROM titulos t
INNER JOIN empleados e ON t.emp_id = e.emp_id
INNER JOIN gerente_depto g ON e.emp_id = g.emp_id
INNER JOIN departamentos d ON g.dept_id = d.dept_id
WHERE t.titulo = 'Senior Engineer';

# actividad: Genere una lista con información del id de empleado, salario y titulo.
SELECT t.titulo, e.emp_id, s.salario
FROM titulos t
INNER JOIN empleados e ON t.emp_id = e.emp_id
INNER JOIN salarios s ON e.emp_id = s.emp_id
ORDER BY s.salario DESC;

# actividad: el salario promedio por género?
SELECT e.genero, ROUND(AVG(s.salario), 2) AS SalarioPromedio
FROM empleados e
INNER JOIN salarios s ON e.emp_id = s.emp_id
GROUP BY e.genero;

# actividad: Una las tablas empleados y gerentes de departamento, seleccionando 
# la fecha de contratación, nombre, apellido (tabla empleados) y el ID de departamento 
# (tabla gerentes) para el ID de empleado 10010
SELECT e.f_contra, e.nombre, e.apellido, NULL AS dept_id
FROM empleados e 
WHERE e.emp_id=10010
UNION SELECT NULL AS f_contra, NULL AS nombre, NULL AS apellido, g.dept_id
FROM gerente_depto g;

# Actividad para el jueves agregar a la consulta: 
# nombre de empleado, nombre del departamento, gerente a cargo del empleado
CREATE TABLE Empleados_gerentes (
    emp_id INT NOT NULL,
    nombre_empleado VARCHAR(255) NOT NULL,
    dept_id CHAR(5) NOT NULL,
    nombre_departamento VARCHAR(255) NOT NULL,
    gerente_id INT NOT NULL,
    nombre_gerente VARCHAR(255) NOT NULL
);

DROP TABLE Empleados_gerentes;

INSERT INTO empleados_gerentes
SELECT 
	unionGrupos.*
    FROM 
    (SELECT
		GRUPOA.*
		FROM
			(SELECT
				e.emp_id AS IDEmpleado,
                e.nombre AS nombre_empleado,
				MIN(ed.dept_id) AS IDDepartamento,
                d.dept_nombre AS nombre_departamento,
				(SELECT 
					emp_id
					FROM
					gerente_depto
					WHERE
					emp_id = 110800) AS IDGerente,
				(SELECT 
					nombre
					FROM
					empleados
					WHERE
					emp_id = 110800) AS nombre_gerente
			FROM
				empleados e 
				INNER JOIN
				empleados_depto ed ON e.emp_id = ed.emp_id
                INNER JOIN 
                departamentos d ON ed.dept_id = d.dept_id
				WHERE 
				e.emp_id <= 10010
				GROUP BY e.emp_id
				ORDER BY e.emp_id ASC) AS GRUPOA
		UNION SELECT
			GRUPOB.*
			FROM
				(SELECT
					e.emp_id AS IDEmpleado,
                    e.nombre AS nombre_empleado,
					MIN(ed.dept_id) AS IDDepartamento,
                    d.dept_nombre AS nombre_departamento,
					(SELECT 
					emp_id
					FROM
					gerente_depto
					WHERE
					emp_id = 110854) AS IDGerente,
                    (SELECT 
					nombre
					FROM
					empleados
					WHERE
					emp_id = 110854) AS nombre_gerente
	FROM
		empleados e 
			INNER JOIN
		empleados_depto ed ON e.emp_id = ed.emp_id
			INNER JOIN 
		departamentos d ON ed.dept_id = d.dept_id
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
        e.nombre AS nombre_empleado,
		MIN(ed.dept_id) AS IDDepartamento,
		d.dept_nombre AS nombre_departamento,
		(SELECT 
			emp_id
		FROM
			gerente_depto
		WHERE
			emp_id = 110854) AS IDGerente,
		(SELECT 
			nombre
		FROM
			empleados
		WHERE
			emp_id = 110854) AS nombre_gerente
	FROM
		empleados e 
			INNER JOIN
		empleados_depto ed ON e.emp_id = ed.emp_id
			INNER JOIN 
		departamentos d ON ed.dept_id = d.dept_id
	WHERE 
		e.emp_id = 110800
	GROUP BY e.emp_id) AS GRUPOC
    UNION SELECT
	GRUPOD.*
FROM
    (SELECT
		e.emp_id AS IDEmpleado,
        e.nombre AS nombre_empleado,
		MIN(ed.dept_id) AS IDDepartamento,
        d.dept_nombre AS nombre_departamento,
		(SELECT 
			emp_id
		FROM
			gerente_depto
		WHERE
			emp_id = 110800 ) AS IDGerente,
		(SELECT 
			nombre
		FROM
			empleados
		WHERE
			emp_id = 110800) AS nombre_gerente
	FROM
		empleados e 
			INNER JOIN
		empleados_depto ed ON e.emp_id = ed.emp_id
			INNER JOIN 
		departamentos d ON ed.dept_id = d.dept_id
	WHERE 
		e.emp_id = 110854
	GROUP BY e.emp_id) AS GRUPOD) as unionGrupos;
    
SELECT * FROM empleados_gerentes;

#SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));