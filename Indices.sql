# Indices para consultas hacen más rápidas las consultas
# sin embargo no es muy rápida para insersión de datos
# 1 2 3 4 5 6 7 8 9 10

SELECT *
FROM
salarios
WHERE salario > 150000;

CREATE INDEX i_salarios ON salarios(salario);

# Crear indices compuestos
SELECT 
    *
FROM
    empleados
WHERE
    nombre = 'kyoichi'
	AND apellido = 'Maliniak';
    
# Actividad: Seleccione a todas las mujeres de la tabla empleados cuyo apellido sea Alpin. 
# Luego, cree un índice en las columnas apellido y genero de esa tabla y verifique si ha
# acelerado la búsqueda de la misma declaración de selección.
    
# Indice compuesto
CREATE INDEX i_Nom_Apell ON empleados(nombre, apellido);

# Borrar los indices
DROP INDEX i_Nom_apell ON empleados;