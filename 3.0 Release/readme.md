# HEDGIE 3.0

## Adatbázisfrissítés

A játék megfelelő működéséhez néhány módosítást el kell végezni az adatbázison. Ezt az alábbi scriptek (megfelelő sorrendű) futtatásával lehet megtenni:

1. [`add-minigame.sql`](add-minigame.sql): A minijáték sémájának és adatainak felvétele (`methodology_alignments` tábla, `required_selections` mező, 9 metodológia–cél–értékelés párosítás)
2. [`add-new-methodology-choice.sql`](add-new-methodology-choice.sql): Új döntési lehetőség felvétele a 12. szituációhoz
3. [`misc_text_fixes.sql`](misc_text_fixes.sql): Szöveges tartalmak javítása (szituáció- és döntésszövegek átírása, tördelés, pontosítás)
4. [`typo_fixes.sql`](typo_fixes.sql): Automatikus helyesírási javítások (mondatkezdő nagybetűk, mondatvégi írásjelek)

## Deployment hozzávalói

* Projektcsomag: *(hamarosan)*
* Compose fájl: [`compose.yaml`](../Game/compose.yaml)
