SELECT DISTINCT titulo FROM titulos;

SELECT COUNT(emp_ID) FROM empleados;
SELECT COUNT(DISTINCT apellido) AS Ap_totales
FROM empleados;

SELECT COUNT(DISTINCT dept_nombre) AS Num_depto
FROM departamentos;

SELECT dept_nombre FROM departamentos;

SELECT COUNT(DISTINCT emp_id) AS Num_depto # O con COUNT(*) también
FROM gerente_depto;

# Promedio del salario con AVG
SELECT AVG(salario) AS meanSalario
FROM salarios;

SELECT SUM(salario) AS TotalSalario
FROM salarios;

SELECT MAX(salario) AS MaxSalario
FROM salarios;

SELECT MIN(salario) AS MinSalario
FROM salarios;

SELECT MIN(salario), MAX(salario), AVG(salario) 
FROM salarios;

SELECT * FROM salarios ORDER BY salario ASC;