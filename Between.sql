SELECT * FROM empleados WHERE nombre NOT LIKE ('%eb%') AND genero ='F'; #Mar_
SELECT * FROM empleados WHERE f_contra LIKE ('1990-04%');
	
SELECT * FROM empleados WHERE f_contra BETWEEN '1990-01-01' AND '1990-06-30';
SELECT salario FROM salarios WHERE salario BETWEEN 75000 AND 76000;

SELECT * FROM empleados WHERE nombre IS NOT NULL;
SELECT * FROM empleados WHERE apellido <> 'perez';# Equivalente != con <>
SELECT * FROM empleados WHERE apellido > 'perez'; # Todos los registros que tengan la letra mayor a p
SELECT * FROM empleados WHERE f_contra >= '2000-01-01';
SELECT * FROM empleados WHERE f_contra < '2000-01-01' AND genero = 'F';