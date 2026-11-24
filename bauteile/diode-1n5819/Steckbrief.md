# Schottky-Diode 1N5819 (DO-41), Steckbrief

Stand 13.11.2026. Auf der Uhr-Platine D1 (Entkopplung des XIAO vom USB-Knoten, speist Pin 14 aus +5V) und D2 (Verpolschutz am 12-V-Eingang).
Unterlage: Vishay 1N5817, 1N5818, 1N5819, Dokument 88525, Revision 01-Jul-2020, 4 Seiten (Seite 4 ist der
rechtliche Hinweis), Kopie nicht veröffentlicht.
Von wem die Stücke im Bestand sind, ist offen (Aufdruck nachsehen). Das Blatt gilt für Vishay.

## Anschlüsse

Bedrahtete Diode im Gehäuse DO-41 (DO-204AL). Der Farbring liegt am Kathodenende (S. 1: „color band denotes the cathode
end“). Der Strom fließt in Durchlassrichtung vom Anodenende zum Ringende. Das Blatt nummeriert die Anschlüsse nicht.

Maße (S. 3, Zoll und Millimeter laut Blatt): Körper 4,1 bis 5,2 mm lang, 2,0 bis 2,7 mm dick, Draht 0,71 bis 0,86 mm
dick, Draht je Seite mindestens 25,4 mm.

## Grenzwerte (S. 1, „Maximum Ratings“, TA = 25 °C, 1N5819)

| Größe | Wert |
|---|---|
| Spitzensperrspannung VRRM | 40 V |
| Effektivwert VRMS | 28 V |
| Gleichsperrspannung VDC | 40 V |
| Einmalige Spitzensperrspannung VRSM | 48 V |
| Mittlerer Durchlassstrom IF(AV), 9,5 mm Drahtlänge, TL = 90 °C | 1,0 A |
| Stoßstrom IFSM, 8,3 ms Halbsinus | 25 A |
| Sperrschicht und Lager | −65 bis +125 °C |

Der Strom von 1,0 A sinkt mit der Gehäusetemperatur: bei etwa 100 °C am Gehäuse sind es noch etwa 0,7 A (Bild 1, S. 2,
Kurve grob abgelesen).

## Kennwerte (S. 1 und S. 2, 1N5819)

| Größe | Wert |
|---|---|
| Durchlassspannung VF, 1,0 A | höchstens 0,600 V |
| Durchlassspannung VF, 3,1 A | höchstens 0,900 V |
| Sperrstrom IR bei VR = 40 V | höchstens 1,0 mA bei 25 °C, höchstens 10 mA bei 100 °C |
| Kapazität CJ, 4,0 V, 1 MHz | typ. 110 pF |
| Wärmewiderstand (S. 2) | zur Luft RθJA 50 °C/W, zum Draht RθJL 15 °C/W (Platine mit 38 × 38 mm Kupfer) |

Die Prüfströme „1.0“ und „3.1“ stehen ohne Einheit in der Tabelle; sie sind Ampere (Annahme, zur Reihenfolge der
Grenzwerte passend). Bild 3 (S. 2) zeigt typische Kennlinien für 25 und 125 °C ohne Typangabe. Bild 4 (S. 2) zeigt den
typischen Sperrstrom in Prozent der Nennspannung.

## Offen

- Hersteller der Stücke im Bestand (Aufdruck prüfen); die Werte hier gelten für Vishay.
- Die 1,0 A gelten bei 9,5 mm Drahtlänge und TL = 90 °C. Wie viel das Blatt bei kurzen Drähten im Gehäuse zulässt,
  steht nicht darin.
