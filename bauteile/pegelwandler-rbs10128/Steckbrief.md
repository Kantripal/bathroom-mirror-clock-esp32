# Pegelwandler RBS10128 (JY-MCU, 4 Kanäle, eigener 3,3-V-Regler), Steckbrief

Stand 08.11.2026, 3 Stück geliefert am 04.11.2026. Unterlage: Shop-Informationsblatt RBS10128 (nicht veröffentlicht) (Text, Tabelle, ein Foto 300 × 300 Pixel). Zum Vergleich das alte Modul `RBS16466_Pegelwandler-4-Kanal.pdf` (beide Stücke am 31.10.2026 zerstört).

## Was belegt ist

- Shopblatt: vier Kanäle mit vier MOSFETs, bidirektional 3,3 V gegen 5 V, eigener 3,3-V-Regler mit höchstens 150 mA, Betriebs-LED. Text nennt Verpolschutz, Tabelle „Schutzfunktionen: Keine“ (Widerspruch im Blatt; keinen Schutz annehmen). MOSFET- und Reglertyp stehen nirgends.
- Shopfoto: zwei 6er-**Winkelstiftleisten** (so gedeutet; am Teil zeigte sich: gerade Stifte, unter dem Modul nach außen umgebogen), Aufdruck „L“ links und „H“ rechts, „JY-MCU“ in der Mitte, vier SOT-23-Transistoren, ein Regler. Reihenabstand aus dem Foto geschätzt etwa 12,7 mm (zweiter Prüfer, 03.11.2026).
- Altes Modul RBS16466 (Foto lesbar): obere Reihe HV1, HV2, HV, GND, HV3, HV4; untere Reihe LV1, LV2, LV, GND, LV3, LV4; je Kanal 10 kΩ („103“); dort ist LV ein Eingang. Am 30.10.2026 gemessen: HV gegen HV1 mit 2,2 kΩ parallel 1,784 kΩ, LV gegen LV1 10,09 kΩ, also 10 kΩ je Kanal belegt.

## Am gelieferten Teil (04.11.2026, eigene Fotos)

- **Stiftleisten angelötet:** zwei 6er-Leisten, Kunststoff auf der Bauteilseite, Stifte gerade durch die Löcher und unter dem Modul nach außen umgebogen (Lieferzustand, Spitze zu Spitze etwa 25,6 mm laut Foto).
- **Aufdruck nur auf der Textseite (die Seite ohne Bauteile, beim Stecken oben) und nur an zwei Stiften je Seite:** H-Seite oben „5V“, darunter „GND“; L-Seite oben „3V“, darunter „GND“; dazu „I<150mA“ mit Pfeil von 5V nach 3V. Die übrigen vier Stifte je Seite sind unbeschriftet. Auf der Bauteilseite nur „L“, „H“, „JY-MCU“. **Anders als beim RBS16466:** Versorgung und GND liegen außen am Ende, nicht in der Mitte.
- 3V ist der Ausgang des eigenen Reglers (gemessen 06.11.2026: 3,342 V bei 5 V am 5V-Stift); die vier unbeschrifteten Stifte sind die Kanäle, je Zeile ein Paar L und H, gerade gegenüber (gemessen 06.11.2026, nächster Abschnitt).
- Pieptest GND links gegen GND rechts: Durchgang (04.11.2026).
- Reihenabstand Lochmitte zu Lochmitte etwa 12,7 mm (Foto, Maßstab aus dem Stiftraster 2,54 mm).

## Am Steckbrett gemessen (06.11.2026 abends), keine Annahme mehr

