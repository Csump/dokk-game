namespace Game.Models;

public class Evaluation
{
    public static string GetEvaluation(StatType statType, EvaluationLevel level)
    {
        return statType switch
        {
            StatType.SelfReflection => level switch
            {
                EvaluationLevel.Good =>
                    "Az önreflexió területén sok pontot szereztél, ami azt mutatja, hogy oktatói gondolkodásod szerves részét képezi az önreflexió, nyitott vagy rá és rendszeresen gondolkozol a saját tanítási-tanulási folyamatodról, keresed és megtalálod ehhez a megfelelő pillanatokat és eszközöket. Gratulálunk, jó példa lehetsz mások számára is.",

                EvaluationLevel.Average =>
                    "Az önreflexió területén gyűjtött pontjaid alapján nyitott vagy az önreflexióra, de még van ebben fejlődési lehetőség. Nem mindig veszed észre az önreflexióra kínálkozó alkalmakat és/vagy nincsenek meg ehhez a kellő módszereid.",

                EvaluationLevel.Bad =>
                    "Az önreflexió területén kevés pontot gyűjtöttél, ami arra utalhat, hogy ritkábban gondolkozol a saját tanítási - tanulási folyamatodról, inkább a rutinjaidra hagyatkozol. Érdemes lenne nagyobb hangsúlyt fektetni rá, keresni hozzá időt és módszereket!",

                _ => string.Empty
            },

            StatType.Competency => level switch
            {
                EvaluationLevel.Good =>
                    "A pedagógiai felkészültség területén sok pontot szereztél, ami azt mutatja, hogy oktatói gyakorlatodban kellő szintű pedagógiai tudással és a tanuláshoz megfelelő motivációval rendelkezel. Rendszeresen és következetesen használod pedagógiai tudásod a hallgatói tanulás támogatására és az innovatív megoldások kialakításához. Biztatunk arra, hogy kollégáiddal is bátran oszd meg jógyakorlataid, pedagógiai ötleteid akár konferenciákon, publikációk formájában!",

                EvaluationLevel.Average =>
                    "A pedagógiai felkészültség területén gyűjtött pontjaid alapján nyitott vagy a felsőoktatás-pedagógia területére és vannak már releváns ismereteid a erről. Jó úton jársz, de tudásodat érdemes még újabb szakirodalmakkal bővíteni és ezeket érdemes a mindennapi oktatási gyakorlatodban is tudatosan alkalmazni. Ezáltal a gyakorlatod eredményességét is növelheted.",

                EvaluationLevel.Bad =>
                    "A pedagógiai felkészültség területén kevés pontot gyűjtöttél, ami arra utalhat, hogy kevésbé tartod fontosnak a pedagógiai kérdésekben való elmélyülést. Fontos lenne jobban kihasználnod a felsőoktatás-pedagógiai terület adta lehetőségeket, információkat és tapasztalatokat gyűjteni kollégáktól, a tudományterület szakirodalmának megismerésével.",

                _ => string.Empty
            },

            StatType.Initiative => level switch
            {
                EvaluationLevel.Good =>
                    "A kezdeményezőkészség területén sok pontot szereztél, ami azt mutatja, hogy felismered a változtatásra alkalmas helyzeteket, aktívan mozgósítod magad körül a kreatív embereket és az ötletek megvalósítóit is, továbbá nagy biztonsággal hozol meg olyan döntéseket, amelyek pozitív változásokat indítanak el az oktatásban. Agilis hozzáállásod olyan érdemi folyamatokat katalizálhat, melyek nélküled talán nem valósulnának meg, de ha az élre állsz, mások számára is teret nyitsz. Csak így tovább! ",

                EvaluationLevel.Average =>
                    "A kezdeményezőkészség területén gyűjtött pontjaid alapján felismered a változtatásra alkalmas helyzeteket, és hajlamos vagy megosztani az ötleteidet másokkal, akik kreativitásukkal vagy a megvalósításban hasznodra lehetnek. Nem zárkózol el olyan döntések meghozatalától, amelyek pozitív változásokat indítanak el az oktatásban. Jó alapokkal rendelkezel, csak talán esetleges még, hogy a benned rejlő kezdeményezőkészségnek adsz-e teret vagy sem, amit a környezeted is változóan fogadhat. Érdemes elmélyítened magadban azokat a kezdeményezéseidet, melyekben sikerélményt éltél át. Segítséget jelenthet az is, ha biztonságos környezetet alakítasz ki magad körül, ahol annak az érzésnek is van helye, hogy nem minden kezdeményezésből lesz végül valami, sőt!",

                EvaluationLevel.Bad =>
                    "A kezdeményezőkészség területén kevés pontot gyűjtöttél, ami arra utalhat, hogy ha felismered is a változtatásra alkalmas helyzeteket, nem azonosítod a körülötted lévő emberek közt azokat, akik kreativitásukkal vagy az ötletek megvalósításában támaszkodhatnál. Kevéssé bízol abban, hogy ötleteid érdemi pozitív változásokat indítanak el az oktatásban, vagy hogy megérné a befektetett energia. (Érdemes lenne megfigyelned, hogy egyéb helyzetekben kikben látsz magad körül kreativitást, és kiket tartasz erősnek a dolgok megvalósításában.) Talán kellemes meglepetésben lesz részed, ha a megfelelő környezetben ötleteiddel mások számára is teret nyitsz, hiszen bevonódásukkal téged is megerősítenek abban, hogy érdemes kezdeményezned.",

                _ => string.Empty
            },

            StatType.Creativity => level switch
            {
                EvaluationLevel.Good =>
                    "A kreativitás területén sok pontot szereztél, ami azt mutatja, hogy képes vagy több oldalról is megközelíteni a dolgokat, és ugyanabból a kiindulópontból egymástól akár teljesen eltérő megoldásokra is jutni. Rugalmasan váltogatod a nézőpontokat, és szívesen játszol el ugyanazzal a gondolattal egynél több nekifutásból. Ez nagy szabadságot és magabiztosságot adhat saját oktatói gyakorlatodban, ami mások számára is inspiráló. Kreativitásod több ponton is fontos szereplővé tehet egy innovációs folyamatban. Használd ki a lehetőségeket, amikor megmutathatod a kreativitásod olyan kollégák számára, akik esetleg más kompetenciaterületeken erősebbek, mert nagyon jól kiegészíthetitek egymást!",

                EvaluationLevel.Average =>
                    "A kreativitás területén gyűjtött pontjaid alapján képes vagy rugalmasan állni egy oktatási helyzethez, és hajlandó vagy több szempontból megközelíteni a feladatot, még ha ez a komfortzónádból való kilépéssel jár is. Nyitott vagy rá, hogy az innovációs folyamat valamely fázisában eltérj a megszokottól és alternatívákban is gondolkodj.  Érdemes megosztani az ötleteidet olyanokkal, akik új perspektívából inspirálhatnak; illetve az oktatási gyakorlatodban is alkalmazni a nem-szakmai, hétköznapi színterekről szerzett tapasztalataidat, ahol kreatívnak érzed magad.",

                EvaluationLevel.Bad =>
                    "A kreativitás területén kevés pontot gyűjtöttél, ami arra utalhat, hogy hajlamos vagy a dolgokat inkább egy, már ismert módon megközelíteni. Ennek hátrányát leggyakrabban akkor érezheted, amikor valami kizökkent a megszokottból, az oktatási gyakorlatodban korlátozva érzed magad, esetleg túlzott energiát követel tőled vagy egyenesen lehetetlennek tűnik számodra valami. Érdemes megfigyelni, hogy mások milyen megoldásokat alkalmaznak hasonló helyzetekre; esetleg megosztani az ötleteidet olyanokkal, akik új perspektívából inspirálhatnak; illetve azonosítani önmagadban azokat a színtereket, akár hétköznapi példákat, ahol kreatívnak érzed magad.",

                _ => string.Empty
            },

            StatType.Cooperation => level switch
            {
                EvaluationLevel.Good =>
                    "A csapatmunka területén sok pontot szereztél, ami azt mutatja, hogy tudatosan és hatékonyan működsz együtt másokkal egy közös cél elérése érdekében. Kommunikációd nyitott és támogató, aktívan hozzájárulsz a csoport jó légköréhez, figyelsz másokra, és empatikusan reagálsz a csapattagok igényeire. Megbízhatóan és elszámoltathatóan dolgozol, és a felmerülő konfliktusokat konstruktívan, a megoldásra törekedve kezeled. Jó példát mutatsz az együttműködésben, hiszen a csapatod számára te is biztonságos, inspiráló közeget teremtesz. Remek lehet veled csapatban dolgozni!",

                EvaluationLevel.Average =>
                    "A csapatmunka területén gyűjtött pontjaid alapján képes vagy másokkal közösen dolgozni, és nyitott vagy az együttműködésre. Törekszel a közös célok elérésére, kommunikációd alapvetően konstruktív, és igyekszel alkalmazkodni a csapat igényeihez. Ugyanakkor előfordulhat, hogy bizonyos helyzetekben még nehezebben kezeled a véleménykülönbségeket, vagy nem mindig találod meg az egyensúlyt az önálló kezdeményezés és az együttműködés között. Érdemes tudatosan figyelni arra, hogy aktívabban bevond a csapattagokat, illetve nyitottan kezeld a visszajelzéseiket.",

                EvaluationLevel.Bad =>
                    "A csapatmunka területén kevés pontot gyűjtöttél, ami arra utalhat, hogy az együttműködési helyzetekben jelenleg kevésbé érzed komfortosan magad, vagy nehezen találod meg a szereped egy közös cél érdekében működő csoportban. Előfordulhat, hogy inkább az önálló munkát részesíted előnyben, vagy hogy a kommunikáció, alkalmazkodás, illetve konfliktuskezelés terén még van fejlődési lehetőséged. Érdemes tudatosan figyelni arra, hogyan tudnád jobban kihasználni a csapatmunka adta előnyöket, és keresni azokat a helyzeteket, ahol biztonságos környezetben gyakorolhatod a közös döntéshozatalt, empatikus figyelmet és konstruktív párbeszédet.",

                _ => string.Empty
            },

            _ => string.Empty
        };
    }
}
