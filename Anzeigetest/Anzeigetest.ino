// Leuchttest fuer die TM1637-Anzeige der Badspiegel-Uhr am Uno R4 Minima (5-V-Logik, kein Pegelwandler).
// Belegung und Aufbau: Anzeigetest/LIESMICH.md. Bibliothek: "TM1637" von Avishay Orpaz.
// Die Bibliothek treibt CLK und DIO nur auf Low und laesst sie fuer High los, darum sind die 2,2-kOhm-Pull-ups
// nach 5 V Pflicht (Tischbefund 24.10.2026, siehe Bauteile/tm1637-anzeige/Steckbrief.md).

#include <TM1637Display.h>

const int PIN_CLK = 2;  // D2
const int PIN_DIO = 3;  // D3

TM1637Display anzeige(PIN_CLK, PIN_DIO);

const uint8_t ALLES_AN[] = {0xff, 0xff, 0xff, 0xff};  // alle Segmente, beim zweiten Byte samt Doppelpunkt

void setup() {
  Serial.begin(115200);
}

void loop() {
  // 1. Alles an, volle Helligkeit: Farbe und fehlende Segmente pruefen.
  anzeige.setBrightness(7, true);
  anzeige.setSegments(ALLES_AN);
  Serial.println("Alles an, Stufe 7");
  delay(5000);

  // 2. Jede Ziffer 0 bis 9 auf allen Stellen.
  for (int z = 0; z <= 9; z++) {
    anzeige.showNumberDecEx(z * 1111, 0, true);
    delay(600);
  }

  // 3. Helligkeitsstufen 0 bis 7 mit 12:34, fuer die spaetere Wahl am Spiegel.
  for (int stufe = 0; stufe <= 7; stufe++) {
    anzeige.setBrightness(stufe, true);
    anzeige.showNumberDecEx(1234, 0b01000000, true);
    Serial.print("Stufe ");
    Serial.println(stufe);
    delay(1500);
  }
}
