USE CineHoyts;

/*Peliculas proyectadas en el Abasto (para el complejo que elija el usuario)*/

SELECT p.nombre AS Pelicula,
		p.duracion AS Duracion,
		f.fecha_hora,
        f.idioma,
        f.formato
FROM funciones f 
JOIN peliculas p ON f.id_pelicula = p.id_pelicula
JOIN salas s ON f.id_sala = s.id_sala
JOIN complejos c ON s.id_complejo = c.id_complejo
WHERE c.nombre = ('CineHoyts Abasto');