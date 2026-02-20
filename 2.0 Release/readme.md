# HEDIGE 2.0

## Adatbázisfrissítés

A játék megfelelő működéséhez néhány módosítást el kell végezni az adatbázisban. Ezt az alábbi scriptek (megfelelő sorrendű) futtatásával lehet megtenni:

1. `update-illustrations.sql`: Illusztrációk hivatkozásainak cseréje a szituációk táblában
2. `fix-gameplay-logic`: Döntési út javítása
3. `add-links.sql`: Döntéshez kötött hivatkozások felvétele

## Deploy

A telepítéshez mindössze egy TAR fájl szükséges, amely jelen könyvtárban fedezhető fel `dokk-game-2.0.tar` néven.

