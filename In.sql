SELECT  * FROM empleados
WHERE nombre='Danil' OR nombre = 'Adil' OR nombre = 'Chrisa';
# Consulta igual a la anterior
SELECT  * FROM empleados
WHERE nombre IN ('Danil', 'Adil', 'Chrisa');

SELECT  * FROM empleados
WHERE nombre IN ('Danil', 'Adil', 'Chrisa') AND genero='M';