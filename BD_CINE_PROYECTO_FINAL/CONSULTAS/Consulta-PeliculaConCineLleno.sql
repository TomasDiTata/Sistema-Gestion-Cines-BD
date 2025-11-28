USE CineHoyts;

/*Peliculas que llenaron sus salas*/

SELECT p.nombre AS pelicula, 
	f.fecha_hora AS fecha_funcion,
    c.nombre AS Nombre_complejo,
    s.capacidad AS Capacidad_sala,
    s.id_sala AS codigo_sala
FROM funciones f
JOIN peliculas p ON f.id_pelicula = p.id_pelicula
JOIN salas s ON f.id_sala = s.id_sala
JOIN complejos c ON s.id_complejo = c.id_complejo
JOIN transacciones t ON f.id_funcion = t.id_funcion
JOIN entradas e ON t.id_transaccion = e.id_transaccion
GROUP BY p.nombre, f.fecha_hora, c.nombre, s.capacidad
HAVING COUNT(e.id_entrada) = (s.capacidad)
ORDER BY f.fecha_hora;
