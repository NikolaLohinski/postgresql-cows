SELECT
  operation.nameop AS "Operation name",
  SUM(dailyprod) AS "Daily production (l)"
FROM cow
NATURAL JOIN herd
NATURAL JOIN breeder
NATURAL JOIN operation
GROUP BY operation.idop
ORDER BY "Daily production (l)"

