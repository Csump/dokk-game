
# Architektúra

## Technology stack
- **Framework**: .NET 9
- **Frontend**: Blazor Server (interactive server rendering)
- **Adatbázis**: PostgreSQL + Entity Framework Core
- **Konténerizáció**: Docker

## Projektstruktúra

### Fő komponensek

#### Components/Pages
- `GameBoard.razor`: A játék központi felülete, itt történik meg a végigjátszás. A játékosok különböző helyzeteken haladnak végig, a döntéseikkel alakítják a játékmenetet és a statjaikat.

#### Services
- `GameService`: A játék üzleti logikája (játékos létrehozása, döntések kezelése, előrehaladás)
- `GameState`: Scope-olt állapotkezelés az aktuális játékos sessionjére
- `SessionStorageService`: Böngésző session storage használata a játékos állapotának megőrzésére

#### Models
- `Player`: Játékos entitás statokkal, döntésekkel és haladáskövetéssel.
- `Situation`: Játékszituációk narratív tartalommal.
- `Choice`: Döntési opciók statok befolyásolásával és láncolt szituációk hivatkozásaival.
- `Stats`: Játékos statjai (energia, önreflexió, felkészültség, kezdeményezőkészség, kreativitás, együttműködés, hallgatói motiváció).
- `PlayerType`: Karakter demográfiai adatai (szint, nem, életkor).
- `DecisionLog`: A játékos döntéseinek logjai.

#### Data
- `GameDbContext`: EF Core context + PostgreSQL mapelés

## Architektúra

### Állapotkezelés
- **Scoped service-ek**: A `GameState` és a `GameService` Blazor circuitenként scoped service-ként vannak regisztrálva.
- **Session perzisztencia**: A játékos azonosítója a böngésző session storage-ében kerül tárolásra.

### Renderelési mód
- **Interactive server**: Valós idejű szerveroldali renderelés SignalR kommunikációval.
