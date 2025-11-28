USE CineHoyts;

/*Clientes con mas de 5 entradas compradas*/

SELECT c.id_cliente, c.nombre, c.apellido1, COUNT(e.id_entrada) AS total_entradas
FROM clientes c
JOIN entradas e ON c.id_cliente = e.id_cliente
GROUP BY c.id_cliente, c.nombre, c.apellido1
HAVING COUNT(e.id_entrada) > 5
ORDER BY total_entradas DESC;