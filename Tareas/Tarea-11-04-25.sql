# Tareas 11-04-25

# Actividad: Seleccione a todas las mujeres de la tabla empleados cuyo apellido sea Alpin. 
# Luego, cree un índice en las columnas apellido y genero de esa tabla y verifique si ha
# acelerado la búsqueda de la misma declaración de selección.
SELECT * FROM empleados WHERE genero='F' AND apellido = 'Alpin';
CREATE INDEX i_fem_apellido ON empleados(apellido, genero);


# ACTIVIDAD: Cree un activador (trigger) que verifique si la fecha de contratación de un 
# empleado (f_contra) es mayor que la fecha actual (sysdate). Si se cumple dicha condición, 
# establezca la fecha de contratación como la fecha actual. 
# Formatear la salida adecuadamente (yy-mm-dd). 

# Luego, para comprobar si funciona su activador, genere un nuevo registro 
# de empleado que contenga una fecha de contratación futura.

# Sugerencia: Genere un registro con id 999999 (DELETE si ya existe) y sus datos. 
# Luego seleccione todos los registros de la tabla empleados, 
# ordenándolos por emp_id de forma descendente.

SET AUTOCOMMIT = 0;

DROP TRIGGER IF EXISTS verif_fecha;
COMMIT;
DELIMITER //
CREATE TRIGGER verif_fecha
	BEFORE INSERT ON empleados
    FOR EACH ROW 
    BEGIN
		IF NEW.f_contra < CURDATE()
			THEN
				SET NEW.f_contra = CURDATE();
		END IF;
END //

DELIMITER ;

INSERT INTO empleados VALUES(500001, '1971-02-15', 'Imelda', 'Dolores', 'M', '1998-02-14');
SELECT f_contra FROM empleados WHERE emp_id = 500001;