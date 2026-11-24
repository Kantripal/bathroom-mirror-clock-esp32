# Anzeigetest am Uno R4 Minima

Stand 04.11.2026. Leuchttest für eine TM1637-Anzeige, bevor etwas an sie gelötet wird. Der Uno arbeitet mit 5 V wie die Anzeige, darum braucht es keinen Pegelwandler. Die Stiftleiste steckt nur lose in den Löchern der Anzeige.

Programm: `Anzeigetest.ino`, Bibliothek „TM1637“ (Avishay Orpaz, 1.2.0). Aufspielen:

```bash
arduino-cli compile --fqbn arduino:renesas_uno:minima .
arduino-cli upload -p /dev/ttyACM0 --fqbn arduino:renesas_uno:minima .
```

**Gelaufen am 04.11.2026 mit der weißen Anzeige:** R1 2,180 kΩ, R2 2,158 kΩ, Versorgung 4,76 V, Anzeige weiß, alle Segmente gehen. Der MakerMind-Nachbau meldet sich als `2341:0369` und nimmt das Programm über den DFU-Port aus `arduino-cli board list`.

Ablauf des Programms in Schleife: 5 s alle Segmente samt Doppelpunkt bei Stufe 7, dann jede Ziffer 0 bis 9 auf allen Stellen, dann „12:34“ in den Helligkeitsstufen 0 bis 7, je 1,5 s.

## Belegung

Steckbrett SYB-120 wie im Leitfaden: Reihe 1 bei dir, Spalte a links. Die Anzeige liegt mit aufrechten Ziffern vor dir, die Platine ragt rechts über den Rand.

| Anschluss | Steckbrett | Fundstelle |
|---|---|---|
| Anzeige CLK | j43 | `Bauteile/tm1637-anzeige/pins.toml` (von oben CLK, DIO, GND, 5V); an der weißen Anzeige vor dem Stecken am Aufdruck prüfen |
| Anzeige DIO | j42 | wie oben |
| Anzeige GND | j41 | wie oben |
| Anzeige 5V | j40 | wie oben |
| Uno 5V, GND | Buchsenleiste POWER | Datenblatt ABX00080 S. 13, Tabelle 10.1; beim Nachbau zählt der Aufdruck |
| Uno D2, D3 | Buchsenleiste DIGITAL, aufgedruckt nur „2“ und „~3“ | Datenblatt ABX00080 S. 13, Tabelle 10.2 |

## Verbindungen

| Leitung | von | nach | Warum |
|---|---|---|---|
| Dupont rot | Uno 5V | f40 | Versorgung der Anzeige |
| Dupont schwarz | Uno GND | f41 | Masse |
| Dupont gelb | Uno D2 | f43 | Takt CLK |
| Dupont grün | Uno D3 | f42 | Daten DIO |
| R1 2,2 kΩ | g40 | g43 | Pull-up CLK nach 5 V, Pflicht (Steckbrief) |
| R2 2,2 kΩ | h40 | h42 | Pull-up DIO nach 5 V, Pflicht |

## Messliste

| Nr. | Messung | Erwartet | Grund |
|---|---|---|---|
| 1 | j40 gegen j43, stromlos, ohne Anzeige | 2,2 kΩ (2,15 bis 2,25) | R1 sitzt richtig |
| 2 | j40 gegen j42, stromlos | 2,2 kΩ | R2 sitzt richtig |
| 3 | j40 gegen j41, stromlos, Uno verbunden | kein Dauerton | kein Kurzschluss; ein kurzes Zirpen ist der Kondensator des Uno |
| 4 | j40 gegen j41, USB an, ohne Anzeige | etwa 4,7 V (4,6 bis 4,8) | USB 5 V abzüglich der Schottky-Diode des Uno (Datenblatt S. 10) |

## Fallen

- 5V und GND vertauscht kann den Chip der Anzeige zerstören. Darum vor dem Stecken den Aufdruck an den Löchern lesen.
- Anzeige bleibt dunkel: meist Kontakt der losen Stifte. Anzeige leicht schräg gegen die Stifte drücken. Dann Pull-ups und D2/D3 prüfen.
- Leuchtet die Anzeige blau statt weiß: nichts löten, der Shop bekommt sie zurück.
