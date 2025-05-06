# Se crea la base de datos donde se aplicara las formas normales
CREATE DATABASE studybreast;
USE studybreast;

# Borramos la tabla de pacientes en caso de que exista
DROP TABLE IF EXISTS pacientes;
# Creamos la tabla de pacientes que almacena el id del paciente
CREATE TABLE pacientes (
	Id_pacientes VARCHAR(45) NOT NULL UNIQUE,
    PRIMARY KEY(Id_pacientes)
);

# Insertamos los ids sin repeticiones de los pacientes de las tablas individuales
# calc_test, calc_train, mass_test, mass_train
INSERT INTO pacientes
SELECT patient_id FROM calc_test 
UNION SELECT patient_id FROM calc_train 
UNION SELECT patient_id FROM mass_test 
UNION SELECT patient_id FROM mass_train;

SELECT * FROM pacientes WHERE Id_pacientes = 'P_00038';

# Eliminamos la tabla de mama encaso de que exista
DROP TABLE IF EXISTS mama;
# Creamos la tabla de mama que almacena el Id_mama, Breast_density, Side_breast,
 # Id_paciente como clave foránea
CREATE TABLE mama(
	Id_mama INT AUTO_INCREMENT NOT NULL,
    Breast_density INT NOT NULL,
    Side_breast VARCHAR(45) NOT NULL,
    Id_pacientes VARCHAR(45) NOT NULL,
    PRIMARY KEY(Id_mama),
    FOREIGN KEY (Id_pacientes) REFERENCES pacientes(Id_pacientes)
);

# Insertamos los valores de las cuatro tablas aceptando elementos repetidos del Id_pacientes
INSERT INTO mama(Breast_density,Side_breast,Id_pacientes)
SELECT `breast density`, `left or right breast`, patient_id FROM calc_test
UNION ALL SELECT `breast density`, `left or right breast`, patient_id FROM calc_train
UNION ALL SELECT `breast_density`, `left or right breast`, patient_id FROM mass_test
UNION ALL SELECT `breast_density`, `left or right breast`, patient_id FROM mass_train;
# Verificamos que la tabla este alamacenando de forma correcta
SELECT * FROM mama;


DROP TABLE IF EXISTS imagen;
CREATE TABLE imagen (
	Id_imagen INT AUTO_INCREMENT NOT NULL,
    Image_view VARCHAR(255) NOT NULL,
    Image_file_path VARCHAR(255) NOT NULL,
    Cropped_image_file_path VARCHAR(255) NOT NULL,
    ROI_mask_file_path VARCHAR(255) NOT NULL,
    Id_pacientes VARCHAR(45) NOT NULL,
    PRIMARY KEY (Id_imagen),
    FOREIGN KEY (Id_pacientes) REFERENCES pacientes(Id_pacientes)
);

SELECT * FROM imagen;
INSERT INTO imagen(Image_view, Image_file_path, Cropped_image_file_path, ROI_mask_file_path, Id_pacientes)
SELECT `image view`, `image file path`, `cropped image file path`, `ROI mask file path`, `patient_id` FROM calc_test
UNION ALL SELECT `image view`, `image file path`, `cropped image file path`, `ROI mask file path`, `patient_id` FROM calc_train
UNION ALL SELECT `image view`, `image file path`, `cropped image file path`, `ROI mask file path`, `patient_id` FROM mass_test
UNION ALL SELECT `image view`, `image file path`, `cropped image file path`, `ROI mask file path`, `patient_id` FROM mass_train;

DROP TABLE IF EXISTS Masa;
CREATE TABLE Masa(
	Id_masa INT AUTO_INCREMENT NOT NULL,
	Abnormality_type VARCHAR(45) NOT NULL,
    Mass_shape VARCHAR(45),
    Mass_Margins VARCHAR(45),
    BIRADS VARCHAR(10) NOT NULL,
    Pathology VARCHAR(45) NOT NULL,
    Subtlety INT NOT NULL,
    Id_pacientes VARCHAR (45) NOT NULL,
    PRIMARY KEY(Id_Masa),
    FOREIGN KEY (Id_pacientes) REFERENCES pacientes(Id_pacientes)
);


