BEGIN;

INSERT INTO situations (id, title, situation_text, illustration, is_starter, is_halftime, is_terminal, situation_type, next_situation_id) 
VALUES (69, 'Mit teszel?', 'Hogyan próbálod megoldani a fókuszba helyezett kihívást?', 'folyoso_interakcio.png', FALSE, FALSE, FALSE, 3, NULL);

INSERT INTO situations (id, title, situation_text, illustration, is_starter, is_halftime, is_terminal, situation_type, next_situation_id) 
VALUES (70, 'Mit teszel?', 'Hogyan próbálod megoldani a fókuszba helyezett kihívást?', 'folyoso_interakcio.png', FALSE, FALSE, FALSE, 3, NULL);

INSERT INTO choices (id, situation_id, choice_text, next_situation_id, delta_energy, delta_selfreflection, delta_competency, delta_initiative, delta_creativity, delta_cooperation, delta_motivation) VALUES 
(116, 69, 'Segítséget kérek mentoromtól, tapasztalt kollégámtól', 69, -1, NULL, NULL, NULL, NULL, NULL, NULL),
(117, 69, 'Áttanulmányozom a releváns szakirodalmat, jó tanácsokat.', 31, -1, 1, 1, NULL, NULL, NULL, NULL),
(118, 69, 'Megkérem a mentorom, akiről tudom, hogy fontos neki az aktív tanulás, hogy hospitálhassak egy óráján', 25, -1, 1, 1, 1, 1, 1, NULL),
(119, 69, 'A fejlesztő csapatból megkérem az egyik kollégám, hogy jöjjön be hospitálni az órámra', 69, -1, NULL, NULL, NULL, NULL, NULL, NULL),
(120, 69, 'Még várok. Majd kialakul magától, hogy megszokjuk az új helyzetet, a hallgatók is, én is', 69, -5, NULL, NULL, NULL, NULL, NULL, NULL),
(121, 70, 'Segítséget kérek mentoromtól, tapasztalt kollégámtól', 70, -1, NULL, NULL, NULL, NULL, NULL, NULL),
(122, 70, 'Áttanulmányozom a releváns szakirodalmat, jó tanácsokat.', 31, -1, 1, 1, NULL, NULL, NULL, NULL),
(123, 70, 'Megkérem a mentorom, akiről tudom, hogy fontos neki az aktív tanulás, hogy hospitálhassak egy óráján', 70, -1, 1, 1, 2, 1, 1, NULL),
(124, 70, 'A fejlesztő csapatból megkérem az egyik kollégám, hogy jöjjön be hospitálni az órámra', 28, -1, NULL, NULL, NULL, NULL, NULL, NULL),
(125, 70, 'Még várok. Majd kialakul magától, hogy megszokjuk az új helyzetet, a hallgatók is, én is', 70, -5, NULL, NULL, NULL, NULL, NULL, NULL);


UPDATE choices SET next_situation_id = 69 WHERE id IN (43, 44);
UPDATE choices SET next_situation_id = 70 WHERE id IN (45, 46);

UPDATE choices SET next_situation_id = 39 WHERE id = 48;
UPDATE choices SET next_situation_id = 31 WHERE id = 49;
UPDATE choices SET next_situation_id = 24 WHERE id IN (50, 51, 52);

COMMIT;