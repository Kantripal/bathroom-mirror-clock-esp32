# XIAO ESP32-C3 (Seeed), Steckbrief

Stand 06.11.2026. Teil bestellt am 31.10.2026 (Shop RBS18991), geliefert Anfang November, gescannt am 04.11.2026, Stifte gelötet und Firmware aufgespielt am 06.11.2026. Unterlagen (nicht veröffentlicht): Seeed-Schaltplan v1.3, Symbol- und Footprint-Archive, ESP32-C3-Datenblatt Version 2.4 und Shop-Informationsblatt RBS18991.

## Anschlüsse

- **14 Stifte in zwei Reihen zu 7.** Linke Reihe mit USB-Buchse oben, Aufdruck lesbar: Pin 1 = D0 am USB-Ende, dann D1 bis D6. Rechte Reihe: Pin 14 = 5V am USB-Ende, dann GND (13), 3V3 (12), D10 (11), D9 (10), D8 (9), D7 (8). Quelle: `XIAO_Series_SCH_Symbols.zip`; Lage der Pads: `New_XIAO_Series_Footprints.zip`, Footprint `XIAO-ESP32-C3-DIP`.
- **D-Pin zu GPIO** (Schaltplan v1.3 Seite 3, als Bild gelesen): D0 = GPIO2, D2 = MTMS = GPIO4, D3 = MTDI = GPIO5, D4 = MTCK = GPIO6, D5 = MTDO = GPIO7, D8 = GPIO8, D9 = GPIO9, D10 = GPIO10. Nur aus der Pin-Map des Seeed-Wikis (Rechercheur 03.11.2026): D1 = GPIO3, D6 = GPIO21 (TX), D7 = GPIO20 (RX).
- **Strapping-Pins GPIO2, GPIO8, GPIO9** (ESP32-C3-Datenblatt Seite 30, Tabelle 3-1): nicht belegen. Nur GPIO9 hat auf dem Modul 10 kΩ (R6) nach 3,3 V und den BOOT-Taster nach GND (Schaltplan Seite 3); GPIO2 und GPIO8 sind frei. Die Karte des SuperMini nennt dieselben Pins als I2C-Vorgabe, nicht danach verdrahten.
- **GPIO4 und GPIO5 (MTMS, MTDI) treiben nur 10 mA** (Datenblatt Seite 17). Für I2C unerheblich, für eine LED an diesen Pins zu wenig.
- **Pin 14 „5V“ ist der USB-Knoten** vor Sicherung F1 (6 V, 500 mA) und Diode D1 des Moduls (Schaltplan Seite 3). Seeed-Wiki: Einspeisung über diesen Pin nur über eine Diode. Mit gestecktem USB und gleichzeitiger Einspeisung ohne Diode speisen PC und Wandler gegeneinander. Zulässiger Bereich am Pin: oben 5,5 V (Regler TLV75733 laut TI, Rechercheur 03.11.2026; absolut 6 V), unten etwa 3,9 V (gerechnet: 3,3 V plus Dropout plus D1). Hinter einer 1N5819 aus 5,0 V liegen etwa 4,7 V an (Messung).
- **3V3 (Pin 12) ist der Ausgang des Reglers TLV75733**, laut Seeed-Wiki bis 700 mA (Pinbeschreibung) beziehungsweise 500 mA (Datentabelle); die kleinere Zahl gilt bei der Planung.
- **Antenne:** u.FL-Buchse auf der Oberseite am Ende gegenüber der USB-Buchse, mittig zwischen den Tastern B und R (eigenes Foto vom 06.11.2026). Externe Antenne im Lieferumfang: Fläche 40 × 20 mm, Kabel 48 mm vom Stecker bis zum Anfang der Fläche (07.11.2026). Im Gehäuse der Uhr liegt sie innen am Deckel über dem XIAO (`Gehaeuse/gehaeuse.scad`).

## Maße

- Löcher: je 7 im Raster 2,54 mm, Reihenabstand 15,24 mm, Bohrung 0,889 mm (Seeed-Footprint). Auf der Uhr-Platine 1,0 mm, weil die Stifte direkt eingelötet werden (ohne Buchsen, Beschluss vom 01.11.2026).
- **Flachbettscan 04.11.2026 (600 dpi mit Skala, Stück aus Lieferung 8710309):** Raster 2,55 und 2,54 mm, Spannweite über 6 Raster 15,28 und 15,22 mm, Reihenabstand 15,22 mm. Passt zu Seeeds 2,54 und 15,24 mm; der Footprint bleibt bei Seeeds Werten.
- Außenmaß etwa 21 × 17,5 mm (Shopblatt RBS18991 Seite 2). Seeeds Maßzeichnung (`XIAO_ESP32C3_v1.2_Dimensioning.zip`) ist nicht ausgewertet. **Am Teil prüfen, sobald es da ist** (Aufdruck der Unterseite gegen Seite 2 des 1:1-Ausdrucks).
- **Aufdruck der Unterseite am 06.11.2026 gelesen** (eigenes Foto, nicht veröffentlicht): USB-Ende oben, von unten gesehen links VUSB, GND, 3V3, D10, D9, D8, D7, rechts D0 bis D6. Passt zur Pintabelle (VUSB ist Pin 14 „5V“). Dazu Lötflächen BAT + und −, MTDO, MTDI, EN, MTMS, MTCK, GND, RST, Boot; sie bleiben auf der Uhr frei.
- Seeeds eigener Footprint taugt nicht direkt für Aisler: Referenztext 0,635 mm (Aisler verlangt 0,8 mm) und SMD-Felder, darum der eigene Grundriss `Bauteile.pretty/XIAO_C3_Sockel.kicad_mod` nur mit Löchern.

## Löten

Die 14 Stiftleisten-Lötstellen sind die riskanteste Handarbeit der Uhr (Chip und Antennenbuchse liegen daneben). Ablauf im Leitfaden `Leitfaeden/Steckbrett-und-Loeten.md`: Stiftleisten ins Steckbrett stecken, Modul auflegen, je einen Eckstift löten, Sitz prüfen, dann die übrigen, je Stift höchstens etwa zwei Sekunden.

## Firmware

ESPHome `board: esp32-c3-devkitm-1` läuft auf dem XIAO. ESPHome nimmt auf dem C3 ohne Angabe GPIO8 als SDA und GPIO9 als SCL, also Strapping-Pins: `sda:` und `scl:` sind Pflicht. Beim neuen Modul die MAC im Access Point freigeben, falls dort ein MAC-Filter läuft. ESPHome schaltet auf dem esp32 die internen I2C-Pull-ups ein (etwa 45 kΩ, Vorgabe); ein Steckbrett-Test läuft darum auch ohne externe.
