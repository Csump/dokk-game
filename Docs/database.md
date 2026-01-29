# Adatbáziskezelés

## Az adatbázis elérése

### Alapinformációk

Az adatbázis kizárólag az ELTE hálózatáról érhető el. A külső, közvetlen adatbázis-kapcsolat le van tiltva. Az adatbázis elérése a host szerveren futtatott Docker konténeren keresztül történik.

### Előfeltételek

#### ELTE VPN hozzáférés

Külső gépről való csatlakozás esetén mindenképpen csatlakozni kell az ELTE VPN-hez. A hozzáférést (VIP státusz) előzetesen meg kell igényelni.

#### SSH hozzáférés

Szükséges továbbá egy [SSH kulcspár generálása](https://docs.oracle.com/en/cloud/cloud-at-customer/occ-get-started/generate-ssh-key-pair.html) is. Ebből a publikus kulcsot el kell küldeni a rendszergazdáknak, hogy tudják, melyik gépet engedhetik be a szerverre.

### Csatlakozás

#### SSH kapcsolódás privát kulccsal:

```bash
ssh -i ~/.ssh/elte strygm_manager@docker-prod2.caesar.elte.hu
```

A parancsot kiadván bejutunk az ELTE szerverére. Az adatbázis adatai (például a szerkesztéséhez szükséges jelszó) a `.psql_creds` fájlban található.

#### SQL scriptek futtatása Dockerrel

Ha a `scripts` könyvtárba helyeztük az általunk írt scriptet, az alábbi paranccsal tudjuk futtatni:

```bash
docker run -it --rm -v /opt/strygm_manager/scripts:/tmp/scripts postgres:16-alpine psql -h db-ext01.caesar.elte.hu -U dokkstorygame_manager -d dokkstorygame -f /tmp/scripts/FILENAME.sql
```

Ehhez a parancshoz be fogja kérni a felület a korábban említett jelszót.

#### Interaktív adatbázis-elérés (psql)

Interaktív PostgreSQL konzol indítása:

```bash
docker run -it --rm -v /opt/strygm_manager/scripts:/tmp/scripts postgres:16-alpine sh
```

Majd a konténeren belül:

```bash
psql -h db-ext01.caesar.elte.hu -U dokkstorygame_manager -d dokkstorygame
```

Az itt kiadható parancsokhoz egy kis segédlet: [PostgreSQL interactive terminal](https://www.postgresql.org/docs/current/app-psql.html). Innen egyébként sima SQL parancsok is kiadhatók.

## Az adatbázis felépítése

Az adatbázis strukturális terve [ezen a linken tekinthető meg](https://www.figma.com/board/ue4BZW1J3yJbtgdWZwh7Vu/Development?node-id=1-2999&t=pK3QmD2RcbSQBrdK-4).

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

Az adatbázis tartalmát [SQL scriptekkel](https://www.w3schools.com/sql/sql_examples.asp) lehet szerkeszteni és megtekinteni.

### Általános figyelmeztetések

- Ellenőrizd a kötelező mezők meglétét!
- Ellenőrizd az értékek típusát és korlátait! (Például a `situations` tábla `situation_type` mezője csak 1 és 5 közötti egész számokat fogad el.)
- Ha azonosítóhivatkozást módosítasz (például `next_situation_id`), ellenőrizd, hogy a hivatkozott azonosító létezik-e!
- Válassz megfelelő szituációtípust! (A helyes döntéshez érdemes elolvasni a [Szituációtípusok](./Docs/situation-types.md) dokumentációt.)
- Szituáció vagy döntéslehetőség módosításánál, törlésénél vigyázz, hogy ne sérüljön a játék végigjátszhatósága!
- Szituációt akkor törölj, ha nem tartozik hozzá és nem hivatkozik rá egy döntéslehetőség sem!





