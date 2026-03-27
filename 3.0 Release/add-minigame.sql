-- Migration: Add multi-select support and methodology_alignments table
-- Run this after the initial schema and data scripts.

BEGIN;

-- Add required_selections column to situations (used for Special/multi-select situations)
ALTER TABLE situations ADD COLUMN IF NOT EXISTS required_selections INTEGER;

-- Create methodology_alignments table
-- Maps each methodology choice to its correct Aim and Assessment text,
-- plus stat deltas applied per correct/incorrect pairing in the minigame.
CREATE TABLE IF NOT EXISTS methodology_alignments (
    id SERIAL PRIMARY KEY,
    choice_id INTEGER NOT NULL REFERENCES choices(id),
    aim_text TEXT NOT NULL,
    assessment_text TEXT NOT NULL,
    -- Deltas applied once per correct pairing
    correct_delta_energy INTEGER DEFAULT 0,
    correct_delta_selfreflection INTEGER DEFAULT 0,
    correct_delta_competency INTEGER DEFAULT 0,
    correct_delta_initiative INTEGER DEFAULT 0,
    correct_delta_creativity INTEGER DEFAULT 0,
    correct_delta_cooperation INTEGER DEFAULT 0,
    correct_delta_motivation INTEGER DEFAULT 0,
    -- Deltas applied once per incorrect pairing attempt
    incorrect_delta_energy INTEGER DEFAULT 0,
    incorrect_delta_selfreflection INTEGER DEFAULT 0,
    incorrect_delta_competency INTEGER DEFAULT 0,
    incorrect_delta_initiative INTEGER DEFAULT 0,
    incorrect_delta_creativity INTEGER DEFAULT 0,
    incorrect_delta_cooperation INTEGER DEFAULT 0,
    incorrect_delta_motivation INTEGER DEFAULT 0
);

-- Set required_selections for situation 15 (Jógyakorlat workshop, Special type)
UPDATE situations SET required_selections = 3 WHERE id = 15;

-- Redirect situation 15 choices to skip situation 16 (the A/B/C methodology package workaround)
-- Choices 15-23 belong to situation 15 and previously led to situation 16
UPDATE choices SET next_situation_id = 17 WHERE situation_id = 15;

-- Redirect situation 16's choices for safety (existing players who already chose A/B/C)
UPDATE choices SET next_situation_id = 17 WHERE situation_id = 16;

-- Insert methodology_alignments for all 9 methods from situation 15.
-- Correct pairing: +2 competency, -1 energy
-- Incorrect pairing: -1 energy
INSERT INTO methodology_alignments (
    choice_id, aim_text, assessment_text,
    correct_delta_competency, correct_delta_energy,
    incorrect_delta_energy
) VALUES
-- Choice 15: Szakértői mozaik
(15,
 'A hallgatók képessé válnak szakmai együttműködésre, közös gondolkodásra, az egyénileg megszerzett ismeretek megosztására.',
 'Társ visszajelzés a közös munkára egy értékelőtábla segítségével.',
 2, -1, -1),
-- Choice 16: Gamifikáció
(16,
 'A hallgatók képessé válnak saját tanulásuk irányítására és szervezésére.',
 'A folyamatban végig jelen vannak az értékelő aktusok, melyek segítik optimalizálni a tanulási folyamatot, a cél elérésének érdekében.',
 2, -1, -1),
-- Choice 17: Fogalomtérkép
(17,
 'Előre rögzített szempontoknak való megfelelés, pl. fogalomhasználat, szintezés mélysége stb.',
 'A hallgatók képessé válnak rendszerezni és vizuálisan ábrázolni egy témával kapcsolatos tudást akár egyénileg, akár másokkal kooperálva.',
 2, -1, -1),
-- Choice 18: Vitapingpong
(18,
 'A hallgatók képessé válnak arra, hogy megtanulják, hogy figyeljenek a másikra, ne csak a saját érveiket hangoztassák, hanem egymás érveire is reagáljanak.',
 'Érvelési szempontokat tartalmazó önértékelési kártya.',
 2, -1, -1),
-- Choice 19: Online csoportmunka
(19,
 'A hallgatók képessé válnak az online együttműködésre és közös kreatív, alkotó feladat megvalósítására.',
 'Egyéni reflexió megadott szempontok mentén arról, hogy a közös munka során milyen készségek fejlődtek.',
 2, -1, -1),
-- Choice 20: Kutatás
(20,
 'A hallgatók képessé váljanak releváns kutatási téma azonosítására, kritikus elemzésére.',
 'Cheklist/feladatlista használata.',
 2, -1, -1),
-- Choice 21: Projekt
(21,
 'A hallgatók képessé válnak az együttműködésre, közös problémamegoldásra, döntéshozatalra, felelősségvállalásra.',
 'Előzetes értékelési szempontsor az elkészült produktumhoz.',
 2, -1, -1),
-- Choice 22: Szerepjáték
(22,
 'A hallgatók képessé válnak az empatikus kommunikációra és gyakorolják a társas viselkedést.',
 'A feltöltött videókra adott tanári vagy társak általi visszajelzések alapján történő értékelés.',
 2, -1, -1),
-- Choice 23: Hallgatói kiselőadás, prezentáció
(23,
 'A hallgatók képessé válnak a megszerzett tudás rendszerezésére, bemutatására, a szemléltetés megtervezésére.',
 'Ön- és társértékelés előre megadott megfigyelési szempontsor segítségével.',
 2, -1, -1);

COMMIT;
