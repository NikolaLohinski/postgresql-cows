ALTER TABLE cow
  ADD mammite BOOL;

--------------------------------------------------------------------------------
-- Set random mammite (common disease among cows) values for all cows
--------------------------------------------------------------------------------
UPDATE cow
SET mammite = RANDOM() < 0.3;

-- delete if exists
DROP FUNCTION IF EXISTS true_dailyprod( cowNumber CHAR(10) );

-- Function returning daily production with regard to mammite
CREATE OR REPLACE FUNCTION true_dailyprod(
  cowNumber CHAR(10)
)
  RETURNS INTEGER AS $true_dailyprod$
DECLARE
  mammite BOOLEAN;
BEGIN
  mammite := cow.mammite FROM cow WHERE (cow.idcow = cowNumber );
  IF mammite
  THEN
    RETURN 0;
  ELSE
    RETURN cow.dailyprod FROM cow WHERE (cow.idcow = cowNumber );
  END IF;
END;
$true_dailyprod$
LANGUAGE plpgsql;

-- To take into account the disease in previous request, we just need to replace
-- dailyprod by true_dailyprod(cow.idcow)
--------------------------------------------------------------------------------
-- Q5a
--------------------------------------------------------------------------------
SELECT
  SUM(cow.dailyprod)             AS "Total daily production",
  SUM(true_dailyprod(cow.idcow)) AS "True total daily production"
FROM cow;

--------------------------------------------------------------------------------
-- Q5b
--------------------------------------------------------------------------------
SELECT
  operation.nameop               AS "Operation",
  SUM(cow.dailyprod)             AS "Daily production",
  SUM(true_dailyprod(cow.idcow)) AS "True daily production"
FROM cow
  NATURAL JOIN herd
  NATURAL JOIN breeder
  NATURAL JOIN operation
GROUP BY "Operation"
ORDER BY "True daily production";

--------------------------------------------------------------------------------
-- Q5c
--------------------------------------------------------------------------------
SELECT
  operation.idop,
  operation.nameop          AS "Operation",
  cow.idcow                 AS "Cow id",
  cow.namecow               AS "Cow name",
  cow.dailyprod             AS "Daily production",
  true_dailyprod(cow.idcow) AS "True daily production"
FROM cow
  NATURAL JOIN herd
  NATURAL JOIN breeder
  NATURAL JOIN operation
GROUP BY operation.idop, cow.idcow
ORDER BY operation.idop, "Daily production" DESC;

--------------------------------------------------------------------------------
-- Q5d
--------------------------------------------------------------------------------
SELECT
  '040320'                    AS "Breeder id",
  race                        AS "Race",
  AVG(dailyprod)              AS "Average production",
  AVG(true_dailyprod(id))  AS "True average production"
FROM breeder_race('040320', 'Montbeliarde')
GROUP BY "Race";

--------------------------------------------------------------------------------
-- Q5e
--------------------------------------------------------------------------------
-- No change
