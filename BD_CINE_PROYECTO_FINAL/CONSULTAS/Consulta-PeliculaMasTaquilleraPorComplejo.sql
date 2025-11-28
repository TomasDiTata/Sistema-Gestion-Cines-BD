USE CineHoyts;

/*Pelicula mas taquillera en cada complejo*/

SELECT p.nombre, p.productora,
	SUM(e.precio) AS mas_taquillera,
    c.nombre AS Complejo,
    c.ciudad AS Ciudad
FROM peliculas p 
JOIN funciones f ON p.id_pelicula = f.id_pelicula
JOIN transacciones t ON f.id_funcion = t.id_funcion
JOIN entradas e ON t.id_transaccion = e.id_transaccion
JOIN salas s ON f.id_sala = s.id_sala
JOIN complejos c ON s.id_complejo = c.id_complejo
GROUP BY c.id_complejo , c.nombre;
