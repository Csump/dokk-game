# Adatbáziskezelés

## Az adatbázis elérése

TODO

## Az adatbázis felépítése

Az adatbázis strukturális terve [ezen a linken teinthető meg](https://www.figma.com/board/ue4BZW1J3yJbtgdWZwh7Vu/Development?node-id=1-2999&t=pK3QmD2RcbSQBrdK-4).

### Szituációk

Tábla neve: `situations`

- `id`: A szituáció azonosítója (létrehozásnál nem kell megadni).
- `title`: A szituáció címe (kötelező).
- `situation_text`: A szituáció leírása.
- `illustration`: Az illusztrációs fájl neve (pld. "illu.png".
- `is_starter`: Alapértelmezetten `FALSE`, a kezdőszituáció esetén TRUE. A tábláben pontosan egy `TRUE` értékű szituáció szerepelhet.
- `is_halftime`: Alapértelmezetten `FALSE`, a félidős képernyő előtti utolsó szituáció esetén `TRUE`. A tábláben pontosan egy TRUE értékű szituáció szerepelhet.
- `is_terminal`: Alapértelmezetten `FALSE`, a zárószituáció(k) esetén `TRUE`. A tábláben legalább egy TRUE értékű szituáció kell, hogy szerepeljen.
- `situation_type`: A szituáció típusa (kötelező). Az alábbi számértékeket veheti fel:
	- 1 (infó)
	- 2 (párbeszéd)
	- 3 (döntés)
	- 4 (minijáték)
	- 5 (spéci)
- `next_situation_id`: A következő szituáció azonosítója. Infó és minijáték típusú szituációk esetén kötelező kitölteni, minden más esetben üresen hagyandó.

Példa hozzáadásra:

```sql
INSERT INTO situations (id, title, situation_text, illustration, is_starter, is_halftime, is_terminal, situation_type, next_situation_id) VALUES (3, 'Meg tudjátok hozni a döntést a kurzusok átalakításáról?', NULL, 'kurzusalakitas_dontes.png', FALSE, FALSE, FALSE, 3, NULL);
```

### Döntéslehetőségek

Tábla neve: `choices`

- `id`: A döntés azonosítója (létrehozásnál nem kell megadni).
- `situation_id`: Azon szituáció azonosítója, amelynek egy lehetséges döntéseként szerepeltetni szeretnénk ezt az elemet (kötelező).
- `choice_text`: A döntés szövege (kötelező).
- `next_situation_id`: A következő szituáció azonosítója (kötelező).
- `delta_*`: A döntés okozta statváltozás értéke adott statra. A statok:
	- Energy: energia
	- Self-reflection: önreflexió
	- Competency: felkészültség
	- Initiative: kezdeményezőkészség
	- Creativity: kreativitás
	- Cooperation: együttműködés
	- Motivation: hallgatói motiváció

Példa hozzáadásra:

```sql
INSERT INTO choices (id, situation_id, choice_text, next_situation_id, delta_energy, delta_selfreflection, delta_competency, delta_initiative, delta_creativity, delta_cooperation, delta_motivation) VALUES (2, 3, 'Még nincs elég információnk.', 5, NULL, NULL, 1, 1, NULL, NULL, NULL);
```

### Játékosok

Tábla neve: `players`

- `id`: A döntés azonosítója.
- `name`: A játékos neve.
- `is_male`: `TRUE`, ha a játékos férfikaraktert választott, `FALSE`, ha nőit.
- `is_old`: `TRUE`, ha a játékos idős karaktert választott, `FALSE`, ha fiatalt.
- `level`: A játékos szintje.
	- 1 = doktorandusz
	- 2 = docens
	- 3 = adjunktus
- `energy`: A játékos energiaszintje.
- `selfreflection`: A játékos önreflexiós szintje.
- `competency`: A játékos felkészültségi szintje.
- `initiative`: A játékos kezdeményezőkészség-szintje.
- `creativity`: A játékos kreativitási szintje.
- `cooperation`: A játékos együttműködési szintje.
- `motivation`: A játékos hallgatóinak motivációs szintje.
- `current_situation_id`: A játékos aktuális helyzete a játékban (melyik szituációnál tart).
- `created_at`: A játékos létrejöttének dátuma-időpontja.
- `completed_at`: A játék befejeztének dátuma-időpontja.

Ebbe a táblába manuálisan nem kell belenyúlni. A kiürítéséhez a `05_reset.sql` scriptet kell futtatni.

### Döntések

Tábla neve: `decisions`

- `id`: A döntés azonosítója.
- `player_id`: A döntéshozó játékos azonosítója.
- `choice_id`: A választott döntés azonosítója.
- `timestamp`: A döntéshozás dátuma-időpontja.

Ebbe a táblába manuálisan nem kell belenyúlni. A kiürítéséhez a `05_reset.sql` scriptet kell futtatni.

## Az adatbázis szerkesztése

Az adatbázist [SQL scriptekkel](https://www.w3schools.com/sql/sql_examples.asp) lehet szerkeszteni.

### Általános figyelmeztetések

- Ellenőrizd a kötelező mezők meglétét!
- Ellenőrizd az értékek típusát és korlátait! (Például a `situations` tábla `situation_type` mezője csak 1 és 5 közötti egész számokat fogad el.)
- Ha azonosítóhivatkozást módosítasz (például `next_situation_id`), ellenőrizd, hogy a hivatkozott azonosító létezik-e!
- Válassz megfelelő szituációtípust! (A helyes döntéshez érdemes elolvasni az `architecture.md` vonatkozó leírását.)
- Szituáció vagy döntéslehetőség módosításánál, törlésénél vigyázz, hogy ne sérüljön a játék végigjátszhatósága!
- Szituációt akkor törölj, ha nem tartozik hozzá és nem hivatkozik rá egy döntéslehetőség sem!
