-- Add new choice to situation 12 ("Ideje a fejlesztésre koncentrálnunk!...")
-- Choice: "Új módszer bevonását javaslom."
-- Points: +1 competency, +1 initiative, +1 cooperation

BEGIN;

-- Ensure the sequence is ahead of any explicitly inserted IDs (e.g. from fix-gameplay-logic.sql)
SELECT setval('choices_id_seq', (SELECT MAX(id) FROM choices));

INSERT INTO choices (situation_id, choice_text, next_situation_id, delta_competency, delta_initiative, delta_cooperation)
VALUES (12, 'Új módszer bevonását javaslom.', 13, 1, 1, 1);

COMMIT;
