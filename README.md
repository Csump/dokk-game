
# HEDGIE

**Higher Education Game for Innovation Expertise**

A [HEDGIE](hedgie.elte.hu) egy játékosított kutatás, amely egy egyetemi projekt keretében készült. Célja, hogy támogassa az egyetemi oktatókat az innovatív oktatási és döntéshozatali gyakorlatok kipróbálásában egy interaktív narratívába szőtt döntésalapú játékon keresztül.

## A játékról

A HEDGIE egy **döntésalapú narratív játék**, amelyben a játékosok:

- Létrehozzák saját karakterüket
- Különféle szituációkban vesznek részt
- Döntéseket hoznak, amelyek hatással vannak a történet alakulására
- Hét, oktatói kompetenciákat reprezentáló stat mentén követik nyomon fejlődésüket

## Technology stack

- [Blazor](https://dotnet.microsoft.com/en-us/apps/aspnet/web-apps/blazor)
- [.NET 9](https://dotnet.microsoft.com/)
- [Entity Framework Core 9](https://docs.microsoft.com/ef/core/)
- [PostgreSQL](https://www.postgresql.org/)
- [Docker](https://www.docker.com/)

## Projektstruktúra

### Game

Itt található maga a futtatható projekt.

### Database

Adatbáziskezeléssel kapcsolatos fájlok gyűjtőhelye:

- `/CSV`: Nyers adatok `CSV` formátumban.
- `/Scripts`: Python scriptek, amelyek SQL scripteket hoznak létre az adatbázis kezdeti feltöltéséhez.
- `/SQL`: PostgreSQL scriptek.

### Docs

A dokumentációk gyűjtőhelye.

- [Architektúra](Docs/architecture.md): Rendszerarchitektúra
- [Adatbázis](Docs/database.md): Adatbázisséma és kapcsolatok
- [Deployment](Docs/deployment.md): Telepítési és futtatási útmutató
- [Játékmenet](Docs/gameplay-mechanics.md): Játékmenet
- [Szituációtípusok](Docs/situation-types.md): Szituációtípusok bemutatása
- [Funkcionalitás 1.0](Docs/functionality-1.0.md): 1.0-ás release funkcióinak listázása

## Projektinformációk

- **Megbízó**: Eötvös Loránd Tudományegyetem, [DOKK ernyőprojekt](https://www.dokk.elte.hu/)
- **Cél**: Kutatás és kísérletezés a felsőoktatási innováció területén
- **Design**: [Prototípus](https://www.figma.com/proto/FeLllZcCJXRNfm4gJd0oxl/Design?page-id=51%3A251&node-id=73-423&viewport=207%2C555%2C0.14&t=B5gu3U1QlVkSSq0i-1&scaling=min-zoom&content-scaling=fixed&starting-point-node-id=73%3A423), [Figma fájl](https://www.figma.com/design/FeLllZcCJXRNfm4gJd0oxl/Design?node-id=73-423&t=g1UVk37i2pLMocSs-1)

**Tervezők**: *[Ring Noémi](https://www.instagram.com/ringnoemi.psd/)* (illusztrációk), *[Pongrácz Rita](https://linktr.ee/hagyma)* (UI design)
