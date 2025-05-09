################# Procedimiento ##############################
# Procedimiento para la obtención de el BIRADS, patología, la ruta 
# de la imagen a partir del Id de cada paciente.

DROP PROCEDURE IF EXISTS imageP;
DELIMITER //
CREATE PROCEDURE imageP(IN p_id_paciente VARCHAR(45))
BEGIN
SELECT DISTINCT c.BIRADS, c.Pathology, i.Image_file_path
FROM Calcificacion c
INNER JOIN Imagen i ON c.Id_pacientes = i.Id_pacientes
WHERE i.Id_pacientes = p_id_paciente;
END //
DELIMITER ;

# Verificamos el procedimiento
CALL studybreast.imageP('P_00038');
CALL studybreast.imageP('P_00008');