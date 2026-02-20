ALTER TABLE choices 
ADD COLUMN link TEXT NULL;

UPDATE choices 
SET link = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ' 
WHERE id IN (24, 25, 26, 27, 28);

COMMIT;