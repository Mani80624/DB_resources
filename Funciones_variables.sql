# Variables locales (Están dentro de los procedimientos | bloque Begin - end)
# Variables de sesión (son visibles en cualquier terminal de una sesión)
# Variables globales a nivel de base de datos

# Variable global
#SET @@ GLOBAL G_varible;
# Pruebas

DROP FUNCTION IF EXISTS f_SalProm;

DELIMITER //
CREATE FUNCTION f_SalProm(p_id_empleado INT) RETURNS DECIMAL(8,2)
BEGIN
	DECLARE v_salario_prom DECIMAL(8,2); # Q1
    # La función DECLARE solo declara variables locales
    SELECT
		AVG(s.salario) 
	INTO v_salario_prom # lo que se haya obtenido en la consulta que lo coloque en la variable v_salario_prom
    FROM empleados e
    INNER JOIN
    salarios ON e.emp_id = s.emp_id
    WHERE e.emp_id = p_id_empleado;
    RETURN v_salario_prom;
END //

