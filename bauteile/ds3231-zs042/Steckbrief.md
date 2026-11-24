# Uhrmodul DS3231 auf ZS-042, Steckbrief

Stand 08.11.2026. Unterlagen (nicht veröffentlicht): Datenblatt DS3231 von Maxim, Rev. 9 (Chip) und Shop-Informationsblatt RBS10176 (Modul mit Foto). Einen Schaltplan des Moduls gibt es in keiner Unterlage.

## Anschlüsse

- **6er-Reihe** (Zellenhalter oben, Reihe links, von oben): GND, VCC, SDA, SCL, SQW, 32K. Quelle: Shopfoto RBS10176 Seite 1, Aufdruck entlang der Reihe, vergrößert gelesen. Am Aufdruck des Moduls gegenlesen.
- **4er-Reihe am anderen Ende:** SCL, SDA, VCC, GND, am Aufdruck gelesen (eigenes Foto, 04.11.2026): auf der Chipseite liegt SCL auf der Seite der LED „POWER“, GND auf der Seite der Lötbrücken A0 A1 A2. Die Löcher sind frei. I2C ist zwischen beiden Reihen durchgeschleift.
- **Lage am Teil geprüft (06.11.2026):** Chipseite oben, die vier Löcher am rechten Ende, dann von ihm aus GND, VCC, SDA, SCL (SCL am weitesten weg). Gespiegelt auf die Zellenseite ist das die Lage im Footprint (4er-Reihe links, Pad 1 SCL oben), der Footprint ist nicht gespiegelt. Gelötet wird die Leiste mit dem Kunststoff auf der Chipseite.
- **Auf der Platine trägt die 4er-Reihe die Signale (04.11.2026).** Am Modul aus dem Endbau ist die Stiftleiste ab, die 6er-Reihe ist mit Zinn und Stiftresten gefüllt; daran wird nicht mehr gelötet oder geschnitten (04.11.2026). Das Modul selbst ist geprüft und in Ordnung.
- **Pinarten** (DS3231 Rev 9 Seite 9): SDA, SQW und 32K open-drain, SCL Eingang. Die Signale laufen auf der Versorgungsspannung des Moduls.
- **Versorgung:** Modul 2,3 bis 5 V (Shopblatt Seite 2), Chip 2,3 bis 5,5 V (Datenblatt Seite 2). Auf der Uhr 3,3 V.
- **Pull-ups auf dem Modul: vorhanden.** Gemessen 04.11.2026 (DT132A, stromlos): SDA gegen VCC 4,68 kΩ, SCL gegen VCC 4,68 kΩ. Auf dem Foto zwei Widerstandsnetze mit Aufdruck „472“ (4,7 kΩ). Auf der Platine also keine eigenen I2C-Pull-ups. Strom bei 3,3 V: 3,3 V / 4,7 kΩ = 0,7 mA je Leitung.
- **I2C-Adressen:** 0x68 (Uhr), meist auch 0x57 (EEPROM auf dem Modul).
- **Ladeschaltung:** Widerstand „201“ (200 Ω) und Diode laden eine Zelle. Am Modul aus Bestellung 8705926 wurde der Widerstand am 29.10.2026 entfernt. Bei einem neuen Modul wieder entfernen, vorher keine CR2032 einlegen.
- **Knopfzelle:** VBAT 2,3 bis 5,5 V, 0,84 µA typisch (Datenblatt Seite 2 und 9). Vor dem Einlegen über 3 V messen. Keine AA oder AAA statt CR2032: 1,5 V unterschreitet VBAT. Rechnerisch 7 bis 30 Jahre; Alkalizellen laufen im Bad aus, ER14505 verworfen, Rechnung belegt, nicht neu rechnen. Gekauft Amazon Basics; für Nachkauf Panasonic oder Varta ohne Bitterstoff, frisch und echt wichtiger als die Marke (Recherchebericht vom 26.10.2026, nicht veröffentlicht).
- **Temperatur:** der Chip misst mit ±3 °C, über die ESPHome-Plattform `ds1307` nicht lesbar.

## Maße

- Gemessen am 25.10.2026 (Messschieber) am Modul aus Bestellung 8705926: 38,62 × 23,05 mm, mit Stiftleiste 44,60 mm; Platinenoberseite 9,04 mm, höchstes Bauteil 12,04 mm über der Auflage. Shopblatt: 37 × 21 × 6 mm.
- **4er-Reihe, Flachbettscan 04.11.2026 (600 dpi mit Skala):** Raster 2,57 mm (±0,08, also 2,54), Lochmitte 1,37 mm vom kurzen Rand, Reihe mittig über die Breite (11,28 und 11,10 mm zu den langen Kanten). Kantenmaße im Scan fallen etwa 0,3 bis 0,5 mm zu klein aus (Außenmaß 37,64 × 22,39 gegen 38,62 × 23,05 mit dem Messschieber), darum im Footprint der Umriss vom Messschieber und die Lochmitte etwa 1,6 mm vom Rand.
- Footprint `Bauteile.pretty/DS3231_ZS042_Sockel.kicad_mod` seit 04.11.2026 nur noch mit den 4 Pads der 4er-Reihe, Annahme gestrichen; `pins.toml` hat nur noch diese 4 Pins.
- **Stütze auf der Uhr-Platine (Gehäuse vom 07.11.2026):** Das Modul hängt nur an einem Ende an vier Stiften, beim Einsetzen der Knopfzelle drückt man auf das freie Ende. Dort steht ein gedruckter Klotz zwischen Hauptplatine und Modul (`teil = "klotz"` in `Gehaeuse/gehaeuse.scad`), darunter eine Querrippe des Gehäuses. Der Klotz ist zugleich die Lötlehre: Chips 0,3 mm über der Hauptplatine.
- Die Chips sitzen auf der Seite zur Hauptplatine, der Zellenhalter zeigt nach hinten. Die Oberkante des Zellenhalters liegt darum 12,3 mm über der Hauptplatine (0,3 Luft plus 12,04 Modul); die Schätzung „etwa 7,6 mm“ vom 01.11.2026 war zu klein.
- **Zelle wechseln:** Der Halter ist zum Ende mit der 6er-Reihe hin offen (Shopfoto RBS10176), die Zelle rutscht also zum freien Ende hin heraus. Am Teil prüfen.
