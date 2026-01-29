-- Add circular references
ALTER TABLE situations 
ADD CONSTRAINT fk_situations_next 
FOREIGN KEY (next_situation_id) REFERENCES situations(id);

-- Fix sequences
CREATE SEQUENCE situations_id_seq;
ALTER TABLE situations ALTER COLUMN id SET DEFAULT nextval('situations_id_seq');
SELECT setval('situations_id_seq', (SELECT MAX(id) FROM situations));

CREATE SEQUENCE choices_id_seq;
ALTER TABLE choices ALTER COLUMN id SET DEFAULT nextval('choices_id_seq');
SELECT setval('choices_id_seq', (SELECT MAX(id) FROM choices));