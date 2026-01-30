# Funkcionalitási lista

Verzió: 1.0 (2026. 01. 30.)

## Karakterkezelés
- 4 játszható karakter közül lehet választani (Máté, Gabriella, Iván, Zsófia)
- Minden karakternek egyedi kezdő statjai vannak, melyek nem és életkor alapján kerülnek meghatározásra
- Minden karakterhez egyedi illusztráció, színtematika, név, idézet és háttértörténet tartozik
- A karakter nyilakkal változtatható
- Karakterválasztáskor látszódnak a kezdőstatok
- A játékos 3 szint közül választhat: doktorandusz, docens, adjunktus

## Játékosprofil létrehozása
- A felhasználónevet a játék megkezdése előtt bekérjük, mentjük
- A felhasználónevet validáljuk:
	- Egyedinek kell lennie
	- Nem haladhatja meg a 32 karaktert
	- Nem lehet üres
- A felhasználónév elejéről és végéről automatikusan leszedjük az üres karaktereket (tab, szóköz stb.)
- A felhasználónév a játék során nem módosítható
- Betöltési állapotot mutatunk a létrehozott karakter mentésekor (hosszabb karakterlétrehozás esetén észlelhető)

## Statok
- Hétféle statot tartunk számon: energia, önreflexió, felkészültség, kezdeményezőkészség, kreativitás, együttműködés, hallgatói motiváció
- A statok értékei korlátozva vannak 0 és 100 közé
- Minden karakternek egyedi kezdőstatjai vannak
- A statok karaktertervezéskor és a játék során végig láthatók az alsó sávban
- A statok egyedi színkódokkal és piktogramokkal jelennek meg
- Hoverre tooltipként megjelenik az adott stat magyar neve
- Változáskor animált vizuális visszajelzést adunk: piros nyíl jelenik meg értékcsökkenéskor, zöld pedig értéknövekedéskor
	- Kiegészítés: A megváltozott stat csempéje megrázkódik, hogy a változás szembetűnőbb legyen

## Játékmechanika
- Döntésvezérelten haladunk végig a szituációkon
- Az egyes szituációkhoz cím, és opcionálisan leírás, illusztráció és döntési lehetőségek tartoznak, ezek meg is jelennek a felületen
- A különböző szituációtípusok eltérően működnek és jelennek meg:
	- Infó esetén nem kell döntést hozni, egyetlen továbblépési lehetőség adott
	- Döntés vagy párbeszéd esetén több választási lehetőséget listázunk
	- Adatbázisszinten felkészítjük a játékot egyéni logikájú szituációk jövőbeli implementálására
- A döntések befolyásolhatják a statokat
- Egy döntést nem lehet kétszer kiválasztani, a már kiválasztott döntés inaktívvá válik
- Minden szituáció egy következőre visz (és az megfelel a döntési fában leírtaknak), amíg terminális szituációhoz nem érünk

## Játékmenet
- A főoldalon megjelenik a bevezetőszöveg és minden designban szereplő egyéb elem
- Játékindításkor megjelenik az email
- Az email elolvasását karakterválasztás követi
- A karakteradatok beállítása után megkezdődik a játék
- A félidőt szituáció(k) után a félidős kiértékelés oldalára navigálunk
- A zárást jelző szituáció(k) után a játékzáró kiértékelés oldalára navigálunk

## Előrehaladás nyomon követése
- Minden játékosdöntést rögzítünk az adatbázisban
- Eltároljuk a játékos aktuális szituációját
- A játékhoz szükséges adatokat cache-eljük
- A játékos létrehozási idejét eltároljuk
- A játék befejeztének időbélyegét rögzítjük a játék végén

## Félidős eredmények
- Félidőben statokra bontott kiértékelést mutatunk
- Minden értékelésnél megjelenítjük a stat magyar nevét, ikonját, értékét és a kiértékelés szövegét
- Az értékelés adott stat értéke alapján változik (gyenge, átlagos, jó)
- Lehetőséget adunk a játék folytatására

## Végső ranglista
- Játék végén statokra bontott kiértékelést mutatunk
- Minden értékelésnél megjelenítjük a stat magyar nevét, ikonját, értékét és a kiértékelés szövegét
- Az értékelés adott stat értéke alapján változik (gyenge, átlagos, jó)
- Játék végén általános értékelést is adunk a játékosnak
- Az általános értékelés az energia és a siker alapján kerül meghatározásra
- Játék végén megmutatjuk a játékos nevét, pozícióját és összpontszámát
- Játék végén megmutatjuk a játékos pozíciójának 2 sugarú környezetét
- Játék végén megmutatjuk az első helyezett nevét és összpontját
- A ranglista lekezeli a szélsőértékeket (amikor az aktív játékos az első vagy utolsó 2 helyen szerepel)
- A ranglistában kiemeljük az aktív játékost (fehér) és az első helyezettet (arany)
- Amennyiben az aktív játékos az első helyezett, az első helyezett kiemelésével (arany) jelenik meg a listában

## Adatkezelés
- Az adatokat adatbázisba mentjük
- A szituációkat és a döntési lehetőségeket adatbázisból olvassuk
- A mentést automatikusan végezzük

## Vizualitás
- A UI terveknek megfelelően egyedi komponensek készültek
- A tartalom túllógás esetén görgethető
- Az elemek stílusozása nem esik szét OS-szintű skálázáskor (150%-ig)
- A játék asztali gépre és laptopra optimalizált
- A gombok a tartalomnak megfelelően változtatják méretüket
- A játék egyedi kurzort használ
