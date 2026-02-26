# HEDIGE 2.1

## Adatbázisfrissítés

A játék megfelelő működéséhez néhány módosítást el kell végezni az adatbázisban. Ezt az alábbi scriptek (megfelelő sorrendű) futtatásával lehet megtenni:

1. [`update-illustrations.sql`](update-illustrations.sql): Illusztrációk hivatkozásainak cseréje a szituációk táblában
2. [`fix-gameplay-logic.sql`](fix-gameplay-logic.sql): Döntési út javítása
3. [`add-links.sql`](add-links.sql): Döntéshez kötött hivatkozások felvétele

## Deployment hozzávalói

* Projektcsomag: [`dokk-game-2.1.tar`](https://drive.google.com/file/d/1fDdH6zo79PNCmkmv5OzEaRSs1I6WfakX/view?usp=sharing)
* Compose fálj: [`compose.yaml`](../Game/compose.yaml)