- **Paarung der Kanäle:** nur 12 V am Netzteil (0,009 A), ein L-Stift nach dem anderen auf Masse gebrückt; jedes Mal fällt genau der gerade gegenüberliegende H-Stift auf etwa 1 mV (der erste auf −1,1 mV), die übrigen bleiben bei 4,76 bis 4,79 V. Also L1 zu H1 bis L4 zu H4, gezählt vom Versorgungsende. In `pins.toml` eingetragen, `fertigen` ist frei.
- **3V-Stift:** 3,342 V unter Strom, also der Ausgang des eigenen Reglers; L1 in Ruhe 3,363 V, H1 4,76 V.
- **Stromlos (DT132A, Spitzen in den Löchern):** H1 gegen 5V 67,5 kΩ, L1 gegen 3V kein fester Wert (springt zwischen kΩ und MΩ). Anders als beim alten RBS16466 also keine 10 kΩ je Kanal; die 10 kΩ auf der Anzeige und R1, R2 (2,2 kΩ) auf der Platine übernehmen das.
- **Shopfoto und Messung passen zusammen (berichtigt 08.11.2026, Handprüfung der Platine):** Die Gegenprüfung vom 06.11.2026 hielt das Shopfoto RBS10128 für ein Spiegelbild. Es zeigt nur die Bauteilseite; das Modul steckt aber mit der **Textseite oben** (dort die Lötkegel der Stifte), Bauteile, Kunststoff der Leisten und lange Stifte zeigen zur Platine. Belegt durch das Foto des gesteckten Moduls (eigenes Foto vom 06.11.2026, nicht veröffentlicht) und den Scan vom 04.11.2026 (ein Scan zeigt die aufliegende Seite unverspiegelt). Mit lesbarem Aufdruck liegt 5V oben links und 3V oben rechts. Die Messung vom 06.11.2026 (5 V am rechten Versorgungsstift g32, 3,342 V am linken a28, Versorgungsende beim Betrachter, Aufdruck auf dem Kopf) sagt dasselbe. Probe 4 passt dazu. **Vor dem Löten am Stück prüfen (Handgriff 2 in der LIESMICH der Uhr):** Textseite oben, Aufdruck lesbar, „5V“ auf dem Pad 5V (oben links neben R1), „3V“ auf dem Pad 3V (oben rechts zum XIAO), der Pfeil „I<150mA“ zeigt zum XIAO.
- Überholt am 04.11.2026: Belegung wie beim RBS16466 und Reihenabstand 11,3 mm. Es gelten der Aufdruck am Teil und 12,7 mm (unten).

## Prüfpunkte (erledigt 04. und 06.11.2026)

1. Stromlos: Stifte gerade (zurückgebogen), Aufdruck nur 3V, GND, 5V, GND, Reihenabstand 12,66 mm, GND links gegen GND rechts Durchgang (04.11.2026). H1 gegen 5V 67,5 kΩ statt der erwarteten 10 kΩ (06.11.2026).
2. 5 V am 5V-Stift (über den Wandler am Steckbrett): 3V-Stift 3,342 V (06.11.2026).
3. Kanal: L-Stift auf Masse zieht seinen H-Stift auf etwa 1 mV (06.11.2026). Die Gegenrichtung (H auf Masse, L messen) ist nicht gemessen; die Uhr braucht sie nur für das Quittieren der Anzeige auf DIO, das der ESPHome-Treiber nicht auswertet, und die Anzeige lief 17 Minuten fehlerfrei.
Quellen in `pins.toml` am 06.11.2026 ersetzt.

## Entscheidung: Stifte zurechtbiegen (04.11.2026)

