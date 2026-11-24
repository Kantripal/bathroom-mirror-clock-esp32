// Pruefung von briefing.h: g++ -std=c++17 briefing_test.cpp -o /tmp/bt && /tmp/bt
#include <cassert>
#include <cstring>
#include "briefing.h"

static bool gleich(bool ok, const char *buf, const char *soll) { return ok && std::strcmp(buf, soll) == 0; }

int main() {
  char b[8];
  assert(briefing_im_fenster(6, 6, 10) && briefing_im_fenster(9, 6, 10));
  assert(!briefing_im_fenster(10, 6, 10) && !briefing_im_fenster(5, 6, 10));
  assert(!briefing_im_fenster(6, 6, 6));
  assert(briefing_im_fenster(23, 22, 2) && briefing_im_fenster(1, 22, 2) && !briefing_im_fenster(2, 22, 2));

  assert(briefing_seite(0, 3) == -1 && briefing_seite(7999, 3) == -1);
  assert(briefing_seite(8000, 3) == 0 && briefing_seite(11000, 3) == 1 && briefing_seite(16999, 3) == 2);
  assert(briefing_seite(17000, 3) == -1);  // naechster Zyklus beginnt mit der Uhrzeit
  assert(briefing_seite(12345, 0) == -1);

  assert(gleich(briefing_temperatur(b, 8, 7.4f), b, " 7~C"));
  assert(gleich(briefing_temperatur(b, 8, -2.6f), b, "-3~C"));
  assert(gleich(briefing_temperatur(b, 8, 12.0f), b, "12~C"));
  assert(gleich(briefing_temperatur(b, 8, -12.2f), b, "-12~"));
  assert(!briefing_temperatur(b, 8, NAN) && !briefing_temperatur(b, 8, 150.0f));

  assert(gleich(briefing_wert(b, 8, 'H', 14.2f, -99, 999), b, "H 14"));
  assert(gleich(briefing_wert(b, 8, 'H', -12.0f, -99, 999), b, "H-12"));
  assert(gleich(briefing_wert(b, 8, 'r', 5.5f, 0, 999), b, "r  6"));
  assert(gleich(briefing_wert(b, 8, 'r', 0.3f, 0, 999), b, "r  0"));
  assert(gleich(briefing_wert(b, 8, 'r', 12.0f, 0, 999), b, "r 12"));
  assert(!briefing_wert(b, 8, 'r', NAN, 0, 999) && !briefing_wert(b, 8, 'r', -1.0f, 0, 999));
  return 0;
}
