# Self JOIN (Relaciones recursivas)

SELECT DISTINCT 
	eg1.*
FROM
	empleados_gerentes eg1
INNER JOIN
	empleados_gerentes eg2 ON eg1.emp_id = eg2.gerente_id;

use empleados;

# VISTAS son tablas visuales
SELECT emp_id, COUNT(emp_id) AS repetidos, fecha_inicio, fecha_fin 
FROM empleados_depto
GROUP BY emp_id
HAVING repetidos > 1;

SET GLOBAL sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY',''));

# Conocer el ID empleado, fecha inicio y fin de su último contrato
CREATE OR REPLACE VIEW v_ultimoContrato AS
SELECT
	emp_id,
    MAX(fecha_inicio) AS f_inicio,
    MAX(fecha_fin) AS f_fin
    FROM
    empleados_depto
    GROUP BY emp_id;

# Cree una vista que extraiga el salario promedio de todas empleadas 
# registradas en la base de datos. Redondee este valor al centavo más
# cercano (dos decimales).

CREATE OR REPLACE VIEW v_promedio_empleadas AS
SELECT
	e.genero, ROUND(AVG(s.salario),2) AS salario_promedio 
FROM
    empleados e
	INNER JOIN
    salarios s ON e.emp_id = s.emp_id
    WHERE genero = 'f';
    
# Rutinas almacenadas: Procedimientos  |  Funciones (incorporadas, definidas por el usuario)
# Delimitadores $$, //

# Seleccionar los pimeros 500 empleados de la base de datos
DROP PROCEDURE IF EXISTS sel550emp;
DELIMITER //
CREATE PROCEDURE sel550_emp()
BEGIN
	SELECT * 
    FROM empleados 
    LIMIT 550;
    END //
# Mandar a llamar el procedimeinto alamacenado
CALL empleados.sel550_emp();

# Actividad: Cree un procedimiento que calcule el salario promedio de los gerentes

# Procedimientos con parámetros de entrada
# Obtenga el salario promedio de cada empleado
DROP PROCEDURE IF EXISTS salario_promedio;
DELIMITER //
CREATE PROCEDURE salario_promedio(IN p_id_empleado INT)
BEGIN
	SELECT e.nombre, e.apellido, AVG(s.salario)
	FROM 
		empleados e
		INNER JOIN 
		salarios s ON e.emp_id = s.emp_id
        WHERE e.emp_id = p_id_empleado;
END // 

    

