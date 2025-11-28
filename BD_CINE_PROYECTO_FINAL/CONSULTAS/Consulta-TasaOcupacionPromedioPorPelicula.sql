USE CineHoyts;

/*Tasa de ocupacion promedio por pelicula*/
/*COALESCE trabaja en la ocasion de que una pelicula no tenga transacciones, se devuelve null, lo que equivale a 0*/
SELECT 
  p.id_pelicula,
  p.nombre AS pelicula,
  ROUND( AVG( (COALESCE(t.ocupados,0) / s.capacidad) * 100 ), 2) AS ocupacion_promedio_pct,
  COUNT(f.id_funcion) AS cantidad_funciones
FROM peliculas p
JOIN funciones f ON p.id_pelicula = f.id_pelicula
JOIN salas s ON f.id_sala = s.id_sala
LEFT JOIN (
    SELECT id_funcion, SUM(CASE WHEN estado = 'Ocupado' THEN 1 ELSE 0 END) AS ocupados
    FROM transacciones
    GROUP BY id_funcion
) t ON f.id_funcion = t.id_funcion
GROUP BY p.id_pelicula, p.nombre
ORDER BY ocupacion_promedio_pct ASC;

