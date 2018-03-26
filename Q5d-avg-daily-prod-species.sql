-- Drop function if it exists
DROP FUNCTION IF EXISTS breeder_race(CHAR(6), VARCHAR(32));

-- Fonction selecting cows from a specified race and breeder
CREATE OR REPLACE FUNCTION breeder_race(
	id_breeder CHAR(6),
	race_cow VARCHAR(32)
)
	RETURNS TABLE(
		NameOfBreeder VARCHAR(32),
		Id CHAR(10),
		Name VARCHAR(32),
		Race VARCHAR(16),
		LactRank INTEGER,
		DailyProd INTEGER,
		Meadow VARCHAR(32)
 	) AS $breeder_race$
	BEGIN
	RETURN QUERY (
		SELECT
			breeder.namebreeder as NameOfBreeder,
			cow.idcow,
			cow.namecow,
			cow.race,
			cow.lactrank,
			cow.dailyprod,
			cow.meadow
		FROM cow
		NATURAL JOIN herd
		NATURAL JOIN breeder
		WHERE breeder.idbreeder = id_breeder
			AND cow.race = race_cow
	);
	END;
$breeder_race$ LANGUAGE plpgsql;

-- Test
SELECT
	NameOfBreeder AS "Breeder",
	'040320' AS "Id",
	race as "Race",
	AVG(dailyProd) as "Average production (l/j)"
FROM breeder_race('040320', 'Prim Hollstein')
GROUP BY "Race", "Breeder";