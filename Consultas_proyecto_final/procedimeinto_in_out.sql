# Procedimiento con salida para la obtención de pacientes que se encuentran en alguno
# de los BIRADS establecidos en la base de datos como entrada recibe
# la clasificación y como salida da el número de pacientes que se encuentran en esa
# categoría para el caso de calcificaciones
DROP PROCEDURE IF EXISTS BIRADS_P;
DELIMITER //
CREATE PROCEDURE BIRADS_P(IN birads_p VARCHAR(45), OUT count_pacientes_p INT)
BEGIN
	SELECT COUNT(p.Id_pacientes) INTO count_pacientes_p 
    FROM pacientes p
    INNER JOIN calcificacion c ON p.Id_pacientes = c.Id_pacientes
    WHERE c.BIRADS = birads_p;
END //
DELIMITER ;

# Verificación del procedimiento creado:
set @count_pacientes_p = 0;
call studybreast.BIRADS_P('5', @count_pacientes_p);
select @count_pacientes_p;

set @count_pacientes_p = 0;
call studybreast.BIRADS_P('3', @count_pacientes_p);
select @count_pacientes_p;