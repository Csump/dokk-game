BEGIN;

ALTER TABLE choices 
ADD COLUMN link TEXT NULL;

UPDATE choices
SET link = CASE
    WHEN id = 27 THEN 'https://docs.google.com/document/d/15A_PVxn_7HKL632M-fFX0C4zs1V1yA1T/'
    WHEN id = 28 THEN 'https://docs.google.com/document/d/1FE5itZB2WxcklbyspArCzLyYgU2SZEGS/'
    ELSE link
END
WHERE id IN (27, 28);

COMMIT;