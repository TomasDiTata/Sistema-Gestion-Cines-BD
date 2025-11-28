USE CineHoyts;

/*Total recaudado entre Junio y Agosto de 2024*/

SELECT '2024' AS año, '06-07-08' AS meses,
       SUM(precio) AS total_recaudado
FROM entradas
WHERE fecha_compra BETWEEN '2024-06-01' AND '2024-08-31'
ORDER BY año, meses;


