
# Szituációtípusok

A szituációtípusok határozzák meg az interakciós modellt és a UI viselkedését. Az adatbázisban a `situations` tábla `situation_type` mezőjében 1 és 5 közötti egész számként vannak tárolva, és a `SituationType` enumra vannak leképezve.

## Infó `(Info = 1)`

Nincs választási lehetőség, csak továbblépés. Ehhez a szituációhoz nem tartozhat döntéslehetőség az adatbázisban. A továbblépés a `next_situation_id` alapján történik.

## Párbeszéd `(Conversation = 2)`

Logikailag megegyezik a döntés típussal, de – minthogy párbeszédekről van szó – a UI ebben az esetben hosszabb szövegre optimalizáltan jeleníti meg a választási lehetőségeket.

## Döntés `(Decision = 3)`

Single-select választás több opció közül. A felületen több döntéslehetőség jelenik meg. Egy opció csak egyszer választható; ha később visszatérünk ugyanerre a szituációra, a már kiválasztott opciók inaktívvá válnak, így végtelen ciklusba keveredni nem lehet. A továbblépés a választott döntés `next_situation_id` értéke alapján történik.

## Minijáték `(Minigame = 4)`

Jelenleg infóként működik, a későbbi egyedi játékmenet implementálását készíti elő: párosítások, csoportosítások stb.

## Spéci `(Special = 5)`

Jelenleg döntésként működik, a későbbi multi-select implementálását készíti elő.
