-- Update choice 126 to point to situation 14 instead of 13
UPDATE choices
SET next_situation_id = 14
WHERE id = 126;
