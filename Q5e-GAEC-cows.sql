-- Drop if view exists
DROP VIEW IF EXISTS gaec;

-- view of 'GAEC' operation cows
CREATE OR REPLACE VIEW gaec AS
  (SELECT
     operation.idop,
     operation.nameop,
     cow.idcow,
     cow.lactrank
   FROM cow
     NATURAL JOIN herd
     NATURAL JOIN breeder
     NATURAL JOIN operation
   WHERE operation.typeop = 'GAEC');

-- Drop if function exists
DROP FUNCTION IF EXISTS nbr_rank( INTEGER, INTEGER );

-- Number of cows from a 'GAEC' operation and number of cows of a laction rank 5
CREATE OR REPLACE FUNCTION nbr_rank(nu INTEGER, rank INTEGER)
  RETURNS CHAR(2) AS $nbr_rank$
DECLARE
  nbr INTEGER;
BEGIN
  nbr := (SELECT COUNT(cow.idcow)
          FROM cow
            NATURAL JOIN herd
            NATURAL JOIN breeder
            NATURAL JOIN operation
          WHERE (operation.idop = nu) AND (cow.lactrank = rank));
  IF (nbr > 0)
  THEN
    RETURN CAST(nbr AS CHAR(2));
  ELSE
    RETURN NULL;
  END IF;
END;
$nbr_rank$
LANGUAGE plpgsql;

-- Test
SELECT
  gaec.nameop           AS   "Operation",
  COUNT(gaec.idop) AS   "total # of cows",
  nbr_rank(gaec.idop, 5) "lactation 5 rank cows"
FROM gaec
GROUP BY gaec.idop, gaec.nameop;