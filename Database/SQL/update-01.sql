UPDATE situations
SET situation_text = $$
Az egyetemi OMHV rendszerben összegzett adatok az online kvíz módszert alkalmazó kurzusokról. Az előző három tanév átlaga vs. a módszer bevezetése után:
– Az oktató módszerével elégedett: 53% / 34%.
– Mennyire volt interaktív a foglalkozás: 13% / 21%.
– A kurzus oktatóját ajánlaná-e hallgatótársainak: 69% / 61%.
Szöveges válaszok:
Az OMHV rendszerben rögzített szöveges válaszok szerint az online kvíz módszert a hallgatók többsége kezdetben pozitívan fogadta, értékelve annak játékos elemeit. Később azonban előjöttek a korlátok is. A kvíz állandó ismételgetése minden órán előbb unalmassá, később pedig sokak számára terhessé vált:
„Hiába mások a kérdések, tök unalmas mindig ugyanazt a játékot gyúrni.”
Előfordult, hogy az internet kapcsolat nem volt elég stabil az online kvíz zökkenőmentes lejátszásához, vagy más technikai probléma lépett fel, így az a tervezettnél sokkal több időt vett igénybe:
„Kínos volt a hiba hosszas keresgélése, miközben rengetek dolgunk lett volna. Amatőrök.”
A hallgatók visszajelzései szerint az eszköz nem alkalmas komplexebb kérdések megfogalmazására, így a tananyag lényeges területei a kvíz számára érintetlenek maradtak:
„A kvízből keveset tanulunk, mert képtelen az alapfogalmaknál mélyebbre menni.”
Egyeseket zavart az is, hogy a válaszadás gyorsasága is fontos a játékban, mivel az ilyenfajta gyorsaság nem kiemelt szakmai követelmény:
„Idegesít az időmérés, nem szeretek kapkodni, stresszel. Szerintem ez nem lóverseny. Vagy mégis?”
$$
WHERE id = 2;

UPDATE choices
SET next_situation_id = 6
WHERE id = 2;

UPDATE choices
SET next_situation_id = 5
WHERE id = 3;