-- Reformat situation 45 text to use bullet points (Q&A style) matching situation 29's formatting

BEGIN;

UPDATE situations SET situation_text = E'– Talán nem ért egyet a projekt céljával?\n\
– Igazából kevésbé számít, hogy egyetért-e, az OMHV alapján a felsővezetés ezt várja tőlünk, és a mi dolgunk az, hogy kari szinten megoldást keressünk.\n\
\n\
– Talán nem veszi komolyan?\n\
– Mivel csak most kezdett betanítani ebbe a kurzusba, talán nem tudja, hogy az elmúlt években egyre rosszabb a tárgy megítélése, és a hallgatók teljesítménye, miközben alapvető fontosságú a kurrikulumban. A társintézeteknek is fontos, hogy jobban tudjanak építeni a hallgatóink tudására, és ehhez próbálunk hozzájárulni a magunk eszközeivel.\n\
\n\
– Talán csak bizonytalan?\n\
– Erre van sok jógyakorlat a felsőoktatásban, ezeket próbáljuk megismerni és a saját lehetőségeinkhez mérten beépíteni. Apránként, kísérletezve, egymást is segítve. Nem csak a hallgatókért, hanem hogy nekünk is jelentsen sikerélményt a tanítás. És persze a megmaradásunk érdekében is. Haladnunk kell a korral, nincs mese, de erre megvan minden lehetőségünk.'
WHERE id = 45;

-- Fix typos in choices for situation "Feszültség van a teamben a passzív kolléga hozzáállása miatt."
UPDATE choices SET choice_text = 'Megkérem a pilot projekt team vezetőjét, hogy intézkedjen.'
WHERE id = 77;

UPDATE choices SET choice_text = 'Gondoljuk át a terhelhetőségünket és feladatainkat!'
WHERE id = 78;

UPDATE choices SET choice_text = 'Kihasználom promócióra. Meghívom a vendégeket az órámra.'
WHERE id = 80;

UPDATE choices SET choice_text = 'Az utolsó órát a hallgatói munka és az innovációs elemek értékelésére használom.'
WHERE id = 85;

UPDATE choices SET choice_text = 'Kellene visszajelzést gyűjtenem és adnom, de nincs idő.'
WHERE id = 86;

UPDATE situations SET title = 'Olvastam egy cikket arról, hogy az új módszer az alábbiakban segít:'
WHERE id = 51;

UPDATE situations SET situation_text = E'– jobban megérteni a kurzus témáit, tartalmát;\n\
– jobban elérni a kitűzött kurzuscélokat, tanulási eredményeket;\n\
– a tantárgy iránti érdeklődésem fokozásában;\n\
– motiváltabbá válni a kurzuson való részvételre;\n\
– hasznos a tanulásomhoz.'
WHERE id = 51;

-- Fix choice texts for situation "Osztálytermi helyzet - A félév végén most szer..."
UPDATE choices SET choice_text = 'A félév végén az egész csoport munkáját értékelem. Áttekintem a kurzushoz kötődő fő tanulási eredményeket és mindegyik kapcsán visszajelzek, hogy a csoport melyik területen fejlődött a legjobban, illetve melyikben kevésbé.'
WHERE id = 89;

UPDATE choices SET choice_text = 'Az óra elején csoport szintjén értékelem a hallgatói fejlődést. Az óra végén pedig 30 percet arra is szánok, hogy egyénileg is kérdezhessenek a féléves munkájukról, fejlődésükről. Megkérem őket hogy konkrét kérdésekkel jöjjenek, hogy ezzel is hatékonyabbá tehessük a megbeszélést.'
WHERE id = 90;

UPDATE choices SET choice_text = 'A félév végén közösen értékeljük az egész csoport munkáját. Együtt megnézzük a tematikában megjelölt célokat. Megkérem a hallgatókat, hogy először egyénileg gondolják át, mit tanultak, miben fejlődtek, majd ezt beszéljék meg egymással és végül én is összegezem az általam tapasztaltakat.'
WHERE id = 91;

-- Fix typo in situation "Egy kolléga csapatjáték..."
UPDATE situations SET situation_text = REPLACE(situation_text, 'A karrierem elején én sokat szenvedtem', 'A karrierem elején sokat szenvedtem')
WHERE id = 58;

-- Reformat situation text for "Hallgatói visszajelzések" (situations 64 and 65)
UPDATE situations SET situation_text = E'Az órákon és a szünetekben elhangzott hallgatói vélemények szerint jó irányban változtak a kurzusok.\n\
A módszerek jobban támogatják a komplexebb kérdések feldolgozását, a tananyag összefügéseinek átgondolását.\n\
A digitális eszközök jól működnek. A lényegesen több interaktivitás érdekessé teszi az órákat.\n\
„Tök jó a hangulat, és végre izgalmas kérdésekről is beszélünk."\n\
Kevesebb a stressz, amit korábban a kvíznél alkalmazott időmérés okozott.\n\
Elhangzott néhány jobbító javaslat. Mivel az órai interaktivitás időigényesebb, előfordul, hogy nem mindenre jut egyformán idő, és egyes részekkel a korábbinál többet kell otthoni foglalkozni.\n\
Egyeseknek problémát okoz, hogy az interaktív órák folyamatos lépéstartást, felkészülést igényelnek minden héten, amit nem mindig tudnak megvalósítani, és ez számukra újabb stressz forrása lehet.'
WHERE id IN (64, 65);

COMMIT;
