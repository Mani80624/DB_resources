# Verificar si los nuevos registros de pathology son BENIGN_WITHOUT_CALLBACK
# en caso de que así sea cambiar a BENIGN
SET AUTOCOMMIT = 0;

COMMIT;
DROP TRIGGER IF EXISTS verif_pathology;
DELIMITER //
CREATE TRIGGER verif_pathology
	BEFORE INSERT ON calcificacion
    FOR EACH ROW
    BEGIN
			IF NEW.Pathology = 'BENIGN_WITHOUT_CALLBACK' 
            THEN 
				SET NEW.Pathology = 'BENIGN';
			END IF;
    END //
DELIMITER ;

# Verificación del trigger
INSERT INTO calcificacion(Abnormality_type, Calc_type, Calc_distribution, BIRADS, Pathology, Subtlety, Id_pacientes)
VALUES ('calcification', 'VASCULAR', 'CLUSTERED', '2', 'BENIGN_WITHOUT_CALLBACK', 5, 'P_00038');
SELECT * FROM calcificacion WHERE Id_pacientes = 'P_00038';
