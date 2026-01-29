# Játékmenet

## Játékos létrehozása `(/setup)`

A játékos kiválasztja karakterét és szintjét, majd felhasználónevet választ magának.

- **Felhasználónév** (egyedi azonosító, melynek egyedisége ellenőrzött)
- **Szint** (`PlayerLevel` enum)
- **Nem** (`Male`/`Female`)
- **Kor** (`Young`/`Old`)

A karakter neme és életkora befolyással van a kezdőstatokra, ennek kiszámításáért a `Stats.GetDefault()` metódus felel.

## Játék menete `(/play)`

### Szituációtípusok

A játék öt különböző szituációtípust használ. Ezek hatással vannak a működési modellre és a UI viselkedésére. Részletes leírás: [Szituációtípusok](situation-types.md).

> **Megjegyzés**: a `Special` és `Minigame` típusok jelenleg egyszerűsített módon működnek. Ezek későbbi funkcióbővítésre vannak előkészítve, amely egyedi játéklogikát igényel.

## Checkpointok

### Félidő `(IsHalftime = true)`
Félidős ellenőrzőpont, amely a játékost a `/results` oldalra irányítja. Itt egy rövid kiértékelést kap a statjairól, illetve lehetőséget adunk a játék folytatására.

### Záró `(IsTerminal = true)`
A játék végét jelzi. A `Player.CompletedAt` időbélyeg beállításra kerül. A játékost a `/leaderboard` oldalra irányítjuk, ahol elolvashatja a végső kiértékelést és megtekintheti a rangsorban elfoglalt pozícióját, és annak 2 sugarú környezetét. A játékmenet lezárul.

## Statok

Hétféle stattal dolgozunk:
-   **Energy**: energia
-   **Self-reflection**: önreflexió
-   **Competency**: felkészültség
-   **Initiative**: kezdeményezőkészség
-   **Creativity**: kreativitás
-   **Cooperation**: együttműködés
-   **Motivation** vagy **Success**: hallgatói motiváció

A statisztikák a döntések során, a `Choice.DeltaStats` értékei alapján módosulnak.

## Döntések logolása

Minden döntés rögzítésre kerül a `decisions` táblában. A játék megakadályozza ugyanazon döntés ismételt kiválasztását: a már kiválasztott döntések inaktívvá válnak. A döntéslogok időbélyeggel is el vannak látva, így könnyedén felhasználhatók kutatási, statisztikai célra.