Die Stifte kamen nicht seitlich aus dem Kunststoff, wie ich das Foto zuerst gelesen hatte, sondern gerade durch die Löcher nach unten und waren unter dem Modul nach außen umgebogen (04.11.2026). **Am 04.11.2026 wurde ein Stück zurückgebogen, alle Stifte stehen senkrecht nach unten.** Damit ist es eine gewöhnliche gerade Stiftleiste: Kunststoff auf der Bauteilseite, die langen Stifte stehen auf der Bauteilseite, die Lötkegel liegen auf der Textseite. Gesteckt zeigt darum die Bauteilseite nach unten und die Textseite nach oben (Steckbrett-Foto 06.11.2026, Scan 04.11.2026).
- Länge vom Kunststoff bis zur Spitze 7,94 mm (Messschieber), also etwa 6,3 mm unter der Modulplatte. Für Platine und Gehäuseboden prüfen, wie weit die Stifte unten herausragen.
- Modulbreite 15,67 mm (Messschieber).
- **Reihenabstand gemessen 04.11.2026 (Messschieber):** außen 13,33 mm, Stiftdicke 0,67 mm, also 12,66 mm Mitte zu Mitte; im Footprint 12,7 mm (5 × 2,54), Bohrung 1,2 mm, Annahmen zu Abstand und Stiftart gestrichen. Die Paarung der Kanäle ist seit 06.11.2026 gemessen (oben). Der Scan vom 04.11.2026 ergab 12,97 ±0,25 mm (nur Lötkegel auswertbar, schwächster Wert des Scans); die Messung mit den äußeren Schnäbeln über die festen Stifte ist hier genauer und gilt. Bei 12,7 mm passt das Modul am Steckbrett über den Mittelgraben in die Spalten d und g (mittig) oder c und f.
- **Lage am Teil gemessen (06.11.2026 abends, Steckbrett; Wortlaut berichtigt 08.11.2026):** Textseite oben (so steckt es), Aufdruck vom Betrachter aus auf dem Kopf, dann liegt das Versorgungsende (3V, 5V) **beim Betrachter, also unten**, die 3V-Reihe links, die 5V-Reihe rechts. Belegt durch den Pieptest GND links gegen GND rechts am zweiten Stift vom nahen Ende und 3,342 V am linken Versorgungsstift. Die frühere Fassung sprach von „Bauteilseite oben, L links“; die Bauteilseite mit den Buchstaben L und H und den zwei T-Bauteilen zeigt beim Stecken nach unten und war nicht zu sehen.
- **Folge: Der Footprint `Pegelwandler_Sockel` von Probe 3 hatte L und H vertauscht.** Er hatte Pad 1 (3V) oben links; am gesteckten Teil liegt bei Aufdruck auf dem Kopf 3V unten links. So eingesetzt wäre 5 V auf H4 und GND auf H3 gelandet. **Berichtigt am 06.11.2026 mit Probe 4:** L-Reihe links, Pad 1 (3V) und Pad 7 (5V) am unteren Ende; die Beschreibung des Footprints nennt seit 08.11.2026 die Textseite als Merkmal.
- **Merkmal für die Lage (berichtigt 08.11.2026):** Das Versorgungsende ist das Ende mit dem Aufdruck 3V/5V/GND auf der Textseite. Auf der Bauteilseite (beim Stecken unten) stehen dort die zwei schwarzen Bauteile am Rand, die mit den Nachbarn wie ein T stehen; die Buchstaben L und H stehen am anderen Ende. Beim Einstecken in die Platine zählt nur die Textseite: Aufdruck lesbar, 5V neben R1.
- Genau dieses Stück kommt auf die Platine und in den Steckbrett-Test. Footprint mit Bohrung 1,2 mm, weil zurückgebogene Stifte weniger genau stehen.

## Bei Winkelstiften entscheiden (erledigt, siehe oben; Wege zum Nachlesen)

Das Modul passt dann nicht in den Sockel mit geraden Löchern. Wege: flach auf große Pads löten (SMD-artig, im Werkzeug ungetestet), diskreter Pegelwandler aus zwei N-Kanal-MOSFETs (2N7000 oder BS170, Kauf nötig, Schwellspannung bis 3 V laut Datenblatt, am Steckbrett prüfen) mit vier 10 kΩ, oder die NPN-Variante mit BC547 aus dem Bestand (rechnerisch tragfähig, nie zu Ende getestet). Am Steckbrett geht das Modul in jedem Fall: Dupont-Buchsen passen auf die Winkelstifte. Verworfen für den Pegel: Diode 1N4148 (sperrt 5 V nicht, gemessen 3,668 V am GPIO) und 4,5 V Versorgung mit Pull-ups nach 3,3 V (Abstand zur Schwelle zu klein). Der NPN-Schalter mit BC547 bleibt Reserve für die Platine, rechnerisch und im Treibercode tragfähig; BC547 laut onsemi: 1 C, 2 B, 3 E, höchstens 100 mA.

## Einbau

- Der 3V-Stift bleibt unverbunden, damit der Regler des Moduls nicht gegen den Regler des XIAO arbeitet.
- Je 2,2 kΩ von H1 und H2 nach 5 V (R1 und R2 auf der Platine) zusätzlich zu den 10 kΩ auf der Anzeige (Tischbefund 24.10.2026, Anzeige sonst dunkel). Dieses Modul selbst hat keine 10 kΩ (67,5 kΩ gemessen).
- Auf der Uhr-Platine: L1 an D4 (GPIO6, Takt), L2 an D5 (GPIO7, Daten), H1 an CLK und H2 an DIO der Anzeige; genau so lief es am Steckbrett (06.11.2026). Lage auf der Platine: Textseite oben, Aufdruck lesbar, „5V“ oben links neben R1, „3V“ oben rechts zum XIAO, Pfeil zum XIAO (Bild nicht veröffentlicht).
- Nichts direkt an das Modul löten (Grenze seit 30.10.2026); nur mit Stiften in Sockel oder auf Pads.
