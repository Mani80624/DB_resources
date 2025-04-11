DROP PROCEDURE IF EXISTS salario_historico;

DELIMITER //
CREATE PROCEDURE  salario_historico(IN p_id_empleado INT)
BEGIN
	SELECT 
		e.nombre, e.apellido, s.fecha_inicio, s.fecha_fin
	FROM
    empleados e
    INNER JOIN salarios s ON e.emp_id = s.emp_id
    WHERE e.emp_id = p_id_empleado;
END //