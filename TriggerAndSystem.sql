# Fecha del sistema
SELECT SYSDATE();
SELECT DATE_FORMAT(SYSDATE(), '%Y-%M-%D') AS fecha;
# ACTIVIDAD: Cree un activador (trigger) que verifique si la fecha de contratación de un 
# empleado (f_contra) es mayor que la fecha actual (sysdate). Si se cumple dicha condición, 
# establezca la fecha de contratación como la fecha actual. 
# Formatear la salida adecuadamente (yy-mm-dd). 

# Luego, para comprobar si funciona su activador, genere un nuevo registro 
# de empleado que contenga una fecha de contratación futura.

# Sugerencia: Genere un registro con id 999999 (DELETE si ya existe) y sus datos. 
# Luego seleccione todos los registros de la tabla empleados, 
# ordenándolos por emp_id de forma descendente.