# Actividad: Seleccione el nombre, apellido, titulo de su cargo, nombre del departamento y 
# la fecha de inicio en que fueron asignados gerentes de su respectivo departamento 
# para todos los gerentes con el titulo de "Senior Engineer."
SELECT t.titulo, e.nombre, e.apellido, g.fecha_inicio, d.dept_nombre
FROM titulos t
INNER JOIN empleados e ON t.emp_id = e.emp_id
INNER JOIN gerente_depto g ON e.emp_id = g.emp_id
INNER JOIN departamentos d ON g.dept_id = d.dept_id
WHERE t.titulo = 'Senior Engineer';

# actividad: Genere una lista con información del id de empleado, salario y titulo.
SELECT t.titulo, e.emp_id, s.salario
FROM titulos t
INNER JOIN empleados e ON t.emp_id = e.emp_id
INNER JOIN salarios s ON e.emp_id = s.emp_id
ORDER BY s.salario DESC;

# actividad: el salario promedio por género?
SELECT e.genero, ROUND(AVG(s.salario), 2) AS SalarioPromedio
FROM empleados e
INNER JOIN salarios s ON e.emp_id = s.emp_id
GROUP BY e.genero;

# actividad: Una las tablas empleados y gerentes de departamento, seleccionando 
# la fecha de contratación, nombre, apellido (tabla empleados) y el ID de departamento 
# (tabla gerentes) para el ID de empleado 10010
SELECT e.f_contra, e.nombre, e.apellido, NULL AS dept_id
FROM empleados e 
WHERE e.emp_id=10010
UNION SELECT NULL AS f_contra, NULL AS nombre, NULL AS apellido, g.dept_id
FROM gerente_depto g;

# Actividad para el jueves agregar a la consulta: 
# nombre de empleado, nombre del departamento, gerente a cargo del empleado


