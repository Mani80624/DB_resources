DROP PROCEDURE IF EXISTS salario_promedio_salida;

DELIMITER //
CREATE PROCEDURE  salario_promedio_salida(IN p_id_empleado INT, OUT p_salarioPromSalida DECIMAL)
BEGIN
	SELECT 
		AVG(p_salarioPromSalida)
	FROM
    empleados e
    INNER JOIN salarios s ON e.emp_id = s.emp_id
    WHERE e.emp_id = p_id_empleado;
END //