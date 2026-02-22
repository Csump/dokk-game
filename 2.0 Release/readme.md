# HEDIGE 2.0

## Adatbázisfrissítés

A játék megfelelő működéséhez néhány módosítást el kell végezni az adatbázisban. Ezt az alábbi scriptek (megfelelő sorrendű) futtatásával lehet megtenni:

1. [`update-illustrations.sql`](update-illustrations.sql): Illusztrációk hivatkozásainak cseréje a szituációk táblában
2. [`fix-gameplay-logic.sql`](fix-gameplay-logic.sql): Döntési út javítása
3. [`add-links.sql`](add-links.sql): Döntéshez kötött hivatkozások felvétele

## Deployment

A [`dokk-game-2.0.tar`](https://drive.google.com/file/d/1L5IDEYCxAqllxVhsUSUZK27e50XZusTs/view?usp=sharing) fájlba csomagolt projektet az alábbi parancsokkal lehet betölteni, majd futtatni:

```bash
docker load -i dokk-game-2.0.tar
```

```bash
docker run -d --name dokk-game-2.0 -p 10070:10070 dokk-game:latest
```

