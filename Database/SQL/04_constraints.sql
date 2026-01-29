-- Add circular references
ALTER TABLE situations 
ADD CONSTRAINT fk_situations_next 
FOREIGN KEY (next_situation_id) REFERENCES situations(id);

ALTER TABLE choices 
ADD CONSTRAINT fk_choices_next 
FOREIGN KEY (next_situation_id) REFERENCES situations(id);

ALTER TABLE choices 
ADD CONSTRAINT fk_choices_situation 
FOREIGN KEY (situation_id) REFERENCES situations(id);

ALTER TABLE decisions 
ADD CONSTRAINT fk_decisions_player 
FOREIGN KEY (player_id) REFERENCES players(id);

ALTER TABLE decisions 
ADD CONSTRAINT fk_decisions_choice 
FOREIGN KEY (choice_id) REFERENCES choices(id);

-- Fix sequences
CREATE SEQUENCE situations_id_seq;
ALTER TABLE situations ALTER COLUMN id SET DEFAULT nextval('situations_id_seq');
SELECT setval('situations_id_seq', (SELECT MAX(id) FROM situations));

CREATE SEQUENCE choices_id_seq;
ALTER TABLE choices ALTER COLUMN id SET DEFAULT nextval('choices_id_seq');
SELECT setval('choices_id_seq', (SELECT MAX(id) FROM choices));