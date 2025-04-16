# Tarea 03-04-2025
# Usando la tabla empleados_depto, seleccione los id de empleados de todos los colaboradores 
# que hayan firmado más de 1 contrato después del 31 de Diciembre de 1995.
SELECT emp_id, COUNT(fecha_inicio) AS num_contra FROM empleados_depto
WHERE fecha_inicio > '1995-12-31'
GROUP BY emp_id
HAVING num_contra > 1
ORDER BY num_contra DESC;