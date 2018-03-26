--------------------------------------------------------------------------------
-- Q7)
--------------------------------------------------------------------------------
-- Deletion
DROP FUNCTION IF EXISTS is_exploitation_GAEC(INTEGER) CASCADE;

-- Fonction saying if an operation is of GAEC type
CREATE OR REPLACE FUNCTION is_exploitation_GAEC(op_id INTEGER)
	RETURNS BOOLEAN AS $is_exploitation_GAEC$
	BEGIN
		RETURN e.typeop = 'GAEC' FROM operation as e WHERE e.idop = op_id;
	END;
$is_exploitation_GAEC$ LANGUAGE plpgsql;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Deletion
DROP TRIGGER IF EXISTS GAEC_max_limit ON breeder;
DROP FUNCTION IF EXISTS check_insert_in_breeder() CASCADE;

-- Function checking if a breeder can be added
CREATE OR REPLACE FUNCTION check_insert_in_breeder()
	RETURNS TRIGGER AS $check_insert_in_breeder$
	DECLARE
		is_gaec BOOLEAN;
		nb_breeders INTEGER;
	BEGIN
		is_gaec := is_exploitation_GAEC(NEW.idop);
		IF is_gaec
		THEN
			nb_breeders := _.nb FROM (
                            SELECT count(breeder.idbreeder) as nb
                            FROM breeder
                            WHERE breeder.idop = NEW.idop
                          ) as _;
			IF nb_breeders > 9
			THEN
				RAISE EXCEPTION 'A GAEC can not have more thant 10 breeders.';
			END IF;
		END IF;
    RETURN NEW;
	END;
$check_insert_in_breeder$ LANGUAGE plpgsql;

-- Trigger function to check if an insert is GAEC compliant
CREATE TRIGGER GAEC_max_limit
BEFORE INSERT OR UPDATE ON breeder
FOR EACH ROW
	EXECUTE PROCEDURE check_insert_in_breeder();

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Deletion
DROP TRIGGER IF EXISTS GAEC_min_limit ON breeder;
DROP FUNCTION IF EXISTS check_delete_on_breeder() CASCADE;

-- Function checking if a breeder can be removed from operation
CREATE OR REPLACE FUNCTION check_delete_on_breeder()
	RETURNS TRIGGER AS $check_delete_on_breeder$
	DECLARE
		is_gaec BOOLEAN;
		nb_breeders INTEGER;
	BEGIN
		is_gaec := is_exploitation_GAEC(OLD.idop);
		IF is_gaec
		THEN
			nb_breeders := _.nb FROM (
                            SELECT count(breeder.idbreeder) as nb
                            FROM breeder
                            WHERE breeder.idop = OLD.idop
                          ) as _;
			IF nb_breeders < 3
			THEN
				RAISE EXCEPTION 'A GAEC must have at least 2 breeders.';
			END IF;
		END IF;
    RETURN OLD;
	END;
$check_delete_on_breeder$ LANGUAGE plpgsql;
-- Trigger function to check if a breeder drop or change is GAEC compliant
CREATE TRIGGER GAEC_min_limit
BEFORE DELETE OR UPDATE ON breeder
FOR EACH ROW
	EXECUTE PROCEDURE check_delete_on_breeder();

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Deletion
DROP TRIGGER IF EXISTS GAEC_update_checker ON operation;
DROP FUNCTION IF EXISTS check_update_on_operation() CASCADE;

-- Fonction checking if an operation type can be changed to a GAEC
CREATE OR REPLACE FUNCTION check_update_on_operation()
	RETURNS TRIGGER AS $check_update_on_operation$
	DECLARE
		nb_breeders INTEGER;
	BEGIN
		IF NEW.typeop = 'GAEC'
		THEN
			nb_breeders := _.nb FROM (
                            SELECT count(breeder.idbreeder) as nb
                            FROM breeder
                            WHERE breeder.idop = NEW.idop
                          ) as _;
			IF (nb_breeders < 2 OR nb_breeders > 10)
			THEN
				RAISE EXCEPTION 'A GAES must have between 2 and 10 breeders.';
			END IF;
		END IF;
    RETURN NEW;
	END;
$check_update_on_operation$ LANGUAGE plpgsql;
-- Trigger function checking if type change of an operation is GAEC compliant
CREATE TRIGGER GAEC_update_checker
BEFORE UPDATE ON operation
FOR EACH ROW
	EXECUTE PROCEDURE check_update_on_operation();

--------------------------------------------------------------------------------
-- TESTS
--------------------------------------------------------------------------------

-- Testing of insert breeder GAEC compliance
INSERT INTO breeder VALUES
('032018', 'Toulouse', '4 Avenue Edouard Belin, 31400', 'Alan Bonnet', 2),
('132018', 'Toulouse', '4 Avenue Edouard Belin, 31400', 'Alan Bonnet', 2),
('232018', 'Toulouse', '4 Avenue Edouard Belin, 31400', 'Alan Bonnet', 2),
('332018', 'Toulouse', '4 Avenue Edouard Belin, 31400', 'Alan Bonnet', 2),
('432018', 'Toulouse', '4 Avenue Edouard Belin, 31400', 'Alan Bonnet', 2),
('532018', 'Toulouse', '4 Avenue Edouard Belin, 31400', 'Alan Bonnet', 2),
('632018', 'Toulouse', '4 Avenue Edouard Belin, 31400', 'Alan Bonnet', 2),
('732018', 'Toulouse', '4 Avenue Edouard Belin, 31400', 'Alan Bonnet', 2),
('832018', 'Toulouse', '4 Avenue Edouard Belin, 31400', 'Alan Bonnet', 2),
('932018', 'Toulouse', '4 Avenue Edouard Belin, 31400', 'Alan Bonnet', 2);

-- Testing of delete breeder GAEC compliance
DELETE FROM breeder WHERE namebreeder = 'de Gaulle';

-- Testing of update breeder GAEC compliance
UPDATE breeder SET idop = 3 WHERE namebreeder = 'de Gaulle';

-- Testing of operation update GAEC compliance
UPDATE operation SET typeop = 'GAEC' WHERE nameop = 'centre';
