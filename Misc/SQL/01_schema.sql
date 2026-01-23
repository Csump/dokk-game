BEGIN;

drop type if exists situation_type_enum;

CREATE TYPE situation_type_enum AS ENUM ('Info', 'Decision', 'Minigame', 'Conversation', 'Special');
CREATE TYPE player_level AS ENUM ('Doktorandusz', 'Docens', 'Adjunktus');

drop table if exists choices;
drop table if exists situations;

CREATE TABLE situations (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    situation_text TEXT,
    illustration TEXT,
    is_starter BOOLEAN DEFAULT FALSE,
    is_halftime BOOLEAN DEFAULT FALSE,
    is_terminal BOOLEAN DEFAULT FALSE,
    situation_type situation_type_enum,
    next_situation_id INTEGER -- Will add FK constraint in 03_constraints
);

CREATE TABLE choices (
    id INTEGER PRIMARY KEY,
    situation_id INTEGER NOT NULL REFERENCES situations(id),
    choice_text TEXT NOT NULL,
    next_situation_id INTEGER REFERENCES situations(id),
    delta_energy INTEGER,
    delta_selfreflection INTEGER,
    delta_competency INTEGER,
    delta_initiative INTEGER,
    delta_creativity INTEGER,
    delta_cooperation INTEGER,
    delta_motivation INTEGER
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    is_male BOOLEAN,
    is_old BOOLEAN,
    level player_level,
    energy INTEGER DEFAULT 0,
    selfreflection INTEGER DEFAULT 0,
    competency INTEGER DEFAULT 0,
    initiative INTEGER DEFAULT 0,
    creativity INTEGER DEFAULT 0,
    cooperation INTEGER DEFAULT 0,
    motivation INTEGER DEFAULT 0,
    current_situation_id INTEGER REFERENCES situations(id)
);

CREATE TABLE decisions (
    id SERIAL PRIMARY KEY,
    player_id INTEGER REFERENCES players(id),
    choice_id INTEGER REFERENCES choices(id),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMIT;