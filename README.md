# HEDGIE

**Higher Education Game for Innovation Expertise**

HEDGIE is a gamified research and experimentation tool developed as part of an ELTE university project.

The goal of the project is to support higher education instructors in exploring and reflecting on innovative teaching and educational decision-making through a decision-based game experience.

## Concept

HEDGIE is a decision-based narrative game. The player creates a character with predefined attributes. The game progresses through situations. Each situation may present:

* Information only
* One or more decisions
* Minigame-like interactions (in the future)

Each decision:

* Modifies player stats (additive, capped)
* Determines the next situation

Some situations are terminal, ending the game. At halftime and in the end, an evaluation is shown.

## Player Stats

The game tracks multiple attributes, such as:

* Energy
* Motivation
* Confidence
* Proactivity
* Cooperation
* Preparedness
* Creativity

Stat changes are additive only and respect predefined caps.

## Technical Overview

### Architecture

* Blazor Server application
* Entity Framework Core
* Designed in-memory first, database-ready later
* Content-driven architecture (data separated from logic)

### Database

* PostgreSQL
* Decisions are logged for later evaluation
* No authentication or password storage

## Folders

### Game/

The actual Blazor application. This folder alone is sufficient to run the project.

### Misc/

Supplementary materials (these files are not required to run the application).

