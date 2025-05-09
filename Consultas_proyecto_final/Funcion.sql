# Crear una función el cual sea capaz de devolver 
# La patología de cierto paciente en base a su Id
DROP FUNCTION IF EXISTS patologia_f;
DELIMITER //
CREATE FUNCTION patologia_f(p_Id_Paciente VARCHAR(45)) RETURNS VARCHAR(45)
BEGIN
	DECLARE v_patologia VARCHAR(45);
    SELECT DISTINCT pathology INTO v_patologia FROM masa
    WHERE Id_pacientes = p_Id_Paciente;
    RETURN v_patologia;
END //
DELIMITER ;

# Verificación de la consulta con la función
select studybreast.patologia_f('P_00001');
select studybreast.patologia_f('P_00004');


