# Step-down-Wandler MP1584, Steckbrief

Stand 04.11.2026. Unterlagen (nicht veröffentlicht): Datenblatt MP1584EN von MPS (Regler) und Shop-Informationsblatt RBS11139 (Modul mit Foto). Zwei alte Stücke (Bestand) und vier neue aus Lieferung 8710309 (04.11.2026, eines fehlte). **Alt und neu sind derselbe Artikel RBS11139 und dieselbe Bauform** (Länge 25,45 mm gemessen 04.11.2026); die frühere Annahme, die neuen seien kürzer, stammte aus der falschen Shopangabe 22 × 17 mm.

## Anschlüsse

- **Lage an Merkmalen:** Plus liegt auf der Längsseite mit Chip und Trimmer, Minus auf der Längsseite mit der Spule; der Trimmer sitzt am OUT-Ende; die Aufschrift IN und OUT steht nur auf der Unterseite. Quelle: Aufschrift der Unterseite OUT−, OUT+, IN−, IN+ am neuen Modul (eigenes Foto, gelesen 04.11.2026); Plus-Paare haben eckige Pads.
- Je Anschluss ein Lochpaar, die zwei Löcher eines Paars sind derselbe Anschluss. **Pieptest 04.11.2026:** jedes Paar Durchgang, IN− gegen OUT− Durchgang, IN− gegen IN+ kein Durchgang.
- **Eingang 4,5 bis 28 V** (MP1584EN Seite 2), Ausgang einstellbar 0,8 bis 20 V (Shopblatt). **Keine Schutzfunktionen** (Shopblatt Seite 2): kein Verpolschutz, keine Begrenzung. Darum auf der Uhr-Platine eine 1N5819 vor dem Eingangs-Elko.
- **Erst ohne Last auf 5,0 V stellen** (Bereich 4,75 bis 5,25 V; der Regler auf dem XIAO verträgt höchstens 5,5 V), dann anklemmen. Trimmer im Uhrzeigersinn = mehr Spannung, feiner als etwa 0,05 V geht es nicht. Ab Werk liefern die Module etwa 3,3 V (gemessen 3,29 bis 3,30 V).
- **Eingangs-Elko ist Pflicht:** Das Spiegel-Netzteil ist unruhig (LED des Uhrmoduls flackerte im Millisekundentakt, am Wanptek nie; 470 µF stoppte es), 10 µF am Eingang reichen, geplant waren 22 oder 47 µF / 25 V, eingebaut werden 47 µF 25 V. Keramikkondensatoren taugen hier nicht als Eingangspuffer (Tischbefund).

## Messwerte

- Alte Module (Bestellung 8705926): Testwandler 5,05 V, Endbau-Wandler 5,07 V ohne Last (29.10.2026, DT132A). Endbau-Wandler am Steckbrett hinter der 1N5819 (Eingang 11,87 V): 5,03 V ohne Last (06.11.2026).
- Stromaufnahme der ganzen Uhr 0,031 bis 0,034 A bei 12,0 V (25.10.2026, Wanptek), etwa 0,4 W (alte Uhr 0,36 W; Spitzen zeigt das Wanptek nicht); der Wandler bleibt bei 70 mA Ausgangsstrom kalt.

## Maße

- Gemessen am 25.10.2026 (Messschieber) am alten Modul: 25,40 × 16,96 × 4,50 mm (Länge mit Plastiklasche); IN-Seite vier Löcher quer, notiert innere 9,0 mm, äußere 14,5 mm, damals Lochmitte nach Augenmaß angesetzt (04.11.2026); ersetzt durch die Messung vom 04.11.2026.
- **Neue Module RBS11139 aus Lieferung 8710309: Länge 25,45 mm (04.11.2026, Messschieber).** Damit gleiche Bauform wie das alte Modul, das ebenfalls RBS11139 war (Bestellliste nicht veröffentlicht). Die Shopangabe 22 × 17 × 4 mm ist falsch.
- **Lochbild (04.11.2026, Messschieber, innere Schnäbel bis zu den Außenrändern, Lochmitte = Anzeige minus Bohrung):** acht Löcher, je Ende zwei Paare quer zur Länge; auf der Unterseite beschriftet OUT−, OUT+, IN−, IN+ (eigenes Foto vom 04.11.2026). Minus-Paare auf der Seite der Spule, Plus-Paare (eckige Pads) auf der Seite des Trimmers. Bohrung 0,90 mm. Längs IN zu OUT, gegenüberliegende Löcher: Anzeige 20,05, also Mitte 19,15 mm. Quer äußeres Minus- zu äußerem Plus-Loch: Anzeige 14,81, also 13,91 mm (zweimal gemessen). Gegenprobe am Foto der Unterseite, unabhängig vom Maßstab: quer zu längs = 452 zu 625 Bildpunkte, mal 19,15 mm ergibt 13,85 mm. Im Paar: Anzeige 3,58, also 2,68 mm; das Foto ergibt etwa 2,55 mm, vermutlich also doch 2,54-Raster; für die Platine unerheblich, weil nur die vier äußeren Löcher Stifte bekommen. Die alten Werte vom 25.10. (9,0 und 14,5) gelten nicht mehr. Umriss für den Footprint aus dem Foto: Lochmitte bis IN-Kante etwa 1,8 mm, bis OUT-Kante mit Lasche etwa 4,5 mm (im Footprint 4,3 mm aus demselben Foto; der Unterschied liegt nur im Umriss, nicht in den Pads).
- **Flachbettscan 04.11.2026 (600 dpi, Maßstab aus einer eigenen Kalibrierskala, Modul flach auf dem Glas, Kreisanpassung je Loch; Scan nicht veröffentlicht):** längs 19,35 mm (Einzelwerte 19,29 bis 19,40), quer außen 13,76 und 13,81 mm, im Paar 2,57 mm (also 2,54-Raster), je ±0,1. **Diese Werte gelten.** Die Messschieber-Werte darüber (19,15 und 13,91) stammen von den inneren Schnäbeln in 0,9-mm-Löchern und sind dafür zu ungenau.
- Footprint `Bauteile.pretty/MP1584_Sockel.kicad_mod` seit 04.11.2026 auf 19,35 × 13,78 mm, Bohrung 1,2 mm (Spiel für die Stifte), Annahme gestrichen. Prüfung am 1:1-Ausdruck steht aus.
