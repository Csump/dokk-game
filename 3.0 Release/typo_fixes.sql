-- Auto-generated typo fixes: capitalization and end punctuation

BEGIN;

-- Situation text fixes (missing end period)
UPDATE situations SET situation_text = 'Mindig van valamilyen technikai probléma, nem mindig működik az internet, a QR kód beolvasással is adódnak gondjaik.' WHERE id = 32;
UPDATE situations SET situation_text = 'Bár a hallgatók igényeire szabtam a kurzust, most mégis inkább azt mondják, hogy kevesebb energiát szeretnének befektetni a kurzus elvégzése során.' WHERE id = 35;
UPDATE situations SET situation_text = 'A hallgatók nem aktívak, nem vesznek részt az új feladatokban, néhány elutasítják az új feladatokat (ellenáll).' WHERE id = 36;
UPDATE situations SET situation_text = 'Elbizonytalanodtam az új módszerrel kapcsolatban, nem érzem elég tapasztaltnak magam a használatához.' WHERE id = 37;

-- Choice text fixes (missing capital / end punctuation)
UPDATE choices SET choice_text = 'Most már kezdjünk bele a fejlesztésbe, elég információnk van a hallgatói fogadtatásról.' WHERE id = 9;
UPDATE choices SET choice_text = 'Egy típusú kvízt mélyítsünk, használjunk többféleképpen.' WHERE id = 10;
UPDATE choices SET choice_text = 'Egy másik online eszközt vonjunk be - mondjuk a Mekpit.' WHERE id = 11;
UPDATE choices SET choice_text = 'Ne legyen online kvíz, mindenki csinálja azt, ami nála bevált.' WHERE id = 12;
UPDATE choices SET choice_text = 'Találkozzunk havonta és beszéljük át az addig elért mérföldköveket.' WHERE id = 33;
UPDATE choices SET choice_text = 'Találkozzunk havonta, és minden találkozóra két előre megbeszélt szempont alapján gyűjtsük az információkat a pilot sikerességéről.' WHERE id = 34;
UPDATE choices SET choice_text = 'Találkozzunk havonta, mert fontos a személyes tapasztalatcsere, de a fejlesztés sikerességét csak a félév végén értékeljük.' WHERE id = 35;
UPDATE choices SET choice_text = 'Év közben mindenki annyira elfoglalt, elég, ha a félév végén értékeljük a pilotok sikerességét.' WHERE id = 36;
UPDATE choices SET choice_text = 'Egyszerűen el fogom magyarázni nekik a kurzus elején, hogy milyen újítást terveztem erre a félévre.' WHERE id = 37;
UPDATE choices SET choice_text = 'Nem magyarázok, hanem belehelyezem őket egy általam kitalált „mini szimuláció”-ba, hogy megtapasztalhassák az új tanulási irányt, és megkérem, hogy reflektáljanak erre.' WHERE id = 38;
UPDATE choices SET choice_text = 'Csinálok egy rövid felmérést a hallgatók körében a kurzus elején, hogy milyen igényeik vannak a kurzussal kapcsolatban.' WHERE id = 39;
UPDATE choices SET choice_text = 'A legjobb, ha elkezdem az oktatást és majd menet közben megértik a hallgatók, hogy mi változott.' WHERE id = 40;
UPDATE choices SET choice_text = 'Mindig van valamilyen technikai probléma, nem minden hallgatónál működik az internet, a QR kód beolvasással is adódnak gondjaik.' WHERE id = 42;
UPDATE choices SET choice_text = 'A hallgatók nem aktívak, nem vesznek részt az új feladatokban, néhány elutasítják az új feladatokat.' WHERE id = 47;
UPDATE choices SET choice_text = 'Segítséget kérek mentoromtól, tapasztalt kollégámtól.' WHERE id = 48;
UPDATE choices SET choice_text = 'Megkérem a mentorom, akiről tudom, hogy fontos neki az aktív tanulás, hogy hospitálhassak egy óráján.' WHERE id = 50;
UPDATE choices SET choice_text = 'A fejlesztő csapatból megkérem az egyik kollégám, hogy jöjjön be hospitálni az órámra.' WHERE id = 51;
UPDATE choices SET choice_text = 'Még várok. Majd kialakul magától, hogy megszokjuk az új helyzetet, a hallgatók is, én is.' WHERE id = 52;
UPDATE choices SET choice_text = 'Építek a már mások által kipróbált előzetes szempontrendszerre, de azt kiegészítem a kari fejlesztésünk szempontjaival.' WHERE id = 53;
UPDATE choices SET choice_text = 'Egy már mások által használt, előzetesen kialakított általános szempontrendszert viszek be a hospitáláshoz.' WHERE id = 54;
UPDATE choices SET choice_text = 'Nyitottan megyek be az órára, nem használok előzetes szempontsort, majd minden fontosat lejegyzetelek.' WHERE id = 55;
UPDATE choices SET choice_text = 'Egy már mások által használt, előzetesen kialakított általános szempontrendszert adok az óralátogatáshoz.' WHERE id = 56;
UPDATE choices SET choice_text = 'Építek a már mások által kipróbált előzetes szempontrendszerre, de azt kiegészítem a kari fejlesztésünk szempontjaival és arra kérem a kollégát, hogy erre jelezzen vissza.' WHERE id = 57;
UPDATE choices SET choice_text = 'Nem adok előzetes szempontokat, kérem, hogy minden fontosat figyeljen meg és jelezzen vissza nekem.' WHERE id = 58;
UPDATE choices SET choice_text = 'Megyek órát tartani' WHERE id = 59;
UPDATE choices SET choice_text = 'Megkérem a mentorom, akiről tudom, hogy fontos neki az aktív tanulás, hogy hospitálhassak egy óráján.' WHERE id = 60;
UPDATE choices SET choice_text = 'A fejlesztő csapatból megkérem az egyik kollégám, hogy jöjjön be hospitálni az órámra.' WHERE id = 61;
UPDATE choices SET choice_text = 'Talán nem egyértelműen fogalmaztam meg az értékelési szempontokat, ezért ezeket újra átbeszélem a hallgatókkal.' WHERE id = 65;
UPDATE choices SET choice_text = 'Következő alkalommal újból bemutatom az órámhoz tartozó online felületet.' WHERE id = 66;
UPDATE choices SET choice_text = 'Online tartom az órát.' WHERE id = 82;
UPDATE choices SET choice_text = 'Elmarad az órám, addig is tudok kutatni.' WHERE id = 83;
UPDATE choices SET choice_text = 'Még sok téma maradt, amit meg kell beszélni, folytatom a kurzust, ahogy eddig.' WHERE id = 84;
UPDATE choices SET choice_text = 'Nem beszélek róla, mindenki látja a jegyét az online platformunkon, a Kleopátra-rendszerben.' WHERE id = 88;
UPDATE choices SET choice_text = 'A félév közepén kapott hallgatói visszajelzést hozom, miután kérem, hogy most is jelezzenek vissza, arról beszélgetünk, hogyan változtak a tapasztalataik.' WHERE id = 92;
UPDATE choices SET choice_text = 'Egy QR-kód segítségével egy online kérdőívet töltetek ki velük, aminek eredményeit utána közösen meg tudjuk beszélni.' WHERE id = 93;
UPDATE choices SET choice_text = 'Beszélgetek a hallgatókkal az innovációval kapcsolatos tapasztalataikról.' WHERE id = 94;
UPDATE choices SET choice_text = 'Igen, elégedett vagyok.' WHERE id = 95;
UPDATE choices SET choice_text = 'Alapvetően elégedett vagyok, de szeretnék még tovább fejlődni az oktatási innovációkban.' WHERE id = 96;
UPDATE choices SET choice_text = 'Nem vagyok elégedett az oktatási innováció eredményeimmel, szeretnék még tovább fejlődni.' WHERE id = 97;
UPDATE choices SET choice_text = 'Önreflexió' WHERE id = 98;
UPDATE choices SET choice_text = 'Kezdeményezőkészség' WHERE id = 99;
UPDATE choices SET choice_text = 'Csapatjáték, együttműködés' WHERE id = 100;
UPDATE choices SET choice_text = 'Pedagógiai felkészültség' WHERE id = 101;
UPDATE choices SET choice_text = 'Kreativitás' WHERE id = 102;
UPDATE choices SET choice_text = 'Kis változtatásokkal csináljuk tovább, de vonjunk be egyre több kollégát!' WHERE id = 106;
UPDATE choices SET choice_text = 'Még nem annyira sikeres a pilotunk, hogy más kollégáknak is tudjuk ajánlani a karon az új megoldásokat.' WHERE id = 107;
UPDATE choices SET choice_text = 'Csak Lehet Péternek' WHERE id = 109;
UPDATE choices SET choice_text = 'Informális beszélgetések' WHERE id = 112;
UPDATE choices SET choice_text = 'Egyetemi vagy kari innovációs napon' WHERE id = 113;
UPDATE choices SET choice_text = 'Gólyatábor' WHERE id = 114;
UPDATE choices SET choice_text = 'Konferencián' WHERE id = 115;
UPDATE choices SET choice_text = 'Segítséget kérek mentoromtól, tapasztalt kollégámtól.' WHERE id = 116;
UPDATE choices SET choice_text = 'Megkérem a mentorom, akiről tudom, hogy fontos neki az aktív tanulás, hogy hospitálhassak egy óráján.' WHERE id = 118;
UPDATE choices SET choice_text = 'A fejlesztő csapatból megkérem az egyik kollégám, hogy jöjjön be hospitálni az órámra.' WHERE id = 119;
UPDATE choices SET choice_text = 'Még várok. Majd kialakul magától, hogy megszokjuk az új helyzetet, a hallgatók is, én is.' WHERE id = 120;
UPDATE choices SET choice_text = 'Segítséget kérek mentoromtól, tapasztalt kollégámtól.' WHERE id = 121;
UPDATE choices SET choice_text = 'Megkérem a mentorom, akiről tudom, hogy fontos neki az aktív tanulás, hogy hospitálhassak egy óráján.' WHERE id = 123;
UPDATE choices SET choice_text = 'A fejlesztő csapatból megkérem az egyik kollégám, hogy jöjjön be hospitálni az órámra.' WHERE id = 124;
UPDATE choices SET choice_text = 'Még várok. Majd kialakul magától, hogy megszokjuk az új helyzetet, a hallgatók is, én is.' WHERE id = 125;

COMMIT;
