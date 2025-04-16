# Tareas 10-04-25
# Actividad: Cree un procedimiento que calcule el salario promedio de los gerentes
DELIMITER //
DROP PROCEDURE IF EXISTS salario_promedio;

CREATE PROCEDURE  salario_promedio()
BEGIN
	SELECT 
		ROUND(AVG(s.salario), 2)
	FROM
    empleados e
    INNER JOIN salarios s ON e.emp_id = s.emp_id
    INNER JOIN gerente_depto g ON e.emp_id = g.emp_id;
END //
DELIMITER ;


# Actividad: Cree una función llamada 'salario_actual' 
# que tome como parámetros el nombre y apellido de un empleado 
# y devuelva el salario del contrato más nuevo de ese empleado. 

DROP FUNCTION IF EXISTS salario_actual ;

DELIMITER //

CREATE FUNCTION salario_actual(f_nombre VARCHAR(255), f_apellido VARCHAR(255)) RETURNS DECIMAL(10,2)
BEGIN
	DECLARE sal_max DECIMAL(10,2);
    SELECT s.salario
    INTO sal_max
    FROM salarios s
    INNER JOIN empleados e ON s.emp_id = e.emp_id
    WHERE f_nombre = e.nombre AND f_apellido = e.apellido 
    ORDER BY fecha_inicio DESC
    LIMIT 1;
    RETURN sal_max;
END //
DELIMITER ;
#SET GLOBAL log_bin_trust_function_creators = 1;}
SELECT nombre, apellido FROM empleados;