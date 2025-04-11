# Funciones
DROP FUNCTION IF EXISTS f_salario_promedio;

DELIMITER //
CREATE FUNCTION  f_salario_promedio(p_id_empleado INT) RETURNS DECIMAL(10,2)
BEGIN
	DECLARE v_salarioProm DECIMAL (10,2); # q1
	SELECT 
		AVG(s.salario)
        INTO v_salarioProm
	FROM
		empleados e
		INNER JOIN 
        salarios s ON e.emp_id = s.emp_id
		WHERE e.emp_id = p_id_empleado; # q2
    RETURN v_salarioProm; # q3
END //

# Actividad: Cree una función llamada 'salario_actual' 
# que tome como parámetros el nombre y apellido de un empleado 
# y devuelva el salario del contrato más nuevo de ese empleado.
SET GLOBAL log_bin_trust_function_creators=1;

# Diferencias técnicas
# FUnciones
 # * return
 # * select
 # * Regresan un valor
 
 # Procedure
 # * Hay parametrso de salida pero no hay retunr
 # * call
 # * Pueden tener muchas variables de salida