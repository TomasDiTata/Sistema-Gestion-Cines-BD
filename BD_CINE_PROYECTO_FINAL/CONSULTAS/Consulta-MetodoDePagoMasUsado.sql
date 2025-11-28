USE CineHoyts;

/* Metodo de pago mas usado por los clientes. */

SELECT forma_pago, COUNT(*) as cantidad_usos
FROM entradas
GROUP BY forma_pago
ORDER BY cantidad_usos DESC
LIMIT 1;