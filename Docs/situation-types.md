
# Szituációtípusok

A szituációtípusok határozzák meg az interakciós modellt és a UI viselkedését. Az adatbázisban a `situations` tábla `situation_type` mezőjében 1 és 5 közötti egész számként vannak tárolva, és a `SituationType` enumra vannak leképezve.

## Infó `(Info = 1)`

Nincs választási lehetőség, csak továbblépés. Ehhez a szituációhoz nem tartozhat döntéslehetőség az adatbázisban. A továbblépés a `next_situation_id` alapján történik.

## Párbeszéd `(Conversation = 2)`

Logikailag megegyezik a döntés típussal, de – minthogy párbeszédekről van szó – a UI ebben az esetben hosszabb szövegre optimalizáltan jeleníti meg a választási lehetőségeket.

## Döntés `(Decision = 3)`

Single-select választás több opció közül. A felületen több döntéslehetőség jelenik meg. Egy opció csak egyszer választható; ha később visszatérünk ugyanerre a szituációra, a már kiválasztott opciók inaktívvá válnak, így végtelen ciklusba keveredni nem lehet. A továbblépés a választott döntés `next_situation_id` értéke alapján történik.

## Minijáték `(Minigame = 4)`

Drag-and-drop konstruktív összehangolási játék. Egy képernyőn jelenik meg 3 Módszertan (amelyeket a játékos az előző Special szituációban választott ki), és hozzájuk rendelendő Cél és Értékelés kártyák. A játékosnak a Cél- és Értékelés-kártyákat kell a helyes Módszertanhoz húzni.

**Mechanika:**
- A helyes párosítás „rögzül" (nem mozgatható tovább).
- A helytelen párosítás eltávolítható és máshova helyezhető.
- Mindkét esetben statisztikamódosítás (delta) kerül alkalmazásra – a helyes/helytelen deltákat a `methodology_alignments` tábla tárolja Módszertanonként.
- A szituáció akkor ér véget (és a játékos tovább léphet), ha mind a 6 slot (3 Cél + 3 Értékelés) helyesen ki van töltve.

**Adatok forrása:** A Módszertan-kártyák a játékos által a megelőző Special szituációban kiválasztott döntések szövegéből jönnek. A helyes Cél és Értékelés szövegek a `methodology_alignments` táblából töltődnek be.

## Multi-select / Többes választás `(Special = 5)`

Többes kiválasztás több opció közül. A játékos egyszerre több döntést választhat ki, majd egy „Megerősítés" gombbal véglegesíti a választást.

**Mechanika:**
- A `situations.required_selections` mező határozza meg a kötelezően kiválasztandó opciók számát (konfigurálható szituációnként).
- A kiválasztott opciók vizuálisan kiemelésre kerülnek.
- Amíg a kötelező szám nincs elérve, a Megerősítés gomb inaktív.
- Minden választott opcióhoz tartozó stat-delta alkalmazásra kerül.
- A már véglegesített szituáción a gombok inaktívvá válnak (visszatéréskor sem lehet újra választani).

## Spéci `(Special = 5)` – Korábbi viselkedés

Korábban döntésként működött, workaround-ként. Ez mostantól a teljes multi-select implementációval váltja fel.
