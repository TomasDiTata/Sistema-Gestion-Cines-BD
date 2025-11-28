USE CineHoyts;

/*Cuantas entradas vendio cada cine*/

SELECT c.nombre AS complejo,
       COUNT(e.id_entrada) AS total_entradas
FROM entradas e
JOIN transacciones t ON e.id_transaccion = t.id_transaccion
JOIN funciones f ON t.id_funcion = f.id_funcion
JOIN salas s ON f.id_sala = s.id_sala
JOIN complejos c ON s.id_complejo = c.id_complejo
GROUP BY c.nombre
ORDER BY total_entradas DESC;
