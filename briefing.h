// Rechenteil des Morgen-Briefings, ohne ESPHome, damit briefing_test.cpp es am Rechner pruefen kann:
// g++ -std=c++17 briefing_test.cpp -o /tmp/bt && /tmp/bt
#pragma once
#include <cmath>
#include <cstdint>
#include <cstdio>

// Volle Stunden, ab einschliesslich, bis ausschliesslich. ab gleich bis: kein Fenster.
// ab nach bis laeuft ueber Mitternacht (22 bis 2).
inline bool briefing_im_fenster(int stunde, int ab, int bis) {
  return ab <= bis ? (stunde >= ab && stunde < bis) : (stunde >= ab || stunde < bis);
}

// Im Fenster: 8 s Uhrzeit, dann je 3 s eine Seite. -1 heisst Uhrzeit.
inline int briefing_seite(uint32_t ms, int n) {
  if (n <= 0) return -1;
  uint32_t pos = ms % (8000u + 3000u * n);
  return pos < 8000u ? -1 : (int) ((pos - 8000u) / 3000u);
}

// Aussentemperatur in 4 Stellen: " 7~C", "-3~C", "12~C", ab minus 10 ohne C: "-12~".
// '~' ist bei ESPHome das Gradzeichen. false, wenn kein Wert oder ausserhalb.
inline bool briefing_temperatur(char *buf, size_t len, float t) {
  if (std::isnan(t)) return false;
  long g = lroundf(t);
  if (g >= -9 && g <= 99) snprintf(buf, len, "%2ld~C", g);
  else if (g >= -99 && g < -9) snprintf(buf, len, "%3ld~", g);
  else return false;
  return true;
}

// Ein Buchstabe vorn, dann 3 Stellen: "H 14", "H-12", Regen in mm "r  6", "r 12".
inline bool briefing_wert(char *buf, size_t len, char vorn, float w, long min, long max) {
  if (std::isnan(w)) return false;
  long g = lroundf(w);
  if (g < min || g > max) return false;
  snprintf(buf, len, "%c%3ld", vorn, g);
  return true;
}
