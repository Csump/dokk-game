# Deployment

Jelen dokumentum a deployment folyamatát ismerteti.

1. Lokális image build

Futtasd az alábbi parancsot a projekt `Game` könyvtárában:

```bash
docker build -t dokk-game:latest .
```

Ellenőrizd, hogy létrejött-e az image:

```bash
docker images
```

2. Docker image exportálása

A parancs egy `.tar` fájlba fogja csomagolni a projektet. A `VERSION` helyére a tényleges verziószám kerüljön!

```bash
docker save dokk-game:latest -o dokk-game-VERSION.tar
```

3. Image átmásolása az ELTE szerverrére

A parancs a `.tar` fájlt a `misc` könyvtárba fogja másolni.

```bash
scp -i C:\Users\Csump\.ssh\elte "C:\Users\Csump\source\repos\dokk-game\Game\dokk-game-VERSION.tar" strygm_manager@docker-prod2.caesar.elte.hu:~/misc/
```

4. Belépés az ELTE szerverére

Belépés előtt csatlakozni kell az ELTE VPN-jére. További előfeltételek az [adatbázis dokumentációjában](database.md) találhatók.

```bash
ssh -i .\.ssh\elte strygm_manager@docker-prod2.caesar.elte.hu
```

5. Image betöltése az ELTE szerveren

```bash
cd misc
docker load -i dokk-game-VERSION.tar
```

6. Konténerindítás

Konténerindítás a szükséges portkötéssel:

```bash
docker run -d --name dokk-game-VERSION -p 10070:10070 dokk-game:latest
```

7. Ellenőrzés

Futó konténer ellenőrzése (itt szerepelnie kell egy `dokk-game` nevű konténernek):

```bash
docker ps
```

Logok megtekintése:

```bash
docker logs dokk-game-VERSION
```

Lokális HTTP ellenőrzés a szerveren:

```bash
curl http://localhost:10070
```

8. Éles környezet ellenőrzése

Amennyiben a fenti lépések sikeresen lefutottak, és a konténer hibamentesen fut, az nginx reverse proxy már az újonnan telepített verzióra irányítja a forgalmat.

Az alkalmazás ezután az éles környezetben is elérhető az alábbi címen:

[https://hedgie.elte.hu/](https://hedgie.elte.hu/)

Ha az oldal megfelelően betölt és az elvárt verzió működik, a deployment sikeresnek tekinthető.

