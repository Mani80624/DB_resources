SELECT * FROM empleados
ORDER BY nombre, apellido DESC; #ASC, DESC

# Selecciona el nombre y Cuantas veces se repiten los nombres, 
# donde el genero es femenino las ordena de forma ascendente 
# al numero de veces que aparece el nombre
SELECT nombre, COUNT(nombre) 
FROM empleados
WHERE genero='F'
GROUP BY nombre 
ORDER BY COUNT(nombre); 

# WHERE - GROUP BY - HAVING - ORDER BY, esa es la estructura en una consulta

SELECT f_contra, COUNT(f_contra) AS Num_Empleados 
FROM empleados 
WHERE f_contra LIKE('1999%')
GROUP BY f_contra
HAVING Num_Empleados > 10
ORDER BY Num_Empleados; 