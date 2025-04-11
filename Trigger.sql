# Triggers -> Warnings y advertencias que se ejecutan autómaticamente
# SQL: Nivel de Fila
# SQL: Nivel de instrucciones | declaraciones
# MySQL: Nivel de Fila

# Quiero meter un registro de la tabla salarios y el campo salario fuera negativo -> 0

# No actualice en autómatico
SET AUTOCOMMIT = 0;

COMMIT;
DELIMITER //
CREATE TRIGGER verif_Salario
	BEFORE INSERT ON salarios
    FOR EACH ROW
    BEGIN
			IF NEW.salario < 0 
            THEN 
				SET NEW.salario = 0;
			END IF;
    END //
DELIMITER ;

SELECT * FROM salarios
WHERE emp_id=11000;

INSERT INTO salarios
VALUES (11000, -55927, '1997-01-23', '1998-01-27');