INSERT INTO Masa(Abnormality_type, Mass_shape, Mass_Margins, BIRADS, Pathology, Subtlety, Id_pacientes)
SELECT `Abnormality type`, `mass shape`, `mass margins`, `assessment`, `pathology`, `subtlety`, `patient_id` FROM mass_test
UNION SELECT `Abnormality type`, `mass shape`, `mass margins`, `assessment`, `pathology`, `subtlety`, `patient_id` FROM mass_train;
SELECT * FROM Masa;

DROP TABLE IF EXISTS Calcificacion;
CREATE TABLE Calcificacion(
	Id_calcificacion INT NOT NULL AUTO_INCREMENT,
    Abnormality_type VARCHAR(45) NOT NULL,
    Calc_type VARCHAR(255),
    Calc_distribution VARCHAR(45),
    BIRADS VARCHAR(10) NOT NULL,
    Pathology VARCHAR(45),
    Subtlety INT,
    Id_pacientes VARCHAR(45) NOT NULL,
    PRIMARY KEY(Id_calcificacion),
    FOREIGN KEY (Id_pacientes) REFERENCES pacientes(Id_pacientes)
);
INSERT INTO Calcificacion(Abnormality_type, Calc_type, Calc_distribution, BIRADS, Pathology, Subtlety, Id_pacientes)
SELECT `Abnormality type`, `calc type`, `calc distribution`, `assessment`, `pathology`, `subtlety`, `patient_id` FROM calc_test
UNION SELECT `Abnormality type`, `calc type`, `calc distribution`, `assessment`, `pathology`, `subtlety`, `patient_id` FROM calc_train;

SELECT * FROM Calcificacion;

#################################### Consultas ##############################################

# Pacientes con diferentes tipos de BIRADS en calcificaciones
SELECT c.BIRADS, COUNT(p.id_pacientes) AS numero_pacientes FROM pacientes p
INNER JOIN Calcificacion c ON p.Id_pacientes = c.Id_pacientes
GROUP BY BIRADS;

# Pacientes con diferentes tipos de BIRADS en Masa
SELECT m.BIRADS, COUNT(p.id_pacientes) AS numero_pacientes FROM pacientes p
INNER JOIN Masa m ON p.Id_pacientes = m.Id_pacientes
GROUP BY BIRADS;

# Pacientes con BIRADS 3 Maligno y benigno en calcificaciones
SELECT COUNT(p.Id_pacientes), c.Pathology FROM pacientes p
INNER JOIN Calcificacion c ON p.Id_pacientes = c.Id_pacientes
WHERE BIRADS = 3
GROUP BY Pathology;

# Pacientes con BIRADS 3 Maligno y benigno en calcificaciones
SELECT COUNT(p.Id_pacientes)AS numero_pacientes, m.Pathology FROM pacientes p
INNER JOIN Masa m ON p.Id_pacientes = m.Id_pacientes
WHERE BIRADS = 3
GROUP BY Pathology;

# Obtener direcciones de las imagenes de BIRADS 3 para calcificaciones
SELECT i.Image_file_path FROM Imagen i
INNER JOIN Pacientes p ON i.Id_pacientes = p.Id_pacientes
INNER JOIN calcificacion c ON i.Id_pacientes = c.Id_pacientes
WHERE BIRADS = 3;

# Obtener direcciones de las imagenes de BIRADS 3 para masas
SELECT i.Image_file_path FROM Imagen i
INNER JOIN Pacientes p ON i.Id_pacientes = p.Id_pacientes
INNER JOIN masa m ON i.Id_pacientes = m.Id_pacientes
WHERE BIRADS = 3;
