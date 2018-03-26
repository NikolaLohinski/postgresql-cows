--------------------------------------------------------------------------------
-- INSERTING DATA
--------------------------------------------------------------------------------
INSERT INTO operation VALUES
(0, 'centre', 'EARL'),
(1, 'droite', 'GAEC'),
(2, 'gauche', 'GAEC'),
(3, 'anarchiste', 'autre')
;

-- Error testing
-- INSERT INTO Exploitation VALUES (42, 'quelconque', 'erreur');

--------------------------------------------------------------------------------
INSERT INTO breeder VALUES
('040320', 'Paris', '63 rue Sainte-Anne 75002', 'Jean Lecanuet', 0),
('221190', 'Paris', '238 rue de Vaugirard 75015', 'de Gaulle', 1),
('000466', 'Versailles', 'Place dArmes, 78000', 'Clovis 1', 1),
('150851', 'Massy', '6 bis, rue des Anglais 91300', 'Jaures', 2),
('071113', 'Villeblevin', '44 Grande Rue, 89340', 'Camus', 2),
('150109', 'Paris', '145 Rue Amelot, 75011', 'Pierre-Joseph Proudhon', 3)
;

-- Error testing
-- INSERT INTO Eleveur VALUES ('erreur', 'xx', 'xx', 'xx', 0);
-- INSERT INTO Eleveur VALUES ('5err*s', 'xx', 'xx', 'xx', 0);

--------------------------------------------------------------------------------
INSERT INTO herd VALUES
('LREM', 'Christophe', '040320'),
('MoDem', 'Francois', '040320'),

('LR', 'Laurent', '221190'),
('DLF', 'Dupont-Aignan', '221190'),
('FN', 'Marine', '221190'),

('FI', 'Jean Luc', '150851'),
('PS', 'Rachid', '150851'),

('CGT', 'Philippe Martinez', '150109'),
('CGA', 'Dupond', '150109'),

('AR', 'Pierre Bernard', '000466')
;

-- Error testing
-- INSERT INTO Troupeau VALUES ('xx', 'yy', 'ogbjm/');

--------------------------------------------------------------------------------
INSERT INTO cow VALUES
('0107196200', 'Richarde', 'Montbeliarde', 4, 14, 'LREM'),
('1811198200', 'Marlène', 'Prim Hollstein', 5, 22, 'LREM'),
('2005194700', 'Gérarde', 'Prim Hollstein', 4, 11, 'LREM'),
('0510197300', 'Cédric', 'Montbeliarde', 3, 11, 'LREM'),
('2703195100', 'Marielle', 'Prim Hollstein', 1, 24, 'MoDem'),
('2903193900', 'Jeanne-Marie', 'Montbeliarde', 4, 11, 'MoDem'),
('0305195500', 'Jeanne', 'Montbeliarde', 5, 14, 'MoDem'),
('2410196700', 'Jeanne-Christophe', 'Montbeliarde', 5, 16, 'MoDem'),

('1504196900', 'Brunelle', 'Prim Hollstein', 3, 21, 'LR'),
('2105196500', 'Françoise', 'Montbeliarde', 4, 15, 'LR'),
('0101195600', 'Christine', 'Montbeliarde', 2, 19, 'LR'),
('0901192200', 'Emmanuelle', 'Prim Hollstein', 1, 11, 'DLF'),
('1602293600', 'Dominique', 'Montbeliarde', 5, 29, 'DLF'),
('1912195400', 'Lionelle', 'Montbeliarde', 4, 18, 'DLF'),
('0111194400', 'Henriette', 'Prim Hollstein', 3, 21, 'DLF'),
('2212195500', 'Michelle', 'Prim Hollstein', 3, 15, 'DLF'),
('1012198900', 'Marion', 'Montbeliarde', 3, 27, 'FN'),
('2006192800', 'Jean-Marie', 'Montbeliarde', 4, 16, 'FN'),
('0508196800', 'Marine', 'Montbeliarde', 5, 19, 'FN'),


('1508195100', 'Jeanne-Luc', 'Prim Hollstein', 1, 28, 'FI'),
('1708196800', 'Alexis', 'Prim Hollstein', 1, 30, 'FI'),
('1810197500', 'Françoise', 'Montbeliarde', 3, 22, 'FI'),
('3003198600', 'Manuelle', 'Montbeliarde', 3, 22, 'FI'),
('2209195300', 'Segolene', 'Prim Hollstein', 4, 20, 'PS'),
('2610191600', 'Françoise', 'Montbeliarde', 4, 26, 'PS'),
('1206193700', 'Lionelle', 'Montbeliarde', 1, 11, 'PS'),
('1209195400', 'Françoise', 'Prim Hollstein', 2, 19, 'PS'),
('2606196700', 'Benoite', 'Montbeliarde', 4, 13, 'PS'),

('2605195900', 'Eugene', 'Prim Hollstein', 5, 12, 'CGT'),
('0201195900', 'Bernadette', 'Montbeliarde', 1, 14, 'CGT'),
('1603192700', 'Georgette', 'Montbeliarde', 4, 25, 'CGT'),
('0209192400', 'Henriette', 'Montbeliarde', 5, 20, 'CGT'),
('6516516516', 'Tremblay', 'Montbeliarde', 3, 28, 'CGA'),
('2165465456', 'Dupone', 'Prim Hollstein', 2, 12, 'CGA'),
('3218484315', 'Martine', 'Prim Hollstein', 3, 16, 'CGA'),
('3245584224', 'Jane', 'Montbeliarde', 5, 23, 'CGA'),
('6321235132', 'Durande', 'Montbeliarde', 4, 13, 'CGA'),
('9121213545', 'Tartempion', 'Montbeliarde', 1, 17, 'CGA'),

('2403196000', 'Yves', 'Prim Hollstein', 5, 17, 'AR'),
('2004193600', 'Alphonse', 'Prim Hollstein', 5, 25, 'AR'),
('2504197400', 'Louisette', 'Montbeliarde', 4, 23, 'AR'),
('1406193300', 'Henriette', 'Prim Hollstein', 5, 15, 'AR'),
('1107198600', 'Jeanne-Christophe', 'Montbeliarde', 1, 24, 'AR')
;

-- Error testing
-- INSERT INTO Vache VALUES ('aos987p*-/', 'xxx', 'Prim Hollstein', 1, 30, 'zz');
-- INSERT INTO Vache VALUES ('0123456789', 'xxx', 'race alien', 1, 30, 'zz');
-- INSERT INTO Vache VALUES ('0123456789', 'xxx', 'Prim Hollstein', 0, 30, 'zz');
-- INSERT INTO Vache VALUES ('0123456789', 'xxx', 'Prim Hollstein', 5, 31, 'zz');

--------------------------------------------------------------------------------
INSERT INTO food VALUES
('Pouvoir d achat', 'porte-monnaie', 26),
('Impots', 'porte-monnaie', 51),
('Impots', 'fiscalité', 67),
('Immigration', 'valeurs', 86),
('Réforme des écoles', 'éducation', 17)
;

--------------------------------------------------------------------------------
INSERT INTO uses VALUES
(0, 'Réforme des écoles', 'éducation'),
(0, 'Impots', 'porte-monnaie'),
(1, 'Immigration', 'valeurs'),
(1, 'Impots', 'fiscalité'),
(2, 'Pouvoir d achat', 'porte-monnaie'),
(2, 'Impots', 'fiscalité')
;
