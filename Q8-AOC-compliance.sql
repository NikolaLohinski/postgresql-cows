-------------------------------------------------------------------------------
-- First, let us note that adding an AOC constraint (same race cows in a herd)
-- after populating the database may lead to a incoherent state. We then need
-- to build a tolerant behaviour with regard to that state, in order be able to
-- improve it but not make it worse. With that being said, we decided to go with
-- a solution that does not modify the schemas, and only changes the triggers by
-- determining during an INSERT or UPDATE which race is the most represented. We
-- then only need to check if the new cow is of the same race, and if not, abort
-- the insert/update.
-------------------------------------------------------------------------------

-- Deletion
DROP FUNCTION IF EXISTS get_max_races_from_pre(VARCHAR(32)) CASCADE;

-- Function returning the most represented race in herd
CREATE OR REPLACE FUNCTION get_max_races_from_meadow(namemeadow VARCHAR(32))
	RETURNS TABLE(
    maxrace VARCHAR(16)
  ) AS $get_max_races_from_meadow$
  DECLARE
    max_cow_nb INTEGER;
	BEGIN
    max_cow_nb := _.M FROM (
                        SELECT max(__.count) AS M
                        FROM (
                          SELECT cow.race, COUNT (cow.race)
                          FROM cow
                          WHERE cow.meadow = namemeadow
                          GROUP BY cow.race
                        ) AS __
                      ) AS _;
		RETURN QUERY(
            SELECT _.race as maxrace
            FROM (
                SELECT cow.race, count(cow.race)
                FROM cow
                WHERE cow.meadow = namemeadow
                GROUP BY cow.race
            ) as _
            WHERE _.count = max_cow_nb
           );
	END;
$get_max_races_from_meadow$ LANGUAGE plpgsql;

--------------------------------------------------------------------------------

-- Deletion
DROP TRIGGER IF EXISTS AOC_checker ON cow;
DROP FUNCTION IF EXISTS check_on_cow() CASCADE;

-- Function to check if a cow is from the same race of the herd it is added to
CREATE OR REPLACE FUNCTION check_on_cow()
	RETURNS TRIGGER AS $check_on_cow$
	DECLARE
	  nb_races INTEGER;
    race_herd VARCHAR(16);
  BEGIN
    nb_races := _.nb FROM (
                       SELECT count(__.maxrace) as nb
                       FROM get_max_races_from_meadow(NEW.meadow) as __
                     ) as _;
    IF nb_races = 1
    THEN
      race_herd := _.maxrace FROM get_max_races_from_meadow(NEW.meadow) as _;
      IF race_herd != NEW.race
      THEN
        RAISE EXCEPTION 'Cows race (%) does not match the race of the herd (%).',
          NEW.race, race_herd;
      END IF;
    END IF;
    RETURN NEW;
	END;
$check_on_cow$ LANGUAGE plpgsql;

-- Trigger déclenché à chaque modification de vache vérifiant si la modification
-- respecte l'AOC (dans la mesure du possible au vu des remarques précédentes).
CREATE TRIGGER AOC_checker
BEFORE INSERT OR UPDATE ON cow
FOR EACH ROW
	EXECUTE PROCEDURE check_on_cow();

--------------------------------------------------------------------------------
-- TESTS
--------------------------------------------------------------------------------

-- Test of race determination function
SELECT * FROM get_max_races_from_meadow('FI');
SELECT * FROM get_max_races_from_meadow('LREM');
SELECT * FROM get_max_races_from_meadow('FN');

-- Test of successful insert
INSERT INTO cow VALUES
('2711197000', 'Edouarde', 'Montbeliarde', 5, 25, 'LREM');
-- Check of herd's race value after insert
SELECT * FROM get_max_races_from_meadow('LREM');

-- Test of failed insert after the successful one
INSERT INTO cow VALUES
('13081962', 'Manuella', 'Prim Hollstein', 4, 20, 'LREM');

-- Test of failed insert
UPDATE cow SET meadow = 'FN' WHERE namecow = 'Dupone';
