--------------------------------------------------------------------------------
-- CREATING TABLES
--------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS operation (
  IdOp INTEGER CHECK ((IdOp >= 0)),
  NameOp VARCHAR(32),
  TypeOp VARCHAR(8) CHECK ((TypeOp IN ('GAEC', 'EARL', 'autre'))),
  PRIMARY KEY (IdOp)
);

CREATE TABLE IF NOT EXISTS breeder (
  IdBreeder CHAR(6) CHECK (NOT IdBreeder ~ '[^0-9]' AND char_length(IdBreeder) = 6),
  City VARCHAR(32),
  Address VARCHAR(64),
  NameBreeder VARCHAR(32),
  IdOp INTEGER CHECK ((IdOp >= 0)),
  PRIMARY KEY (IdBreeder),
  FOREIGN KEY (IdOp) REFERENCES operation(IdOp)
);

CREATE TABLE IF NOT EXISTS herd (
  Meadow VARCHAR(32),
  Dog VARCHAR(32),
  IdBreeder CHAR(6) CHECK (
                      NOT IdBreeder ~ '[^0-9]' AND char_length(IdBreeder) = 6
                    ),
  PRIMARY KEY (Meadow),
  FOREIGN KEY (IdBreeder) REFERENCES breeder(IdBreeder)
);

CREATE TABLE IF NOT EXISTS cow (
  IdCow CHAR(10) CHECK (NOT IdCow ~ '[^0-9]' AND char_length(IdCow) = 10),
  NameCow VARCHAR(32),
  Race VARCHAR(16) CHECK ((Race IN ('Prim Hollstein', 'Montbeliarde'))),
  LactRank INTEGER CHECK ((LactRank >= 1) AND (LactRank <= 5)),
  DailyProd INTEGER CHECK ((DailyProd >= 10) AND (DailyProd <= 30)),
  Meadow VARCHAR(32),
  PRIMARY KEY (IdCow),
  FOREIGN KEY (Meadow) REFERENCES herd(Meadow)
);

CREATE TABLE IF NOT EXISTS food (
  TypeFood VARCHAR(32),
  Location VARCHAR(32),
  Weight INTEGER CHECK ((Weight >= 0)),
  PRIMARY KEY (TypeFood, Location)
);

CREATE TABLE IF NOT EXISTS uses (
  IdOp INTEGER CHECK ((IdOp >= 0)),
  TypeFood VARCHAR(32),
  Location VARCHAR(32),
  FOREIGN KEY (IdOp) REFERENCES operation(IdOp),
  FOREIGN KEY (TypeFood, Location) REFERENCES food(TypeFood, Location)
);