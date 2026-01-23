BEGIN;

drop table if exists choices;
drop table if exists situations;

CREATE TABLE situations (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    situation_text TEXT,
    illustration TEXT,
    is_starter BOOLEAN DEFAULT FALSE,
    is_halftime BOOLEAN DEFAULT FALSE,
    is_terminal BOOLEAN DEFAULT FALSE,
    situation_type INTEGER,
    next_situation_id INTEGER -- Will add FK constraint in 03_constraints
);

CREATE TABLE choices (
    id INTEGER PRIMARY KEY,
    situation_id INTEGER NOT NULL REFERENCES situations(id),
    choice_text TEXT NOT NULL,
    next_situation_id INTEGER REFERENCES situations(id),
    delta_energy INTEGER,
    delta_selfreflection INTEGER,
    delta_competency INTEGER,
    delta_initiative INTEGER,
    delta_creativity INTEGER,
    delta_cooperation INTEGER,
    delta_motivation INTEGER
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    is_male BOOLEAN,
    is_old BOOLEAN,
    level INTEGER,
    energy INTEGER DEFAULT 0,
    selfreflection INTEGER DEFAULT 0,
    competency INTEGER DEFAULT 0,
    initiative INTEGER DEFAULT 0,
    creativity INTEGER DEFAULT 0,
    cooperation INTEGER DEFAULT 0,
    motivation INTEGER DEFAULT 0,
    current_situation_id INTEGER REFERENCES situations(id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL
);

CREATE TABLE decisions (
    id SERIAL PRIMARY KEY,
    player_id INTEGER REFERENCES players(id),
    choice_id INTEGER REFERENCES choices(id),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO situations (id, title, situation_text, illustration, is_starter, is_halftime, is_terminal, situation_type, next_situation_id) VALUES
(1, 'Összeállt a csapat!', NULL, 'osszeallt_a_csapat.png', TRUE, FALSE, FALSE, 1, 2),
(2, 'OMHV statisztikai adatok', 'Az egyetemi OMHV rendszerben összegzett adatok az online kvíz módszert alkalmazó kurzusokról. Az előző három tanév átlaga vs. a módszer bevezetése után:                      

– Az oktató módszerével elégedett:  53% / 34%. 

– Mennyire volt interaktív a foglalkozás:  13% / 21%.

– A kurzus oktatóját ajánlaná-e hallgatótársainak: 69% / 61%. ', 'diagramok_stat.jpg', FALSE, FALSE, FALSE, 1, 3),
(3, 'Meg tudjátok hozni a döntést a kurzusok átalakításáról?', NULL, 'kurzusalakitas_dontes.png', FALSE, FALSE, FALSE, 3, NULL),
(4, 'Az oktatási dékánhelyettes úgy látja, hogy az OMHV adatok alapján nem lehet kurzust átalakítani, további információk megszerzését kéri!', NULL, 'choice_dekan.png', FALSE, FALSE, FALSE, 1, 3),
(5, 'Bár hosszan próbáltok érvelni a döntésetek mellett, az oktatási dékánhelyettes nem ért egyet azzal, hogy nem kell megújítani a kurzusokat, így újra össze kell hívnotok a csapatot.', NULL, 'choice_dekan.png', FALSE, FALSE, FALSE, 1, 3),
(6, 'A csapatban a feladatok kiosztása során te kapod meg az adatgyűjtés tervezésének feladatát. Milyen módszert javasolsz ehhez a csapatnak? ', NULL, 'diagramok_stat.jpg', FALSE, FALSE, FALSE, 3, NULL),
(7, 'A kérdőíves megkérdezés eredménye', 'A vizsgált időszak végén a hallgatók (N=182) az online kvíz módszert 34%-al találták kevésbé érdekesnek, mint az időszak elején. A nyílt kérdéses indoklásból kiderült, hogy a módszer játékos, interaktív jellege, továbbá a verseny élményszerűsége kezdetben jól motiválta a hallgatókat, és ösztönözte őket arra, hogy minél jobban igyekezzenek megérteni a tananyagot. Nehezményezték ugyanakkor, hogy sokan folyton ezt a módszert alkalmazzák és emiatt később a kvíz monotonná, és egyre unalmasabbá vált. A hallgatók 64%-a úgy vélte, hogy a kvíz inkább csak felszínes aktivitást generál, nem ösztönzi a véleményalkotást, kreativitást, problémamegoldást, és innovatív gondolkodást. 82% szerint nem képes megjeleníteni az anyag mélyebb összefüggéseit, amelyek a kurzus későbbi részeiben kulcsfontosságúvá váltak. 59% gyakrabban dolgozna kiscsoportban az egyéni válaszadás helyett. 71% a módszert továbbra is alkalmazná, de sokkal ritkábban, és csak gondosan kiválasztott tananyagrészekhez kapcsolódóan. A válaszadók 94%-a nem vetné el a digitális módszerek alkalmazását, és 87% többféle módszert felváltva alkalmazna a kurzusok során. Összesen 14 különféle módszerre és eszközre érkezett javaslat.', 'diagramok_stat.jpg', FALSE, FALSE, FALSE, 1, 11),
(8, 'Külső szakértővel való beszélgetés', 'A szakértői megbeszélés során az oktató számára világossá vált, hogy a tanulói aktivitás növeléséhez a kurzus szerkezetének átgondolása és az ehhez jól illeszkedő digitális eszközök bevezetése szükséges. A szakértő segítségével sikerült azonosítani a legnagyobb kihívásokat – például az a hallgatói értetlenséget és a passzív hozzáállást – valamint néhány konkrét blended tanulási megoldást is megneveztek, mint például a fordított osztálytermet, az online csoportmunkát és az ehhez kötődő osztálytermi visszajelzéseket. Az oktató elhatározta, hogy egy kisebb tananyagrészt kísérleti jelleggel átdolgoz, és a félév során folyamatosan gyűjt visszajelzést a hallgatóktól a módszer finomhangolása érdekében. A szakértő javasolta, hogy bármelyik új módszer, eszköz kipróbálása kapcsán érdemes visszajelzést kérni a hallgatóktól és ahol lehet, már menet közben finomhangolni a megoldásokat. További támogatását is felajánlotta a tervezés és értékelés fázisában. ', 'hangsav.png', FALSE, FALSE, FALSE, 1, 11),
(9, 'Hallgatói fókuszcsoport eredménye ', 'A hallgatók elmondták, hogy az első hetekben érdekesnek és izgalmasnak találták a Kohutot és a Mekpit használatát. Az interaktív kvízek versenyhelyzete és az azonnali visszajelzés feldobta az órákat, és eleinte abban is segített, hogy könnyebben eligazodjanak az új tananyagban. Megemlítették, hogy eleinte úgy érezték, hogy ez a módszer segíti őket a tananyag átlátásában, mivel lehetőséget kaptak arra, hogy csoportosan dolgozzanak, így különböző szempontokból vizsgálják meg az adott témát. A hallgatók többsége kifejezte, hogy bár az elején élvezték a módszert, idővel egyre inkább monotonná és unalmassá vált számukra, és a Kohut folyamatos alkalmazása fáradtságot eredményezett. Többen elmondták, hogy az aktív részvétel segített abban, hogy ne tartsák unalmasnak az órákat, de hosszabb távon nem vezetett valódi mélyebb megértéshez, és a tanulás minőségét sem javította tartósan. A módszer inkább csak felszínes aktivitást generált, de nem ösztönözte őket arra, hogy valóban elmélyedjenek a tananyagban. A kutatás szerint a Kohut módszer egyes elemeinek módosítása vagy kiegészítése segíthetne abban, hogy a hallgatók újra érdeklődjenek és valóban aktívan részt vegyenek a tanulási folyamatokban.', 'hangsav.png', FALSE, FALSE, FALSE, 1, 11),
(10, 'A pilot csoport oktatóival közös diagnosztizálás eredménye', 'A közös diagnosztikai ülések során az oktatók kritikusan reflektáltak a Koohut-módszer használatával kapcsolatos tapasztalataikra. A legtöbben egyetértettek abban, hogy kezdetben a hallgatók szívesen vettek részt a játékban, különösen a versenyelemek és a valós idejű visszajelzés miatt. Többen kiemelték, hogy a módszer teljesítményközpontú viselkedésre ösztönözte a hallgatókat, akik gyakran a jó pontszám elérésére törekedtek anélkül, hogy teljes mértékben megértették volna a mögöttes tartalmat. Sokan úgy érezték, hogy míg a kvízek az alapvető ismeretek átismétlésére hatékonyak voltak, az elmélyültebb tanulás, a kritikus gondolkodás vagy az értelmes vita elősegítésére kevésbé voltak alkalmasak. Bár az oktatók nyitottak maradtak a digitális és interaktív eszközökre, azt javasolták, hogy a Kohutot elsősorban bemelegítésre, formatív ellenőrzésre vagy a kulcsfogalmak áttekintésére használják semmint központi tanítási stratégiaként. A közös ülésen számos gyakorlati javaslat is felszínre került, például a kvíz-alapú foglalkozások kombinálása kollaboratív feladatokkal, esetmegbeszélésekkel vagy projektmunkával a mélyebb megértés támogatása és a hallgatók motivációjának fenntartása érdekében.', 'word.jpg', FALSE, FALSE, FALSE, 1, 11),
(11, 'Fontos eredményeket kaptunk! ', 'Azért jó lenne még egy további kutatási módszert is alkalmazni a hallgatók elégedetlenségének feltárásához! ', 'teamules.png', FALSE, FALSE, FALSE, 2, NULL),
(12, 'Ideje a fejlesztésre koncentrálnunk! Mit csináljunk másképp?', NULL, 'dekan.png', FALSE, FALSE, FALSE, 3, NULL),
(13, 'Hogyan haladtok?', NULL, 'lehetpeter_hogyanhaladtok.png', FALSE, FALSE, FALSE, 2, NULL),
(14, 'Talán érdemes lenne egy olyan kollégát meghívni, aki előttünk jár.', NULL, 'lehetpeter_hogyanhaladtok.png', FALSE, FALSE, FALSE, 2, NULL),
(15, 'Jógyakorlat workshop', 'Kedves Kollégák! Gábor vagyok, 10 éve foglalkozom oktatásfejlesztéssel és Dánielék csapata arra kért, hogy mutassak nektek néhány olyan praktikus módszert, amivel jól lehet az órákon aktivizálni a  hallgatókat. Előzetesen kértem is módszereket Dánieltől, amiket már alkalmaztok a kurzusaitokban. Ezeket és további 10 olyan ötletet fogunk átbeszélni, amik túlmutatnak az online kvíz használatán és segítenek a hallgatói motiváltság megteremtésében. Válassz ezek közül 3 olyat, amit hasznosnak tartasz a  pilot kurzusokban!', 'choice_gabor.png', FALSE, FALSE, FALSE, 5, NULL),
(16, 'Gábor kiscsoportos munkát ad a csapatnak. Melyik módszertani csomagot választod, melyiket érzed hasznosnak a kari fejlesztéshez?', NULL, 'choice_gabor.png', FALSE, FALSE, FALSE, 3, NULL),
(17, 'Gábor szempontjai', 'A konzultáción Gábor felhívja a figyelmeteket arra, hogy ahhoz, hogy a hallgatók aktív bevonódását eredményesen tudjátok segíteni még egy további szempontot kell átgondolnotok. Ez az elmélet a konstruktív összehangolás, ami szerint nem elég a módszerek végiggondolása, hanem az előre meghatározott hallgatói tanulási eredmények alapján szükséges tervezni az értékelést, valamint a tanulási eredmények fejlődését biztosító tanulási tevékenységeket, módszereket és tanulástámogatást. Azzal tudjuk elősegíteni egy kurzuson belül a tanulási eredmények (tudás, képesség, attitűd) hatékony fejlődését, ha olyan hallgatói tevékenységeket, módszereket kínálunk, ami az adott kompetenciát valóban fejleszti és ehhez olyan értékelési eszközt párosítunk, ami az adott területen bekövetkezett változásra ad visszajelzést.

Az alábbiakban elérendő célokat (tanulási eredmények), hallgatói tevékenységeket és értékelési eszközöket találsz. A konstruktív összehangolás jegyében párosítani kellene őket!', 'choice_gabor.png', FALSE, FALSE, FALSE, 4, 18),
(18, 'Tantárgyleírás készítése a fejlesztői csapatban', 'A csapatban először közösen készítettetek tematikákat. Az első tantárgy kapcsán két változat készül el. Melyiket tartod szakszerűbbnek a konstruktív összehangolás szempontjából? ', 'word.jpg', FALSE, FALSE, FALSE, 3, NULL),
(19, 'Elkészült a tantárgyleírás! Ezt boldogan osztod meg az egyik lelkes hallgatóddal, akivel a folyosón találkozol. 

Emíliának nagyon tetszik a terv, lelkes lesz, de aztán hirtelen el is kedvtelenedik.', 'Emília: Kár, hogy minket kevésbé von be a tantárgy fejlesztésébe. Pedig úgy érzem, nekünk hallgatóknak is vannak jó ötleteink. Szívesen benne lennénk az új módszerek kitalálásában, nemcsak a visszajelzésben. Így szerintem mi is fejlődhetünk kreatív problémamegoldásban, kezdeményezőkészségben, innovativitásban. Mit gondol a fejlesztői oktatói team erről?', 'elkeszult_a_tantargylairas.png', FALSE, FALSE, FALSE, 2, NULL),
(20, 'Szerencsésen befejeztük a kurzusok megújításának tervezését, most már neki kezdhetünk a kurzusok megtartásának. Ezelőtt szeretnél visszajelzést kérni az eddigi fejlődésedről és munkádról a fejlesztő csapat többi tagjától?', NULL, 'email.jpg', FALSE, TRUE, FALSE, 3, 21),
(21, 'Oktatói teamülés ', 'Kezdődik a félév, újra összeül a fejlesztő csapatotok, hogy megtervezzétek az oktatási innováció megvalósítását és értékelését. Szóba kerül, hogy a félév során milyen célból és milyen gyakorisággal érdemes találkoznotok. Te mit fogsz javasolni?', 'teamules.png', FALSE, FALSE, FALSE, 3, NULL),
(22, 'Nagyszerű! Összeállt az új pilot kurzusom. De vajon hogy mutassam be a hallgatóknak?', NULL, 'prezi.png', FALSE, FALSE, FALSE, 3, NULL),
(23, 'Teamülés', 'Az első havi oktatói csapatmegbeszélésen a kollégák számos nehézségről számolnak be az új, innovatív aktív módszer használata kapcsán. Melyikre fókuszáljunk a következő lépésként?', 'teamules.png', FALSE, FALSE, FALSE, 3, NULL),
(24, 'Mit teszel?', 'Hogyan próbálod megoldani a fókuszba helyezett kihívást?', 'folyoso_interakcio.png', FALSE, FALSE, FALSE, 3, NULL),
(25, 'Óralátogatás kollégánál', NULL, 'szeminariumi_terem.png', FALSE, FALSE, FALSE, 3, NULL),
(26, 'Óralátogatás kollégánál', 'Megfigyelési szempontok:

– A célok, tanulási eredmények megjelenése, kapcsolata az órával 

– A hallgatók előzetes tudásával való kapcsolat megteremtése 

– A hallgatók interakciója az oktatóval és egymással 

– Az oktató facilitáló képessége, pl. hallgatói bevonódás elősegítése, csoportmunka szervezése, kérdezés, meghallgatás, válaszadás, a kritikai és elemző gondolkodás lépéseinek támogatása 

– Az egész hallgatói csoport bevonása 

– A hallgatók bátorítása

– A tanítás és tanulás terének kihasználása 

– A hallgatók számára adott formatív, megerősítő visszajelzések minősége 

– A tanultak összegzése és annak kiemelése, hogy mit tanultak a hallgatók 

– A hallgatók támogatása abban, hogy tudatosítsák a tanulási folyamatukat

(Fullerton, H. (2003). Observation of Teaching. In. Fry, H., Ketteridge, S. & Marshall, S. (eds.). A Handbook for Teaching and Learning in Higher Education, 226-241. alapján) ', NULL, FALSE, FALSE, FALSE, 1, 39),
(27, 'Óralátogatás kollégánál', 'Megfigyelési szempontok:

– A célok, tanulási eredmények megjelenése, kapcsolata az órával

– A hallgatók innovatív gondolkodásának, kompetenciáinak fejlesztésének megjelenése 

– A hallgatók előzetes tudásával való kapcsolat megteremtése 

– A hallgatók interakciója az oktatóval és egymással 

– Az oktató facilitáló képessége, pl. hallgatói bevonódás elősegítése, csoportmunka szervezése, kérdezés, meghallgatás, válaszadás, a kritikai és elemző gondolkodás lépéseinek támogatása 

– Az online kvízek mellett új, a hallgatókat aktivizáló módszerek, feladatok használata

– Az egész hallgatói csoport bevonása 

– A hallgatók bátorítása 

– A tanítás és tanulás terének kihasználása 

– A hallgatók számára adott formatív, megerősítő visszajelzések minősége 

– A visszajelzések kapcsolása a kitűzött tanulási eredményekhez, innovatív, aktivizáló módszerekhez

– A tanultak összegzése és annak kiemelése, hogy mit tanultak a hallgatók 

– A hallgatók támogatása abban, hogy tudatosítsák a tanulási folyamatukat

(Fullerton, H. (2003). Observation of Teaching. In. Fry, H., Ketteridge, S. & Marshall, S. (eds.). A Handbook for Teaching and Learning in Higher Education, 226-241. alapján) ', NULL, FALSE, FALSE, FALSE, 1, 39),
(28, 'Kolléga óralátogatása nálam ', NULL, 'szeminariumi_terem.png', FALSE, FALSE, FALSE, 3, NULL),
(29, 'Kolléga óralátogatása nálam ', 'Megfigyelési szempontok:

– A célok, tanulási eredmények megjelenése, kapcsolata az órával 

– A hallgatók előzetes tudásával való kapcsolat megteremtése 

– A hallgatók interakciója az oktatóval és egymással 

– Az oktató facilitáló képessége, pl. hallgatói bevonódás elősegítése, csoportmunka szervezése, kérdezés, meghallgatás, válaszadás, a kritikai és elemző gondolkodás lépéseinek támogatása 

– Az egész hallgatói csoport bevonása 

– A hallgatók bátorítása 

– A tanítás és tanulás terének kihasználása 

– A hallgatók számára adott formatív, megerősítő visszajelzések minősége 

– A tanultak összegzése és annak kiemelése, hogy mit tanultak a hallgatók 

– A hallgatók támogatása abban, hogy tudatosítsák a tanulási folyamatukat

 

(Fullerton, H. (2003). Observation of Teaching. In. Fry, H., Ketteridge, S. & Marshall, S. (eds.). A Handbook for Teaching and Learning in Higher Education, 226-241. alapján) ', NULL, FALSE, FALSE, FALSE, 1, 39),
(30, 'Kolléga óralátogatása nálam ', 'Megfigyelési szempontok:

– A célok, tanulási eredmények megjelenése, kapcsolata az órával

– A hallgatók innovatív gondolkodásának, kompetenciáinak fejlesztésének megjelenése 

– A hallgatók előzetes tudásával való kapcsolat megteremtése 

– A hallgatók interakciója az oktatóval és egymással 

– Az oktató facilitáló képessége, pl. hallgatói bevonódás elősegítése, csoportmunka szervezése, kérdezés, meghallgatás, válaszadás, a kritikai és elemző gondolkodás lépéseinek támogatása 

– Az online kvízek mellett új, a hallgatókat aktivizáló módszerek, feladatok használata

– Az egész hallgatói csoport bevonása 

– A hallgatók bátorítása 

– A tanítás és tanulás terének kihasználása 

– A hallgatók számára adott formatív, megerősítő visszajelzések minősége 

– A visszajelzések kapcsolása a kitűzött tanulási eredményekhez, innovatív, aktivizáló módszerekhez

– A tanultak összegzése és annak kiemelése, hogy mit tanultak a hallgatók 

– A hallgatók támogatása abban, hogy tudatosítsák a tanulási folyamatukat

 

(Fullerton, H. (2003). Observation of Teaching. In. Fry, H., Ketteridge, S. & Marshall, S. (eds.). A Handbook for Teaching and Learning in Higher Education, 226-241. alapján) ', NULL, FALSE, FALSE, FALSE, 1, 39),
(31, 'Első nekifutásra ezeket a tanácsokat találtad a szakirodalomban (1/7)', 'Az innovációra szánt idő miatt felborul az órák ütemezése. Kicsúszok az időből, nem tudom befejezni az órát.

Ne feledd, hogy az újításod nem öncélú, valamit hatékonyabbá tesz az órád során. Gondold át, milyen tartalmak elsajátítását gyorsítja és/vagy mélyíti, amivel kiváltja a korábbi óraterv tartalmait vagy tevékenységeit. (NB: Például az ismétlésképp frontálisan megtartott kiselőadásod helyett tartasz beugró online kvízt és közös megbeszélést, nem azon felül!) A számodra látszólag kevesebb a hallgatók számára több! Nem a teljes tartalmat kell végigvenned velük, hanem a munkaformát, a gondolkodásmódot gyakoroltatni a témában, hogy önállóan is tudjanak dolgozni a további tartalmaiddal. Így amennyi belefér az órádba, annyi elég is! Győződj meg az órán, hogy tudják kezelni a tartalmaidat, a többit pedig bízd a hallgatóidra, és inkább gyakoroltass többet a kontakt alkalmakkor.', 'laptop_tudomanyos.jpg', FALSE, FALSE, FALSE, 1, 32),
(32, 'Első nekifutásra ezeket a tanácsokat találtad a szakirodalomban (2/7)', 'Mindig van valamilyen technikai probléma, nem mindig működik az internet, a QR kód beolvasással is adódnak gondjaik

A digitális tér ugyanolyan előkészítést igényel, mint maga a tanterem. Amikor kontakt órán online kvízt alkalmazol, a digitális teret ötvözöd a fizikális térrel, ami többletmunka. Az órától függetlenül feladat az internet biztosításának feltételeiről gondoskodni, oktatóként jelezd ezt a tanszéken. Alakíts ki élő kapcsolatot az informatikusokkal, tudjanak róla, hogy mi az igény, és kérj háttér támogatást az órák idejére. Engedd meg, hogy szükség esetén egy eszközről akár többen is válaszolhassanak - válassz ennek megfelelő feladatot (például szófelhő). A QR-kódjaidat előre ellenőrizd le, alkalmazz megfelelő felbontást. Törekedj többször használható QR-kódok alkalmazására, ezeket néhány példányban kinyomtatva is beviheted a terembe. A QR-kód csak gyorsítja a belépést, de mindig van manuálisan bepötyöghető elérési út is, vetítsd ki ezt is. Ne tévesszen meg az ”online kvíz” elnevezés, ne feledd, hogy voltaképpen a módszertanodat újítottad meg! A digitális eszköz is csak egy eszköz, szükség esetén konvertálhatod a feladatot analóg eszközökre (például tábla, post-it).', 'laptop_tudomanyos.jpg', FALSE, FALSE, FALSE, 1, 33),
(33, 'Első nekifutásra ezeket a tanácsokat találtad a szakirodalomban (3/7)', 'Hiába épül az új módszer a hallgatók aktivitására, a hallgatók nem elég konstruktívak. Van, aki nem figyel. Vagy az is lehet, hogy nem tudja követni az órát.

Ne feledd, hogy amikor új módszert vezetsz be, az a hallgatók számára új munkaformát jelent. Tájékoztasd őket - a kurzus elején, az előző óra végén, vagy akár üzenetben (e-learning rendszer, e-mail) -, hogy mire készülsz, és tőlük mit vársz (például legyen náluk okoseszköz, előzetesen lépjenek fel a netre a megadott WiFi-kóddal, töltsék le az appot vagy regisztráljanak be előre, stb.). Az új munkaformát és módszert tanítsd is meg nekik, biztosíts gyakorlási lehetőséget az első alkalommal, kifejezetten a platform megismerésére, a feladattípusok begyakorlására technikai szempontból. (Ha ezt témafüggetlen, akár vicces kérdésekkel teszed, még lelkesebbek lesznek a hallgatóid!) Győződj meg róla, hogy készen állnak, mielőtt élesben beveted az újdonságot, és biztasd őket arra, hogy ehhez kérjenek segítséget akár tőled, akár egymástól. Ne felejtsd el megadni nekik a kereteket: mikor vegyék elő az eszközt, mire és meddig használják, mikor tegyék el! Ha megvan a hozzáférésük, magabiztosan kezelik a digitális eszközödet, és megbeszélted velük, mire megy ki a játék, garantáltan figyelni fognak, és nem csak követni lesznek képesek az órádat, hanem segíteni is fogják.', 'laptop_tudomanyos.jpg', FALSE, FALSE, FALSE, 1, 34),
(34, 'Első nekifutásra ezeket a tanácsokat találtad a szakirodalomban (4/7)', 'Hiába terveztem meg gondosan az új tanulási tevékenységeket, a hallgatóknak csak az számít, hogy minél gyorsabban meglegyen az eredmény!

Ez egy jogos igény, ha őszinte vagy magadhoz, más körülmények közt (munkahelyi feltételek, banki szolgáltatások, vendéglátás, tömegközlekedés, autószerviz, lakásfelújítás, egészségügyi ellátás stb.) te magad is hasonlóan gondolkodsz. A befektetés (idő, pénz, energia stb.) álljon arányban a sikerélménnyel, legyen tervezhető, és mielőbb térüljön meg. Ha az arányosságot figyelembe veszed, a visszajelzéseket beépíted, és ügyesen tervezel, a hallgatók is idomulni fognak, hajlandóvá válnak kellő befektetés árán értékesebb eredményre törekedni, ahol nem a gyorsaság lesz a fő szempont, hanem a rendelkezésre álló idő leghatékonyabb kitöltése. Ne feledd, hogy a hallgatók nem egyformák, egyénileg priorizálnak, és nem tudsz mindenkinek egyszerre megfelelni. De, ha nyíltan kommunikálsz velük és partnerként kezeled őket, változhat a prioritásuk akár érzelmi, akár racionális alapon, és meggyőzhetővé válnak a többletmunkára is. Ne csak a negatív hangokat halld meg, a pozitív visszajelzés is visszajelzés, sőt!', 'laptop_tudomanyos.jpg', FALSE, FALSE, FALSE, 1, 35),
(35, 'Első nekifutásra ezeket a tanácsokat találtad a szakirodalomban (5/7)', 'Bár a hallgatók igényeire szabtam a kurzust, most mégis inkább azt mondják, hogy kevesebb energiát szeretnének befektetni a kurzus elvégzése során

Győződj meg róla, hogy nem tervezted túl a kurzust, az óraszámuknak megfelelő reális idő és munkaráfordítást követelsz a hallgatóktól - hiszen ne feledd, hogy vannak más kurzusaik is, és van életük is! A hallgatók felsőbb évfolyamoktól tájékozódnak, melyik kurzus milyen, és mennyi energiát igényel. Ha változtatsz, ezt kommunikáld az új hallgatóid felé, és hangsúlyozd ki, hogy más ez a kurzus, mint amire a felsőbbévesektől receptet kaptak - vagyis írasd velük felül az előzetesen kalkulált energiaszükségletüket! Magyarázd meg nekik, hogy amit látszólag elvesztenek a réven, hol nyerik meg a vámon! Az új módszereidről, eszközeidről mindig kérj visszajelzést: ismerik-e, szeretik-e, mit használnak szívesen (például más órákon tapasztaltak alapján). Apránként vezesd be az újdonságokat, szerettesd meg velük, győződj meg róla, hogy értik a relevanciáját. Ami beválik, használd többet, ami öncélúnak bizonyul, vesd el! Ne feledd, amit szívesen csinálnak, ami sikerélményt jelent, és aminek értelmét látják, abba az emberek több energiát tesznek. Ne várj mindenkitől egyforma erőbedobást és lelkesedést! Menet közben és a kurzus végén is kérj visszajelzést, hogy alakítani tudd az újdonságaidat. Táplálkozz a pozitív visszajelzésekből, és tekints konstruktívan a kritikákra!', 'laptop_tudomanyos.jpg', FALSE, FALSE, FALSE, 1, 36),
(36, 'Első nekifutásra ezeket a tanácsokat találtad a szakirodalomban (6/7)', 'A hallgatók nem aktívak, nem vesznek részt az új feladatokban, néhány elutasítják az új feladatokat (ellenáll)

A hallgatók alapvetően aktívak, szeretik a feladatokat, a változatosságot és a társakkal való interakciót. Ha ellenállást tapasztalsz, első körben a biztonságérzetüket vizsgáld meg: valóban adottak-e a (technikai, tudásbeli, eszközös stb.) feltételek a feladat elvégzéséhez; értik-e pontosan a feladatot; felkészültek-e arra, hogy mit, miért és hogyan kell csinálniuk; sikerélményt nyújtanak-e a feladatok; változatosak-e a feladatok, hasznosak-e a feladatok; belefér-e a feladat a rendelkezésükre álló időkeretbe (az ő tudás- és képességszintjükön!); támogatja-e a feladat a tananyag elsajátítását, a vizsgára való felkészülést? Ezeket a kérdéseket először tedd fel magadnak, akár hasonló feladatokkal dolgozó kollégáidnak. Ha átgondoltad a lehetséges válaszokat, kérdezd meg a hallgatóidat, hogy megismerd az ő szempontjaikat is! Győződj meg róla, hogy ők is tisztában vannak a feladat céljával, kivitelezhetőségével és a várható eredménnyel! Az ellenállást sokszor az ismeretlentől való félelem, irracionális szorongás váltja ki, ami akár egy tisztázó beszélgetéssel feloldható.', 'laptop_tudomanyos.jpg', FALSE, FALSE, FALSE, 1, 37),
(37, 'Első nekifutásra ezeket a tanácsokat találtad a szakirodalomban (7/7)', 'Elbizonytalanodtam az új módszerrel kapcsolatban, nem érzem elég tapasztaltnak magam a használatához

A módszerek széles tárháza áll rendelkezésedre, ismerj meg minél többet, és bátran válogass közöttük. Válaszd ki azt, amelyik a legkomfortosabb számodra, mind technikai szempontból, mind a tartalmaidhoz illeszkedően. Minél több módszert ismersz, annál rugalmasabban tudsz változtatni akár tanítás közben is. Minden hallgató, minden csoport, minden időszak más, egyes módszerek az egyiknél válnak be, mások a másiknál - kísérletezz és váltogasd őket bátran! Egyszerre csak egy új módszert vezess be, és lehetőleg olyan órán, amit tartalmilag különösen szeretsz, a szíveden viseled, lubickolsz benne - így szívesen és magabiztosan fogod variálni, és a kreativitásod is beindul. Ha már egy ilyen órán begyakoroltad, könnyebben viszed tovább a többire is. Vonj be nyugodtan tapasztaltabb kollégát, vagy “beépített embert” a hallgatóid közül. Az új módszereket nem muszáj rögtön élesben kipróbálni, gyakorolhatsz magadban, kollégákkal, ismerősi körben, önkéntes hallgatókkal, vagy akár az órádon belül is, nyíltan kísérleti jelleggel. Ha elárulod a hallgatóidnak, hogy először próbálod ki, ezzel és ezzel készültél, erre és erre számítasz, és kéred egyrészt a türelmüket, másrészt a segítségüket, harmadrészt pedig a visszajelzéseiket, ez egy közös kalanddá válik, ami csak jól végződhet! Merj kísérletezni, légy felkészült, kérj támogatást, és ne légy magadhoz túl szigorú! Gyakorlat teszi a mestert! ', 'laptop_tudomanyos.jpg', FALSE, FALSE, FALSE, 1, 38),
(38, 'Mit teszel az olvasás után?', NULL, 'hedgie_terulo.png', FALSE, FALSE, FALSE, 3, NULL),
(39, 'Működik az órám!', NULL, 'folyoso_interakcio02.png', FALSE, FALSE, FALSE, 1, 40),
(40, 'Érzékeled, hogy a hallgatók bizonytalanná válnak, fültanúja leszel, ahogy egymás közt méltatlankodnak. Mitévő leszel?', NULL, 'folyoso_interakcio.png', FALSE, FALSE, FALSE, 3, NULL),
(41, 'A beavatkozásod nyomán elmúlt a hallgatók bizonytalansága, ügyesen dolgoznak a kurzusodban. Mitévő leszel?', NULL, 'szeminariumi_terem.png', FALSE, FALSE, FALSE, 3, NULL),
(42, 'Fontos, hogy a jó dolgokra is visszajelezzek, ne csak akkor halljanak felőlem, amikor gond van!', NULL, 'hedgie_terulo.png', FALSE, FALSE, FALSE, 1, 43),
(43, 'Oktatói értekezlet: ki hol tart az innovációban?', NULL, 'teamules.png', FALSE, FALSE, FALSE, 3, NULL),
(44, 'Oktatói értekezlet: kiderül, hogy valaki nem csinált semmit.', 'Bocs a késésért, valakinek dolgoznia is kell...Jól ismertek, alaposan és céltudatosan végzem a munkámat, de őszintén szólva, ez az “innovációsdi” kezdetektől fogva nem tetszik. Miért kellene nekünk a fejünk tetejére állva szórakoztatni az ilyen-olyan generációs hallgatókat, és az ő elégedettségükre hajtani?! Ne bohóckodjunk már! Ez nem dedó meg cirkusz, felnőtt embereket tanítunk, akik ezt a pályát választották. Nem élvezni kell az én óráimat, hanem odafigyelni, szorgalmasan jegyzetelni, utánaolvasni és gyakorolni! Mi is így végeztük el az egyetemet annak idején, és örültünk, hogy a legjobbaktól tanulhatunk. Én úgy adom le az anyagot, ahogy eddig, szerintem az én hallgatóim is tudnak annyit, mint a többi csoport, és szó nélkül veszik az akadályokat. ', 'teamules.png', FALSE, FALSE, FALSE, 1, 45),
(45, 'A helyzet kapcsán számos gondolat felmerül bennetek, beszélgettek a teamben, mi lehet a kolléga passzív hozzáállása mögött rejlő valódi ok.', 'Talán nem ért egyet a projekt céljával?

Igazából kevésbé számít, hogy egyetért-e, az OMHV alapján a felsővezetés ezt várja tőlünk, és a mi dolgunk az, hogy kari szinten megoldást keressünk.

Talán nem veszi komolyan?

Mivel csak most kezdett betanítani ebbe a kurzusba, talán nem tudja, hogy az elmúlt években egyre rosszabb a tárgy megítélése, és a hallgatók teljesítménye, miközben alapvető fontosságú a kurrikulumban. A társintézeteknek is fontos, hogy jobban tudjanak építeni a hallgatóink tudására, és ehhez próbálunk hozzájárulni a magunk eszközeivel.

Talán csak bizonytalan?

Erre van sok jógyakorlat a felsőoktatásban, ezeket próbáljuk megismerni és a saját lehetőségeinkhez mérten beépíteni. Apránként, kísérletezve, egymást is segítve. Nem csak a hallgatókért, hanem hogy nekünk is jelentsen sikerélményt a tanítás. És persze a megmaradásunk érdekében is. Haladnunk kell a korral, nincs mese, de erre megvan minden lehetőségünk.', 'teamules.png', FALSE, FALSE, FALSE, 1, 46),
(46, 'Eldöntheted, foglalkozol-e a továbbiakban a problémával. Belépsz a helyzetbe?', NULL, 'teamules.png', FALSE, FALSE, FALSE, 3, NULL),
(47, 'Feszültség van a teamben a passzív kolléga hozzáállása miatt. Mit teszel?', NULL, 'teamules.png', FALSE, FALSE, FALSE, 3, NULL),
(48, 'E-mailt kaptok: “Egyetemünkre külföldi delegáció érkezik, fogadásuk az alábbi helyszíneket érinti...ezeket az alábbi időpontban kérjük szabadon hagyni...” ', 'Az innovatív kurzusod helyszínéül szolgáló, arra speciálisan berendezett termet érinti a delegáció érkezése. Hogyan reagálsz az értesítésre?', 'nemzetkozi_delegacio.png', FALSE, FALSE, FALSE, 3, NULL),
(49, 'Hogyan adsz visszajelzést?', 'A múltkori teamülésen beszéltünk róla, hogy jó lenne visszajelzést kérni a hallgatóktól az oktatási újításainkról. Ez egy nehéz döntés számomra, most éppen rengeteg minden egyéb kutatási és oktatási feladatra kell figyelnem, viszont most már nem is halaszthatom tovább a döntést...  ', 'teamules.png', FALSE, FALSE, FALSE, 3, NULL),
(50, 'Jó napot! Elégedett a csoportunkkal? Ön szerint jól sikerültek az utolsó munkáink, beadandóink? Beszélünk majd arról is, hogy az új, most először kipróbált feladatok hogyan sikerültek? Nekem lenne egy-két megjegyzésem. Szerintem nagyon jó volt a félév, de azért jó lenne hallani a tanárunk véleményét is!', NULL, 'szeminariumi_terem.png', FALSE, FALSE, FALSE, 2, NULL),
(51, 'Keresek irodalmat/kollégát keresek. ', 'Egy mostani cikkben az alábbi szempontokat találtam a visszajelzéshez:

– Az új módszer segített jobban megérteni a kurzus témáit, tartalmát.​

– Az új módszer segített abban, hogy jobban elérjem a kitűzött kurzuscélokat, tanulási eredményeket.​

– Az új módszer segített a tantárgy iránti érdeklődésem fokozásában.​

– Az új módszer segített, hogy motiváltabbá váljak a kurzuson való részvételre.​

– Az új módszer hasznos volt a tanulásomhoz.​', 'laptop.png', FALSE, FALSE, FALSE, 1, 53),
(52, 'Osztálytermi helyzet: visszajelzés', NULL, 'szeminariumi_terem.png', FALSE, FALSE, FALSE, 3, NULL),
(53, 'Osztálytermi helyzet: visszajelzés', 'Ismerve a hallgatóimat arra gondoltam, hogy legjobb módszer a tanulási tapasztalataik felmérésére a következő lenne: ', 'szeminariumi_terem.png', FALSE, FALSE, FALSE, 3, NULL),
(54, 'Megint összeül az innovációs projektcsapatunk, hogy értékeljük a pilot eddigi tapasztalatait. Először egy körkérdéssel kezdünk: ki hogyan látja fejlődését az oktatási innovációk kapcsán. Te mennyire vagy elégedett?', NULL, 'teamules.png', FALSE, FALSE, FALSE, 3, NULL),
(55, 'Miben szeretnél fejlődni?', NULL, 'hedgie_terulo.png', FALSE, FALSE, FALSE, 3, NULL),
(56, 'Egy kolléga önreflexió kapcsán a következőt javasolja:', 'Ha úgy érzed, az önreflexióban még fejlődnöd szükséges, akkor érdemes amellett, hogy te is elemzed a tanításod, újításaid, a kollégáktól és hallgatóktól is rendszeresen visszajelzést kérned. Talán próbáld meg magad számára is még pontosabban tisztázni, hogy mit akarsz elérni a tanítás során, s ehhez kötődően elemezd a tapasztalataid. ', 'folyoso_interakcio02.png', FALSE, FALSE, FALSE, 1, 61),
(57, 'Egy kolléga kezdeményezőkésszég kapcsán a következőt javasolja:', 'A kezdeményezőkészségben szerintem igen nehéz erősödni, én általában elég bizonytalan vagyok, hogy jó ötletet, irányt vetek fel. De arra szoktam gondolni, hogy általában annyi probléma és kihívás merül fel az oktatásban, hogy szinte bármilyen ötlet csak jobbá teheti az oktatást, csak az a lényeg, hogy a megvalósítás előtt azért sok visszajelzést gyűjtsünk, és próbáljunk a várt hatásoknak kicsit jobban utána olvasni.', 'folyoso_interakcio02.png', FALSE, FALSE, FALSE, 1, 61),
(58, 'Egy kolléga csapatjáték, együttműködés kapcsán a következőt javasolja:', 'A karrierem elején én sokat szenvedtem attól, hogy a csoportos munkát nagyon nem találtam hatékonynak. De aztán elkezdtem azt figyelni, hogy mi az, amit a kollégám jobban tud, mint én, mi az, amit tanulhatok tőle. Ez segített abban, hogy ne az idegesítő tulajdonságaira figyeljek, és hogy tudjunk koncentrálni a közös feladatra.', 'folyoso_interakcio02.png', FALSE, FALSE, FALSE, 1, 61),
(59, 'Egy kolléga pedagógiai felkészültség kapcsán a következőt javasolja:', 'Ha úgy érzed, a pedagógiai felkészültségedben még fejlődnöd kéne, akkor érdemes lenne megnézned egy-két oktatói útmutatót akár a kurzus tervezése, módszerek használata vagy értékelés kapcsán! Én amellett, hogy a mi egyetemünk oktatásmódszertani központjának honlapját szoktam nézni, az általam meghatározónak tartott egyetemek oktatói anyagait is át szoktam futni.', 'folyoso_interakcio02.png', FALSE, FALSE, FALSE, 1, 61),
(60, 'Egy kolléga kreativitás kapcsán a következőt javasolja:', 'Mi a tanszéken rászoktunk arra, hogy gyűjtjük a legkülönfélébb innovatív tanítási ötletet, amit aztán havonta átnézünk, kiegészítünk, és néhányat közösen is felkarolunk, és elkezdünk megvalósítani. Engem felszabadított, hogy nem kellett időre ötletelnem, hanem lehetőségem volt, bármikor felírnom valamit, amikor eszembe jutott.', 'folyoso_interakcio02.png', FALSE, FALSE, FALSE, 1, 61),
(61, 'Teamülés', 'Térjünk át a hallgatók visszajelzéseire, milyen adatokra építsünk az értékelés során?', 'teamules.png', FALSE, FALSE, FALSE, 3, NULL),
(62, 'OMHV statisztikai adatok​', 'Az egyetemi Oktatói Munka Hallgatói Véleményezése​ (OMHV) rendszerben összegzett adatok az új megoldásokat alkalmazó kurzusokról. Az előző három tanév átlaga vs. aktuális adatok: ​

 Az oktató módszerével elégedett: 53% / 72%. ​

 Mennyire volt interaktív a foglalkozás: 13% / 51%.​

 A kurzus oktatóját ajánlaná-e hallgatótársainak: 69% / 83%. ​', NULL, FALSE, FALSE, FALSE, 1, 63),
(63, 'OMHV szöveges válaszok​', 'Az OMHV rendszerben rögzített szöveges válaszok alapján a módszerbéli változásokat a hallgatók túlnyomó többsége kedvezően értékelte. Kiemelték a módszerek változatos alkalmazását, és hogy nem csak a felületes tudás megszerzését támogatják, hanem gyakran gondolkodásra is késztetnek. A digitális eszközök használata problémamentessé, gördülékennyé vált, időveszteséget nem okozott. A hallgatók egy kisebb csoportja a kurzust módszertani szempontból változatlanul alacsonyabb pontszámmal értékelte, miközben szövegszerű válaszában nem tért ki ennek érdemi magyarázatára. ​', NULL, FALSE, FALSE, FALSE, 1, 66),
(64, 'Hallgatói visszajelzések ​', 'Az órákon és a szünetekben elhangzott hallgatói vélemények szerint jó irányban változott/tak a kurzus/ok. A módszerek jobban támogatják a komplexebb kérdések feldolgozását, a tananyag összefügéseinek átgondolását. A digitális eszközök jól működnek. A lényegesen több interaktivitás érdekessé teszi az órákat. „Tök jó a hangulat, és végre izgalmas kérdésekről is beszélünk." Kevesebb a stressz, amit korábban a kvíznél alkalmazott időmérés okozott. Elhangzott néhány jobbító javaslat. Mivel az órai interaktivitás időigényesebb, előfordul, hogy nem mindenre jut egyformán idő, és egyes részekkel a korábbinál többet kell otthoni foglalkozni. Egyeseknek problémát okoz, hogy az interaktív órák folyamatos lépéstartást, felkészülést igényelnek minden héten, amit nem mindig tudnak megvalósítani, és ez számukra újabb stressz forrása lehet. ', 'hangsav.png', FALSE, FALSE, FALSE, 1, 66),
(65, 'Hallgatói visszajelzések ​', 'Az órákon és a szünetekben elhangzott hallgatói vélemények szerint jó irányban változott/tak a kurzus/ok. A módszerek jobban támogatják a komplexebb kérdések feldolgozását, a tananyag összefügéseinek átgondolását. A digitális eszközök jól működnek. A lényegesen több interaktivitás érdekessé teszi az órákat. „Tök jó a hangulat, és végre izgalmas kérdésekről is beszélünk." Kevesebb a stressz, amit korábban a kvíznél alkalmazott időmérés okozott. Elhangzott néhány jobbító javaslat. Mivel az órai interaktivitás időigényesebb, előfordul, hogy nem mindenre jut egyformán idő, és egyes részekkel a korábbinál többet kell otthoni foglalkozni. Egyeseknek problémát okoz, hogy az interaktív órák folyamatos lépéstartást, felkészülést igényelnek minden héten, amit nem mindig tudnak megvalósítani, és ez számukra újabb stressz forrása lehet. ', 'hangsav.png', FALSE, FALSE, FALSE, 1, 62),
(66, 'A beérkezett adatok alapján mit javasolsz a teamnek a továbblépéshez? ', NULL, NULL, FALSE, FALSE, FALSE, 3, NULL),
(67, 'A team végül a kis változtatások és a pilot terjesztése mellett döntött. Kinek, miként mutassuk be a fejlesztés eredményeit? ', NULL, 'teamules.png', FALSE, FALSE, FALSE, 3, NULL),
(68, 'Eltelt egy év…', 'Te éppen egy felsőoktatási webináriumon veszel részt, ahol lehetőséget kaptál, hogy bemutathasd a Stundentaria Karon folyó oktatási innováció történetét.', NULL, FALSE, FALSE, TRUE, 1, NULL);

INSERT INTO choices (id, situation_id, choice_text, next_situation_id, delta_energy, delta_selfreflection, delta_competency, delta_initiative, delta_creativity, delta_cooperation, delta_motivation) VALUES
(1, 3, 'Igen, kezdjük!', 4, -1, NULL, -1, NULL, NULL, NULL, NULL),
(2, 3, 'Még nincs elég információnk.', 5, NULL, NULL, 1, 1, NULL, NULL, NULL),
(3, 3, 'Nincs idő most ezzel foglalkozni.', 6, -2, -1, NULL, -1, NULL, NULL, NULL),
(4, 6, 'Kérdőív', 7, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(5, 6, 'Külső szakértővel beszélgetés', 8, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(6, 6, 'Fókuszcsoportos interjú', 9, -1, NULL, 1, NULL, 1, NULL, NULL),
(7, 6, 'Pilot csoport oktatóival közös diagnosztizálás ', 10, -1, NULL, 1, NULL, NULL, 1, NULL),
(8, 11, 'Oké, csináljunk még egy felmérést! ', 11, -1, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 11, 'Most már kezdjünk bele a fejlesztésbe, elég információnk van a hallgatói fogadtatásról', 12, NULL, 1, NULL, 1, NULL, NULL, NULL),
(10, 12, 'Egy típusú kvízt mélyítsünk, használjunk többféleképpen', 13, NULL, NULL, -1, NULL, -1, NULL, NULL),
(11, 12, 'Egy másik online eszközt vonjunk be - mondjuk a Mekpit ', 13, NULL, NULL, -1, NULL, -1, NULL, NULL),
(12, 12, 'Ne legyen online kvíz, mindenki csinálja azt, ami nála bevált ', 13, NULL, NULL, -1, -1, NULL, -1, NULL),
(13, 13, 'Sajnos, elakadtunk, talán túlzottan az online kvízekben mélyültünk el, és emiatt kevésbé állt össze, hogy mit lenne érdemes változtatnunk a kurzusainkban, hogy tényleg javuljon a hallgatói elégedettség. Ráadásul mindjárt kifutunk az időből, kezdődik a következő félév.', 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 14, 'Milyen jó, hogy beszélünk. Pont egy konferencián találkoztam Horváth Gábor oktatóval, aki az egyetemen már majdnem 10 éve lelkesen foglalkozik oktatásfejlesztéssel. Megkérem, hogy jöjjön el és tartson nekünk egy workshopot!', 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 15, 'Szakértői mozaik', 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 15, 'Gamifikáció', 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 15, 'Fogalomtérkép', 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 15, 'Vitapingpong', 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 15, 'Online csoportmunka ', 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 15, 'Kutatás', 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(21, 15, 'Projekt', 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22, 15, 'Szerepjáték', 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(23, 15, 'Hallgatói kiselőadás, prezentáció', 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 16, 'A módszertani csomag', 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(25, 16, 'B módszertani csomag', 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(26, 16, 'C módszertani csomag', 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(27, 18, 'A tematika', 19, NULL, 1, NULL, NULL, NULL, NULL, NULL),
(28, 18, 'B tematika', 19, NULL, -1, NULL, NULL, NULL, NULL, NULL),
(29, 19, 'Igen, fontos a hallgatók tudatos részvétele a fejlesztésben, hiszen ezáltal Önök is fejlődnek. Azért az innovatív módszertant mi ismerjük, tehát ezt nekünk oktatóként kell irányítanunk, de majd többször kérünk Önöktől visszajelzést. ', 20, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(30, 19, 'Tényleg, azon nem is gondolkodtam, hogy a hallgatók innovatív gondolkodásának fejlődéséhez is hozzájárulhatunk ezzel a fejlesztéssel. Szóval tényleg tartsunk egy közös egyeztetést, amikor Önök is ötletelnek arról, hogy mit és hogyan változtassunk a kurzusainkon! ', 20, 1, NULL, 1, 1, NULL, NULL, NULL),
(31, 20, 'Igen', 21, 1, NULL, NULL, NULL, 1, NULL, NULL),
(32, 20, 'Nem', 21, -1, NULL, NULL, NULL, -1, NULL, NULL),
(33, 21, 'Találkozzunk havonta és beszéljük át az addig elért mérföldköveket', 22, -1, 1, 1, NULL, NULL, 1, NULL),
(34, 21, 'Találkozzunk havonta, és minden találkozóra két előre megbeszélt szempont alapján gyűjtsük az információkat a pilot sikerességéről', 22, -1, 2, 1, NULL, NULL, 1, NULL),
(35, 21, 'Találkozzunk havonta, mert fontos a személyes tapasztalatcsere, de a fejlesztés sikerességét csak a félév végén értékeljük', 22, -1, NULL, NULL, NULL, NULL, NULL, NULL),
(36, 21, 'Év közben mindenki annyira elfoglalt, elég, ha a félév végén értékeljük a pilotok sikerességét', 21, -1, NULL, NULL, NULL, NULL, NULL, NULL),
(37, 22, 'Egyszerűen el fogom magyarázni nekik a kurzus elején, hogy milyen újítást terveztem erre a félévre', 23, -1, NULL, 1, 1, NULL, NULL, 2),
(38, 22, 'Nem magyarázok, hanem belehelyezem őket egy általam kitalált „mini szimuláció”-ba, hogy megtapasztalhassák az új tanulási irányt, és megkérem, hogy reflektáljanak erre', 23, -3, NULL, 1, 1, 1, NULL, 4),
(39, 22, 'Csinálok egy rövid felmérést a hallgatók körében a kurzus elején, hogy milyen igényeik vannak a kurzussal kapcsolatban', 23, -2, NULL, 1, NULL, 1, NULL, 3),
(40, 22, 'A legjobb, ha elkezdem az oktatást és majd menet közben megértik a hallgatók, hogy mi változott', 22, -1, NULL, NULL, NULL, NULL, NULL, NULL),
(41, 23, 'Az innovációra szánt idő miatt felborul az órák ütemezése. Kicsúszom az időből, nem tudom befejezni az órát. ', 24, -1, 1, NULL, NULL, NULL, NULL, NULL),
(42, 23, 'Mindig van valamilyen technikai probléma, nem minden hallgatónál működik az internet, a QR kód beolvasással is adódnak gondjaik ', 24, -1, 1, NULL, NULL, NULL, NULL, NULL),
(43, 23, 'Hiába épül az új módszer a hallgatók aktivitására, a hallgatók nem elég konstruktívak. Van, aki nem figyel. Vagy az is lehet, hogy nem tudja követni az órát. ', 24, -1, 1, NULL, NULL, NULL, NULL, NULL),
(44, 23, 'Elbizonytalanodtam az új módszerrel kapcsolatban, nem érzem elég tapasztaltnak magam a használatához. ', 24, -1, 1, NULL, NULL, NULL, NULL, NULL),
(45, 23, 'Hiába terveztem meg gondosan az új tanulási tevékenységeket, a hallgatóknak csak az számít, hogy minél gyorsabban meglegyen az eredmény! ', 24, -1, 1, NULL, NULL, NULL, NULL, NULL),
(46, 23, 'Bár a hallgatók igényeire szabtam a kurzust, most mégis inkább azt mondják, hogy kevesebb energiát szeretnének befektetni a kurzus elvégzése során. ', 24, -1, 1, NULL, NULL, NULL, NULL, NULL),
(47, 23, 'A hallgatók nem aktívak, nem vesznek részt az új feladatokban, néhány elutasítják az új feladatokat ', 23, -5, NULL, NULL, NULL, NULL, NULL, NULL),
(48, 24, 'Segítséget kérek mentoromtól, tapasztalt kollégámtól', 39, -1, 1, NULL, NULL, NULL, 1, NULL),
(49, 24, 'Áttanulmányozom a releváns szakirodalmat, jó tanácsokat.', 31, -1, 1, 1, NULL, NULL, NULL, NULL),
(50, 24, 'Megkérem a mentorom, akiről tudom, hogy fontos neki az aktív tanulás, hogy hospitálhassak egy óráján', 25, -1, NULL, NULL, NULL, NULL, NULL, NULL),
(51, 24, 'A fejlesztő csapatból megkérem az egyik kollégám, hogy jöjjön be hospitálni az órámra', 28, -1, NULL, NULL, NULL, NULL, NULL, NULL),
(52, 24, 'Még várok. Majd kialakul magától, hogy megszokjuk az új helyzetet, a hallgatók is, én is', 24, -5, NULL, NULL, NULL, NULL, NULL, NULL),
(53, 25, 'Építek a már mások által kipróbált előzetes szempontrendszerre, de azt kiegészítem a kari fejlesztésünk szempontjaival', 26, -1, 1, 1, NULL, NULL, NULL, NULL),
(54, 25, 'Egy már mások által használt, előzetesen kialakított általános szempontrendszert viszek be a hospitáláshoz', 27, -2, 1, 1, NULL, 1, NULL, NULL),
(55, 25, 'Nyitottan megyek be az órára, nem használok előzetes szempontsort, majd minden fontosat lejegyzetelek', 25, -5, NULL, NULL, NULL, NULL, NULL, NULL),
(56, 28, 'Egy már mások által használt, előzetesen kialakított általános szempontrendszert adok az óralátogatáshoz', 29, -1, 1, 1, NULL, NULL, NULL, NULL),
(57, 28, 'Építek a már mások által kipróbált előzetes szempontrendszerre, de azt kiegészítem a kari fejlesztésünk szempontjaival és arra kérem a kollégát, hogy erre jelezzen vissza', 30, -2, 1, 1, NULL, 1, NULL, NULL),
(58, 28, 'Nem adok előzetes szempontokat, kérem, hogy minden fontosat figyeljen meg és jelezzen vissza nekem', 28, -5, NULL, NULL, NULL, NULL, NULL, NULL),
(59, 38, 'megyek órát tartani', 39, -1, NULL, 1, NULL, 1, NULL, NULL),
(60, 38, 'Megkérem a mentorom, akiről tudom, hogy fontos neki az aktív tanulás, hogy hospitálhassak egy óráján', 25, -1, NULL, 1, 1, 1, NULL, NULL),
(61, 38, 'A fejlesztő csapatból megkérem az egyik kollégám, hogy jöjjön be hospitálni az órámra', 28, -1, NULL, 1, 1, 1, NULL, NULL),
(62, 40, 'Felajánlok egy online konzultációs időpontot, ahol a hallgatók kérdezhetnek és személyre szabott válaszokat adok.', 41, -3, 1, 1, 1, 1, NULL, 6),
(63, 40, 'Kitolom a határidőt egy héttel, aki meg már beadta, ő javíthat. ', 41, -1, NULL, NULL, 1, NULL, NULL, 1),
(64, 40, 'Nem módosítom a követelményeket, de a típushibákat kiemelem, ismét megmutatom a helyes megoldást és a forrásokat, ahol utána tudnak nézni.', 41, -2, 1, 1, 1, NULL, NULL, 3),
(65, 40, 'Talán nem egyértelműen fogalmaztam meg az értékelési szempontokat, ezért ezeket újra átbeszélem a hallgatókkal', 41, -2, 1, 1, 1, NULL, NULL, 4),
(66, 40, 'Következő alkalommal újból bemutatom az órámhoz tartozó online felületet', 41, -1, NULL, 1, 1, NULL, NULL, 1),
(67, 41, 'Az órán jelzem, hogy a legtöbben sikeresen oldják meg az otthoni feladatokat. Akiknél még látok problémát, nekik az online felületen fogok személyesen visszajelezni. ', 42, -2, 1, NULL, 1, 1, NULL, 6),
(68, 41, 'A következő órán jelzem a hallgatók felé, hogy jobban sikerültek a feladataik, megérte közösen tisztázni. ', 42, -2, 1, NULL, 1, NULL, NULL, 4),
(69, 41, 'A következő óra előtt pár perccel hamarabb érek a teremhez, és a folyosón találkozom a hallgatókkal, az óra előtt megdicsérem őket, hogy most már jobbak a feladatmegoldásaik.', 42, -1, 1, NULL, NULL, NULL, NULL, 1),
(70, 41, 'Évek óta ezzel az anyaggal, ebben az ütemben, ezen tematika szerint dolgozom a hallgatókkal. Most hogy még egyszer el is magyaráztam a feladatokat, én már mást nem mondok a hallgatóknak. Ennek elégnek kell lennie. ', 41, -5, NULL, NULL, NULL, NULL, NULL, NULL),
(71, 43, 'Picit tartottam a változtatástól, de talán feleslegesen izgultam, mert nálam minden szuperül megy! Amit nem értettek elsőre, azt megbeszéltük, így most elégedett vagyok.', 44, -1, NULL, NULL, NULL, NULL, NULL, NULL),
(72, 43, 'Sajnos nálam korántsem ilyen rózsás a kép. Folyamatosan volt problémám, az elején egyáltalán nem voltak aktívak a hallgatók az új feladatokban, de folytattam az innovációt. Nem adom fel, minden órán próbálkozom az újítás egy elemével.', 44, -1, 1, NULL, 1, 1, NULL, NULL),
(73, 43, 'Képzeljétek, én meg a félév során jöttem rá, hogy nem értik a hallgatók, hogy mit akarok, nem jó feladatokat találtam ki, nem azt gyakorolták vele, amit fejleszteni akartam. Bízom benne, hogy még időben alakítottam át a beadandó otthoni feladatot, és az értékelési szempontokat is. ', 44, -1, 1, 1, 1, 1, 1, NULL),
(74, 46, 'Igen', 47, -1, NULL, NULL, 1, NULL, 1, NULL),
(75, 46, 'Nem', 48, -1, NULL, NULL, NULL, NULL, NULL, NULL),
(76, 47, 'Javaslom neki, hogy lépjen ki a teamből.', 48, -1, NULL, NULL, 1, NULL, NULL, NULL),
(77, 47, 'Megkérem a pilot projekt team vezetője, hogy intézkedjen.', 48, -3, 1, NULL, 1, 1, 1, NULL),
(78, 47, 'Kezdeményezem, hogy gondoljuk újra a terhelhetőségünket és az előttünk...', 48, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(79, 47, 'Felajánlom, hogy segítek, mentorálom abban, amire szüksége van.', 48, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(80, 48, 'Kihasználom promóciós helyzetnek: meghívom a külföldi vendégeket...', 49, -4, 1, 1, 1, 1, 1, 4),
(81, 48, 'A kertben, hallgatói közösségi térben tartom meg az órát.', 49, -3, NULL, NULL, 1, 1, NULL, 3),
(82, 48, 'Online tartom az órát', 49, -2, NULL, NULL, 1, 1, NULL, 1),
(83, 48, 'Elmarad az órám, addig is tudok kutatni', 49, -1, NULL, NULL, NULL, NULL, NULL, -2),
(84, 49, 'Még sok téma maradt, amit meg kell beszélni, folytatom a kurzust, ahogy eddig', 50, -1, 1, NULL, 1, NULL, NULL, 1),
(85, 49, 'Az utolsó órát a hallgatói munka és az innovációs elemek értékelésére használom...', 52, -1, 1, 1, NULL, 1, NULL, 1),
(86, 49, 'Tudom, hogy kellene visszajelzést gyűjteni és adni is a hallgatóknak...', 51, -3, NULL, NULL, NULL, NULL, NULL, NULL),
(87, 50, 'Ha ennyire fontosnak tartják, jó, akkor kitérünk rá az órán.', 54, -1, 1, NULL, NULL, 1, NULL, 2),
(88, 50, 'Nem beszélek róla, mindenki látja a jegyét az online platformunkon, a Kleopátra-rendszerben', 54, -1, NULL, NULL, NULL, NULL, NULL, -2),
(89, 52, 'A félév végén most szeretném az egész csoport munkáját értékelni. Ehhez nézzük meg a tematikában megjelölt célokat! A kurzushoz kötődő hat fő tanulási eredmény kapcsán látható, hogy a csoport egésze egyértelmű fejlődést mutat négy esetében, egy területen stagnálását látok, nem fejlődött a csoport és egy területen pedig nagyon változatos eredmények születtek. Az egyik legjelentősebb fejlődést a hallgatói együttműködés, közös problémamegoldás területén láttam, azok a csoportok, akik az elején az órákon a segítségemmel is nehezen találták ki, hogy hogyan fognak együtt dolgozni, kinek mi lesz a feladata, milyen határidőket adjanak, a félév végére már az általuk létrehozott online felületen hetente maguk osztották ki a feladatokat, forgórendszerben ellenőrizték a feladatok megfelelő szinten történő elvégzését. Csak gratulálni tudok ehhez a csapatoknak! Ez már olyan, amit egy munkahelyi főnök is elismerne! Ha tovább nézzük…', 54, -1, 1, 1, NULL, NULL, NULL, 2),
(90, 52, 'Most az óra elején csoport szintjén értékelem a hallgatói fejlődést, munkát. Majd az óra végén egy 30 percet arra is szánok, hogy aki szeretne egyénileg is kérdezni a féléves munkájáról, fejlődéséről, azzal röviden ezt meg tudom beszélni személyre szabottan. Kérem, figyeljenek arra, hogy konkrét kérdésekkel jöjjenek, hogy ezzel is hatékonyabbá tehessük a megbeszélést, s így mindenkire sor kerüljön, aki egyéni szinten is kíváncsi a visszajelzésemre.', 54, -2, 1, NULL, NULL, NULL, NULL, 3),
(91, 52, 'A félév végén most szeretném, ha közösen értékelnénk az egész csoport munkáját. Ehhez kérem, hogy nézzük meg a tematikában megjelölt célokat. Először Önöket kérem, hogy gondolják át, mit tanultak, miben fejlődtek, majd én is szeretném összegezni az általam tapasztaltakat.', 53, -2, 1, NULL, 1, 1, 1, 5),
(92, 53, 'a félév közepén kapott hallgatói visszajelzést hozom, miután kérem, hogy most is jelezzenek vissza, arról beszélgetünk, hogyan változtak a tapasztalataik', 54, -2, 1, NULL, 1, 1, 1, 5),
(93, 53, 'egy QR-kód segítségével egy online kérdőívet töltetek ki velük, aminek eredményeit utána közösen meg tudjuk beszélni', 54, -2, 1, NULL, 1, 1, 1, 3),
(94, 53, 'beszélgetek a hallgatókkal az innovációval kapcsolatos tapasztalataikról', 54, -1, 1, NULL, NULL, NULL, 1, 2),
(95, 54, 'igen, elégedett vagyok', 61, -1, NULL, NULL, NULL, NULL, NULL, 1),
(96, 54, 'alapvetően elégedett vagyok, de szeretnék még tovább fejlődni az oktatási innovációkban', 55, -1, 1, NULL, 1, NULL, NULL, 2),
(97, 54, 'nem vagyok elégedett az oktatási innováció eredményeimmel, szeretnék még tovább fejlődni', 55, -1, 1, NULL, 1, NULL, NULL, 1),
(98, 55, 'önreflexió', 56, -1, 1, NULL, NULL, NULL, NULL, NULL),
(99, 55, 'kezdeményezőkészség', 57, -1, NULL, NULL, 1, NULL, NULL, NULL),
(100, 55, 'csapatjáték, együttműködés', 58, -1, NULL, NULL, NULL, NULL, 1, NULL),
(101, 55, 'pedagógiai felkészültség', 59, -1, NULL, 1, NULL, NULL, NULL, NULL),
(102, 55, 'kreativitás', 60, -1, NULL, NULL, NULL, 1, NULL, NULL),
(103, 61, 'Hasonlítsuk össze a kurzusok adatait korábbi kurzusokkal és a OMHV adatok alapján elemezzük a változásokat!', 62, -1, 1, NULL, NULL, NULL, 1, 2),
(104, 61, 'Elemezzük az órán gyűjtött hallgatói visszajelzéseket. ', 64, -1, 1, NULL, NULL, 1, 1, 2),
(105, 61, 'Végezzük el mindkettőt!', 65, -2, 2, NULL, NULL, NULL, 2, 4),
(106, 66, 'kis változtatásokkal csináljuk tovább, de vonjunk be egyre több kollégát!', 67, -2, 1, NULL, 1, NULL, 1, 4),
(107, 66, 'Még nem annyira sikeres a pilotunk, hogy más kollégáknak is tudjuk ajánlani a karon az új megoldásokat', 67, -3, NULL, NULL, 1, NULL, 1, 3),
(108, 66, 'Nem kell változtatnunk semmin, most már mindenki tudja maga is folytatni, amit közösen elkezdtünk.', 67, -1, NULL, NULL, NULL, NULL, NULL, NULL),
(109, 67, 'csak Lehet Péternek', 68, -1, NULL, NULL, NULL, NULL, NULL, 1),
(110, 67, 'Lehet Péter és intézeti értekezleteken', 68, -1, NULL, NULL, NULL, NULL, 1, 3),
(111, 67, 'Lehet Péter és intézetvezetők', 68, -1, NULL, NULL, NULL, NULL, NULL, 2),
(112, 67, 'informális beszélgetések', 68, -1, NULL, NULL, NULL, NULL, 1, 2),
(113, 67, 'egyetemi vagy kari innovációs napon', 68, -1, 1, NULL, NULL, 1, NULL, 2),
(114, 67, 'gólyatábor', 68, -1, NULL, NULL, NULL, 1, 1, 3),
(115, 67, 'konferencián', 68, -1, 1, NULL, NULL, 1, NULL, 1);

-- Add circular references
ALTER TABLE situations 
ADD CONSTRAINT fk_situations_next 
FOREIGN KEY (next_situation_id) REFERENCES situations(id);

-- Fix sequences
CREATE SEQUENCE situations_id_seq;
ALTER TABLE situations ALTER COLUMN id SET DEFAULT nextval('situations_id_seq');
SELECT setval('situations_id_seq', (SELECT MAX(id) FROM situations));

CREATE SEQUENCE choices_id_seq;
ALTER TABLE choices ALTER COLUMN id SET DEFAULT nextval('choices_id_seq');
SELECT setval('choices_id_seq', (SELECT MAX(id) FROM choices));

COMMIT;