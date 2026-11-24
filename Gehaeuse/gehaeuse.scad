// ============================================================
// Gehaeuse der Badspiegel-Uhr, Neubau fuer die Platine Probe 4 (Aisler)
//
// Stand 14.11.2026 (Masse an der bestueckten Platine), gezeichnet 07.11.2026.
// Ersetzt das Gehaeuse vom 25.10.2026 fuer die Freiverdrahtung (96,79 mm lang,
// steht in Git). Aus ihm gelten weiter: Fluegel, Fluegellage vom rechten Ende,
// Querschnitt mit der 45-Grad-Schraege und die Lage der Ziffern (Probestueck mit spiel = 0 gedruckt und
// eingerastet am 26.10.2026).
//
// teil = "gehaeuse" | "deckel" | "klotz" | "probe" | "belegung"
//   probe:    die vorderen 13 mm des Gehaeuses, prueft Schiene, Fenster und
//             den Sitz der Anzeige auf der Schraege
//   klotz:    Stuetze unter dem freien Ende des Uhrmoduls, zugleich Loetlehre
//   belegung: Gehaeuse durchsichtig, Deckel grau, alle Teile als Quader
//
// Die Messliste ist am 14.11.2026 an der bestueckten Platine gemessen (Messschieber;
// Protokoll nicht veroeffentlicht). Faellt ein assert, ist das Gehaeuse an dieser Stelle falsch,
// nicht die Messung. "ANNAHME" steht nur noch, wo nichts gemessen ist.
//
// KOORDINATEN wie im alten Modell: x laengs, x = 0 ist das LINKE Ende von
// vorn durch den Spiegel gesehen, rechts ist der Anschlag in der Schiene.
// z vom Glas (z = 0) nach hinten zur Wand. y quer, Mitte = 0, und +y zeigt
// NACH UNTEN: OpenSCAD rechnet rechtshaendig, und mit x nach rechts und z vom
// Betrachter weg bleibt fuer +y nur unten. Oben (-y) liegen CLK der Anzeige,
// TP1 und die USB-Buchse des XIAO.
// Die Platinenbeschreibung ../Platine/badspiegel-platine.toml zeigt die
// Modulseite, also die Ansicht von hinten, mit y nach unten (KiCad). tq()
// rechnet um: TOML-x laeuft hier gespiegelt, TOML-y bleibt. Darum liegen die
// Kabel (TOML x 127) hier links und die Anzeige (TOML x 35) rechts.
//
// DRUCK: Gehaeuse mit der Vorderseite aufs Bett, Deckel mit der Aussenseite,
// Klotz mit der Grundplatte. ABS, Prozess "Mk3s+ - eSUN Profil - ABS - 0,60",
// Mausohren 6 mm, Gehaeuseluefter aus.
// ============================================================

teil = "gehaeuse";

// ---- Aus dem alten Gehaeuse, gemessen am Original 14.08. und 25.10.2026 ----
korpus_breite     = 27.01;  // aussen im Bereich der Schiene
fluegel_dicke     = 2.00;   // buendig mit der Vorderseite
fluegel_ueber     = 3.495;  // je Seite, (34.00 - 27.01) / 2
fluegel_laenge    = 82.67;
fluegel_ab_rechts = 6.57;   // rechtes Ende bis Fluegelanfang
stirnwand         = 1.70;
wand              = 1.60;   // knapp drei Bahnen bei der 0,6er Duese
// Passung: Prueflinge 25.10.2026, Nr. 0 (kein Spiel) passt; wackelt das lange
// Gehaeuse, die Fluegeldicke um 0,1 erhoehen.
spiel             = 0;
// Ziffernmitte vom rechten Aussenende, wie das Probestueck sie zeigte: alte
// Laenge 96,79, blaue Anzeigenplatine im alten Modell bei x 26,14 bis 92,17,
// Ziffern 6,0 und 8,9 vom Platinenrand. Ergibt 39,09.
ziffern_mitte_ab_rechts = 96.79 - ((92.17 - 66.03 + 6.0) + (92.17 - 8.9)) / 2;
// Lage der Schraege wie im alten Modell (dort aus der blauen Anzeige, 27,21
// breit, Ziffern 0,5 hinter dem Glas). Bleibt fest, auch wenn die weisse
// Anzeige anders misst; sie liegt dann etwas tiefer oder hoeher.
innen_vorn   = korpus_breite - 2 * wand;              // 23,81
innen_hinten = 27.81;                                 // hinter der Schraege
z_sa = 0.5 + 10.05 - 1.6 - (27.21 - innen_vorn) / 2;  // 7,25 Schraegenanfang
z_se = z_sa + (innen_hinten - innen_vorn) / 2;        // 9,25 Schraegenende

// ---- Anzeige (weisse TM1637, Steckbrief Bauteile/tm1637-anzeige) ----
// Masse der weissen: Messschieber, 14.11.2026 (Steckbrief)
anz_breite   = 27.10;
anz_hoehe    = 9.57;   // Ziffernfront bis Platinenrueckseite
anz_pl       = 1.6;
anz_reihen   = [6.3, 63.7];  // Stiftreihen, TOML x (35 -+ 28,7, Footprint)
// Stiftreihe bis Rand 6 und 3 (Augenmass 14.11.; Summe passt zu Laenge 66,15
// minus Reihenabstand 57,4). Welches Ende welches ist, steht nicht fest, darum
// beide Enden mit dem groesseren Wert (Huelle 69,4 statt 66,15).
anz_rand_max = 6.0;
ziffern_l    = 66.15 - 9.20 - 6.01;   // 50,94: Laenge minus Kante bis Ziffernblock
ziffern_b    = 19.20;  // an der blauen; ANNAHME gleich bei der weissen
// Versatz der Ziffernmitte gegen die Mitte zwischen den Stiftreihen, positiv
// zur Kabelseite der Platine (hier nach links). Gemessen 0,1, also 0.
ziffern_versatz = 0;
// Chip 2,38 hoch (Ziffernfront bis Chip 11,95). Grundflaeche wie an der blauen,
// mittig: ANNAHME
anz_chip     = [14.6, 10.4, 2.38];
anz_loet     = 1.5;    // Loetstellen des Ziffernblocks hinten, ANNAHME
leiste_ks    = 2.54;   // Kunststoff der Stiftleiste zwischen Anzeige und Platine
leiste_luft  = 1.44;   // gemessen 4,01 und 3,95 bis zur Hauptplatine, Mittel 3,98
spalt_anzeige = leiste_ks + leiste_luft;

// ---- Hauptplatine Probe 4 ----
pl_l = 134.1;
pl_b = 27.0;
pl_d = 1.6;
pl_anzeige_xt = 35;    // Mitte der Anzeige in TOML-Koordinaten
// Stifte unter der Platine (XIAO, Pegelwandler, Wandler) buendig gekuerzt.
// Nicht einzeln gemessen. Der Chip der Anzeige liegt auf Kapton auf den
// Loetstellen des XIAO (14.11.2026), sie stehen also so weit vor, wie
// unter dem Chip Luft ist: 2,54 + 1,44 - 2,38 = 1,6.
stift_ueberstand = spalt_anzeige - anz_chip[2];

// ---- Module auf der Platine, Hoehe ueber der Platinenrueckseite ----
uhr_l = 38.62; uhr_b = 23.05;   // Uhrmodul, Messschieber 25.10.2026
// Hauptplatine bis Oberkante Zellenhalter 11,85 mit Zelle, Modul auf dem Klotz
// (14.11.2026). Geteilt in Luft und Dicke, damit der Klotz (3,3 hoch,
// schon gedruckt und eingeloetet) gleich bleibt.
uhr_dicke    = 11.55;
uhr_bauteile = 3.0;    // hoechstes Bauteil auf der Chipseite
uhr_luft     = 0.3;    // Chips ueber der Hauptplatine
uhr_spalt    = uhr_luft + uhr_bauteile;   // Hoehe des Klotzes, 3,3
xiao_h   = 6.71;           // mit USB-Buchse, gemessen 14.11.2026
wandler_h = 2.54 + 4.50;   // Modul 4,50 gemessen 25.10.2026
pegel_h  = 1.6 + 2.54 + 0.6;  // Modul liegt auf, Kunststoff oben; ANNAHME
c1_h     = 8.40;           // Elko stehend, gemessen 14.11.2026
// TP1 ist eine 4er-Buchsenleiste statt Stiftleiste (14.11.2026): kein
// blankes Metall, kein Kurzschluss beim Anklemmen. Gemessen 14.11.2026.
tp1_h    = 8.76;
kabel_d  = 3.0;            // gemessen

// ---- Antenne des XIAO (07.11.2026) ----
ant_l = 40; ant_b = 20;
ant_d = 0.5;       // ANNAHME, flache Folie
ant_kabel = 48;    // vom Stecker bis zum Anfang der Antennenflaeche

// ---- Gehaeuse ----
deckel       = 1.4;
deckel_luft  = 0.5;
front_dicke  = 1.2;   // vier Schichten zu 0,3
spalt_spiegel = 30;   // Spalt hinter dem Spiegel (31.10.2026)
tiefe_reserve = 1.0;
links_luft   = 2.0;   // Platinenende bis Stirnwand: Kabelbinder um die Stirnkante
pl_spiel     = 0.2;   // Laengsspiel an den Anschlaegen
druck_luft   = 0.2;   // Deckelfinger ueber der Platine

// ---- Abgeleitet ----
yv = innen_vorn / 2;
yi = innen_hinten / 2;
aussen_hinten = innen_hinten + 2 * wand;
z_anz  = z_sa + (anz_breite - innen_vorn) / 2;   // Vorderseite Anzeigenplatine
z_ziff = z_anz + anz_pl - anz_hoehe;             // Ziffernfront
z_pl   = z_anz + anz_pl + spalt_anzeige;         // Vorderseite Hauptplatine
zb     = z_pl + pl_d;                            // Rueckseite (Modulseite)
a_r    = ziffern_mitte_ab_rechts - pl_anzeige_xt - ziffern_versatz;  // Platine bis rechtes Ende
laenge = a_r + pl_l + links_luft + stirnwand;
x0     = laenge - a_r;      // hier liegt TOML x = 0 (rechtes Platinenende)
xl     = stirnwand;
xr     = laenge - stirnwand;
c1_oben  = zb + c1_h;
z_hinten = c1_oben + deckel_luft;   // Innenseite des Deckels
tiefe    = z_hinten + deckel;       // Aussentiefe an den Waenden
uhr_oben = zb + uhr_luft + uhr_dicke;

function hx(xt) = x0 - xt;
function hy(yt) = yt - pl_b / 2;
// Seite der Teile, die nur oben oder nur unten sitzen: +1 unten, -1 oben
function seite_von(yt) = hy(yt) > 0 ? 1 : -1;
function auf_seite(b, s) = s > 0 ? b : spiegel_y(b);
// Quader aus TOML-Koordinaten: [x0, x1, y0, y1, z0, z1], Grenzen aufsteigend
function tq(xt0, xt1, yt0, yt1, z0, z1) =
    [x0 - xt1, x0 - xt0, min(hy(yt0), hy(yt1)), max(hy(yt0), hy(yt1)), z0, z1];
function spiegel_y(b) = [b[0], b[1], -b[3], -b[2], b[4], b[5]];
function weg(b) = [b[0], b[1], b[2], b[3], b[4], 100];   // gerade nach hinten heraus
function ueberlappt(a, b) =
    a[0] < b[1] - 0.01 && b[0] < a[1] - 0.01 &&
    a[2] < b[3] - 0.01 && b[2] < a[3] - 0.01 &&
    a[4] < b[5] - 0.01 && b[4] < a[5] - 0.01;
function innen_halb(z) = z < z_sa ? yv : z < z_se ? yv + (z - z_sa) : yi;

// ============================================================
// Bestueckte Platine: alles, was zusammen von hinten hineingeht.
// Jeder Eintrag: [Name, Gruppe, Quader]. Gleiche Gruppe darf sich beruehren
// oder ueberlappen (ein Modul aus mehreren Quadern).
// ============================================================
anz_x = [anz_reihen[0] - anz_rand_max, anz_reihen[1] + anz_rand_max];   // Huelle beider Lagen
zc = pl_anzeige_xt + ziffern_versatz;
anzeige = [
  ["Anzeigenplatine", "anz", tq(anz_x[0], anz_x[1], pl_b/2 - anz_breite/2, pl_b/2 + anz_breite/2, z_anz, z_anz + anz_pl)],
  ["Ziffernblock", "anz", tq(zc - ziffern_l/2, zc + ziffern_l/2, pl_b/2 - ziffern_b/2, pl_b/2 + ziffern_b/2, z_ziff, z_anz)],
  ["Chip der Anzeige", "anz", tq(pl_anzeige_xt - anz_chip[0]/2, pl_anzeige_xt + anz_chip[0]/2,
      pl_b/2 - anz_chip[1]/2, pl_b/2 + anz_chip[1]/2, z_anz + anz_pl, z_anz + anz_pl + anz_chip[2])],
  ["Loetstellen Ziffern oben", "anz", tq(zc - ziffern_l/2, zc + ziffern_l/2, pl_b/2 - 9.6, pl_b/2 - 5.6, z_anz + anz_pl, z_anz + anz_pl + anz_loet)],
  ["Loetstellen Ziffern unten", "anz", tq(zc - ziffern_l/2, zc + ziffern_l/2, pl_b/2 + 5.6, pl_b/2 + 9.6, z_anz + anz_pl, z_anz + anz_pl + anz_loet)],
  for (r = anz_reihen) ["Stiftleiste Anzeige", "anz", tq(r - 1.27, r + 1.27, pl_b/2 - 5.08, pl_b/2 + 5.08, z_anz + anz_pl, z_pl)],
  for (r = anz_reihen) ["Anzeigestifte vorn", "anz", tq(r - 1.0, r + 1.0, pl_b/2 - 4.9, pl_b/2 + 4.9, z_anz - 1.5, z_anz)],
  for (r = anz_reihen) ["Anzeigestifte hinten", "anz", tq(r - 1.0, r + 1.0, pl_b/2 - 4.9, pl_b/2 + 4.9, zb, zb + 1.5)]   // ANNAHME 1,5 mm
];
// Uhrmodul, Footprint DS3231_ZS042_Sockel bei TOML (94,3 / 13,5), 4er-Reihe bei x 76,59
uhr_xt = [94.3 - uhr_l/2, 94.3 + uhr_l/2];   // 74,99 bis 113,61; 113,61 ist das freie Ende
uhr = [
  ["Uhrmodul mit Zellenhalter", "uhr", tq(uhr_xt[0], uhr_xt[1], pl_b/2 - uhr_b/2, pl_b/2 + uhr_b/2, zb + uhr_spalt, uhr_oben)],
  // ANNAHME: an beiden Enden 3,5 mm frei von Chips (dort 4er-Leiste und 6er-Reihe)
  ["Chips des Uhrmoduls", "uhr", tq(uhr_xt[0] + 3.5, uhr_xt[1] - 3.5, pl_b/2 - uhr_b/2 + 0.5, pl_b/2 + uhr_b/2 - 0.5, zb + uhr_luft, zb + uhr_spalt)],
  ["Stiftleiste Uhrmodul", "uhr", tq(76.59 - 1.27, 76.59 + 1.27, pl_b/2 - 5.08, pl_b/2 + 5.08, zb, zb + uhr_spalt)],
  ["Stummel 6er-Reihe", "uhr", tq(uhr_xt[1] - 2.9, uhr_xt[1] - 0.4, pl_b/2 - 7.9, pl_b/2 + 7.9, zb + uhr_spalt - 1.8, zb + uhr_spalt)]
];
// Klotz unter dem freien Ende: Grundplatte auf der Platine, zwei Pfosten unter
// den Ecken des Uhrmoduls (die Mitte bleibt frei fuer die Stummel der 6er-Reihe),
// aussen je eine Lippe am Modulende, die ihn beim Loeten in Lage haelt.
klotz_x  = [hx(uhr_xt[1]) + 0.2, hx(uhr_xt[1]) + 3.0];    // unter dem Modul
klotz_y  = [8.6, 11.3];
klotz_boden = 0.9;    // drei Schichten
// Lippe 1,2 mm dick (zwei Bahnen der 0,6er Duese) vor dem Modulende, mit einem
// Steg unter dem Modulende zum Pfosten. Nur bis |y| 10,0: auf der Seite von TP1
// steht ab |y| 10,33 dessen Stiftleiste. Die Grundplatte beginnt erst rechts von
// D2 und R3.
klotz_lippe = [hx(uhr_xt[1]) - 0.2 - 1.2, hx(uhr_xt[1]) - 0.2];
klotz_lippe_y = [klotz_y[0], 10.0];
klotz_platte_x0 = hx(115.4) + 0.9 + 0.6;    // 0,6 mm rechts der Loetaugen von D2 und R3
function klotz_paar(b) = [b, spiegel_y(b)];
klotz = [
  ["Klotz Grundplatte", "klotz", [klotz_platte_x0, klotz_x[1], -klotz_y[1], klotz_y[1], zb, zb + klotz_boden]],
  for (b = klotz_paar([klotz_x[0], klotz_x[1], klotz_y[0], klotz_y[1], zb, zb + uhr_spalt])) ["Klotz Pfosten", "klotz", b],
  for (b = klotz_paar([klotz_lippe[0], klotz_x[0], klotz_lippe_y[0], klotz_lippe_y[1], zb, zb + uhr_spalt])) ["Klotz Steg", "klotz", b],
  for (b = klotz_paar([klotz_lippe[0], klotz_lippe[1], klotz_lippe_y[0], klotz_lippe_y[1], zb + uhr_spalt, zb + uhr_spalt + 1.0])) ["Klotz Lippe", "klotz", b]
];
// Kabel J1 (12 V) und J2 (Joystick): Kabelbinder durch das 3-mm-Loch bei TOML
// (130,9 / 3,0 und 24,1) und um die Stirnkante der Platine, dann links durch die
// Stirnwand. Alles in TOML-Koordinaten: Loch bei yl, Loetaugen von ya bis yb.
function kabel_quader(n, g, yl, ya, yb) = [
  [str("Kabel bis zur Wand ", n), g, tq(130.9 - 1.7, x0 + 0.3, yl - kabel_d/2 - 0.2, yl + kabel_d/2 + 0.2, zb, zb + kabel_d + 0.2)],
  [str("Adern zu den Loetstellen ", n), g, tq(127.4 - 1.5, 130.9 + 1.9, min(yl, ya) - 1.7, max(yl, yb) + 1.4, zb, zb + kabel_d + 0.2)],
  [str("Kopf des Kabelbinders ", n), g, tq(130.9 - 1.9, 130.9 + 1.9, yl - 2.2, yl + 2.2, zb, zb + kabel_d + 2.5)],
  [str("Kabelbinder unter der Platine ", n), g, tq(130.9 - 1.5, pl_l + 1.2, yl - 1.7, yl + 1.7, z_pl - 1.0, z_pl)],
  [str("Kabelbinder um die Stirnkante ", n), g, tq(pl_l, pl_l + 1.2, yl - 1.7, yl + 1.7, z_pl - 1.0, zb + kabel_d + 0.5)]];
kabel = concat(kabel_quader("J1", "kabel1", 3.0, 6.5, 11.1), kabel_quader("J2", "kabel2", 24.1, 16, 20.6));
kabel_y = abs(hy(3.0));    // 10,5, Betrag; J2 liegt bei 10,6 auf der anderen Seite
// Liegendes Bauteil mit zwei Draehten (Widerstand, Diode) laengs in TOML x:
// Loetaugen samt Drahtbogen flach, der Koerper (Laenge l, Durchmesser d) in der Mitte
function axial(n, g, xa, xb, yt, l, d) = [
    [n, g, tq(xa - 0.9, xb + 0.9, yt - 0.9, yt + 0.9, zb, zb + 1.5)],
    [n, g, tq((xa + xb)/2 - l/2, (xa + xb)/2 + l/2, yt - d/2, yt + d/2, zb, zb + d + 0.3)]];
// Uebrige Module und Bauteile (TOML-Lagen und Footprints, siehe Kopf der TOML)
module_rest = [
  ["XIAO", "xiao", tq(34 - 8.75, 34 + 8.75, 13.5 - 10.5, 13.5 + 10.5, zb, zb + xiao_h)],
  ["USB-Buchse XIAO", "xiao", tq(34 - 4.5, 34 + 4.5, 13.5 - 10.5 - 1.3, 13.5 - 10.5, zb + 2.54, zb + xiao_h)],
  ["Antennenstecker XIAO", "xiao", tq(34 - 1.5, 34 + 1.5, 21.0, 24.5, zb + 2.54 + 1.0, zb + 2.54 + 3.5)],
  ["Wandler", "wandler", tq(52.1 - 8.48, 52.1 + 8.48, 12.25 - 11.475, 12.25 + 13.975, zb, zb + wandler_h)],
  ["Pegelwandler", "pegel", tq(16.5 - 7.835, 16.5 + 7.835, 13 - 7.65, 13 + 7.65, zb, zb + pegel_h)],
  ["C1 Elko", "c1", tq(64 - 2.5, 64 + 2.5, 4.9 - 2.5, 4.9 + 2.5, zb, c1_oben)],
  ["C2", "c2", tq(68.1, 73.1, 3.6 - 1.25, 3.6 + 1.25, zb, zb + 6.0)],
  ["D1", "d1", tq(67.4 - 1.35, 67.4 + 1.35, 12 - 1.0, 19.62 + 1.0, zb, zb + 3.0)],
  each axial("D2", "d2", 115.4, 123.02, 8.5, 5.2, 2.7),
  each axial("R1", "r1", 9.9, 17.52, 3.4, 6.3, 2.5),
  each axial("R2", "r2", 9.9, 17.52, 24.2, 6.3, 2.5),
  each axial("R3", "r3", 115.4, 123.02, 16, 6.3, 2.5),
  each axial("R4", "r4", 63.3, 70.92, 24.2, 6.3, 2.5),
  ["TP1", "tp1", tq(115.8 - 1.27, 123.42 + 1.27, 1.9 - 1.27, 1.9 + 1.27, zb, zb + tp1_h)],
  ["Hauptplatine", "pl", tq(0, pl_l, 0, pl_b, z_pl, zb)]
];
// Loetseite unter der Hauptplatine. Stifte buendig gekuerzt (stift_ueberstand);
// die anderen Loetstellen links stehen als flache Kegel 1,0 mm vor.
function stiftfeld(xt0, xt1, yt0, yt1, h) = tq(xt0, xt1, yt0, yt1, z_pl - h, z_pl);
unterseite = [
  for (x = [26.38, 41.62]) ["Stifte XIAO unten", "xiao", stiftfeld(x - 0.9, x + 0.9, 5.88 - 0.9, 21.12 + 0.9, stift_ueberstand)],
  for (x = [10.15, 22.85]) ["Stifte Pegelwandler unten", "pegel", stiftfeld(x - 1.0, x + 1.0, 6.65 - 1.0, 19.35 + 1.0, stift_ueberstand)],
  for (x = [45.21, 58.99], y = [2.575, 21.925]) ["Stifte Wandler unten", "wandler", stiftfeld(x - 1.0, x + 1.0, y - 1.0, y + 1.0, stift_ueberstand)],
  ["Loetstellen TP1", "tp1", stiftfeld(115.8 - 1.0, 123.42 + 1.0, 1.9 - 1.0, 1.9 + 1.0, 1.0)],
  ["Loetstellen D2", "d2", stiftfeld(115.4 - 1.0, 123.02 + 1.0, 8.5 - 1.0, 8.5 + 1.0, 1.0)],
  ["Loetstellen R3", "r3", stiftfeld(115.4 - 1.0, 123.02 + 1.0, 16 - 1.0, 16 + 1.0, 1.0)],
  ["Loetstellen J1", "kabel1", stiftfeld(127.4 - 1.3, 127.4 + 1.3, 6.5 - 1.3, 11.1 + 1.3, 1.0)],
  ["Loetstellen J2", "kabel2", stiftfeld(127.4 - 1.3, 127.4 + 1.3, 16 - 1.3, 20.6 + 1.3, 1.0)],
  ["Stifte Uhrmodul unten", "uhr", stiftfeld(76.59 - 1.0, 76.59 + 1.0, 9.69 - 1.0, 17.31 + 1.0, 1.0)]
];
bestueckung = concat(anzeige, uhr, klotz, kabel, module_rest, unterseite);

// ============================================================
// Gehaeuse: Einbauten als Quader. Alles wird mit dem Innenraum (0,2 mm in die
// Wand hinein) geschnitten, damit es mit der Wand verschmilzt.
// ============================================================
// Front: geschlossen bis auf das Fenster vor den Ziffern (2 mm Rand je Seite).
ziff_x  = [hx(zc + ziffern_l/2), hx(zc - ziffern_l/2)];
oeff_x  = [ziff_x[0] - 2.0, ziff_x[1] + 2.0];
front   = [[xl - 0.2, oeff_x[0], -yv - 0.2, yv + 0.2, 0, front_dicke],
           [oeff_x[1], xr + 0.2, -yv - 0.2, yv + 0.2, 0, front_dicke]];
// Leisten unter den Platinenkanten links, wo keine Anzeige darunter liegt. Ihre
// Unterseite ist die Schraege, also kein Ueberhang. Auf der Seite von TP1 (oben)
// ausgespart unter dessen Loetstellen.
anz_links = hx(anz_x[1]);              // linkes Ende der Anzeige (Huelle)
leiste_y  = [pl_b/2 - 1.0, yi + 0.2];  // 1,0 mm Auflage an der Platinenkante
tp1_frei  = [hx(123.42) - 1.3, hx(115.8) + 1.3];
tp1_seite = seite_von(1.9);
leisten = [auf_seite([xl - 0.2, tp1_frei[0], leiste_y[0], leiste_y[1], z_sa, z_pl], tp1_seite),
           auf_seite([tp1_frei[1], anz_links - 1.0, leiste_y[0], leiste_y[1], z_sa, z_pl], tp1_seite),
           auf_seite([xl - 0.2, anz_links - 1.0, leiste_y[0], leiste_y[1], z_sa, z_pl], -tp1_seite)];
// Querrippen unter der Platine. Die erste steht genau unter dem freien Ende des
// Uhrmoduls: Druck auf die Zelle geht ueber Klotz und Platine in diese Rippe.
quer_x  = [hx(uhr_xt[1]) + 1.0, hx(94.3), hx(uhr_xt[0]) - 6.0];
querrippen = [for (x = quer_x) [x - 0.8, x + 0.8, -yi - 0.2, yi + 0.2, front_dicke - 0.2, z_pl]];
// Anschlaege laengs: links zwei Rippen in der Mitte (aussen laufen die Kabelbinder
// um die Stirnkante), rechts ueber die ganze Breite bis unter den Deckel.
// Links haengt der Stirnwandhaken des Deckels genau ueber dem Anschlag. Bis
// 14.11.2026 war der Anschlag ein Block ueber |y| bis 5,0; er passte nur, solange
// der Deckel hoch genug lag (mit C1 8,40 statt 9,27 stiess die Hakenspitze 0,1 mm
// hinein). Darum bleibt die Mitte frei: Haken samt Federweg haben dort Platz,
// egal wie tief der Deckel liegt. 0,5 mm Luft wie am Hakenfenster.
haken_mitte_y = 2.5;     // Haken des Deckels links in der Stirnwand, halbe Breite
anschlag_l_y = [haken_mitte_y + 0.5, 5.0];
anschlag_l = [xl - 0.2, hx(pl_l) - pl_spiel, anschlag_l_y[0], anschlag_l_y[1], front_dicke - 0.2, zb + 1.0];
anschlag_r = [hx(0) + pl_spiel, xr + 0.2, -yi - 0.2, yi + 0.2, 0, z_hinten];
// Deckelauflagen: links zwei Pfeiler an der Stirnwand (zwischen Haken und
// Kabeln), rechts der Anschlag; dazwischen stehen Rippen und Finger des Deckels
// auf der Platine. Leisten an den Seitenwaenden gehen nicht: Anzeige (27,21) und
// Platine (27,0) muessen bei 27,81 innen von hinten daran vorbei.
pfeiler = [[xl - 0.2, xl + 0.8, 3.5, 8.3, front_dicke - 0.2, z_hinten],
           spiegel_y([xl - 0.2, xl + 0.8, 3.5, 8.3, front_dicke - 0.2, z_hinten])];
gehaeuse_teile = concat(front, leisten, querrippen, [anschlag_l, spiegel_y(anschlag_l), anschlag_r], pfeiler);

// ============================================================
// Deckel: Fenster ueber Uhrmodul und Testpunkten. Die Zelle rutscht zum freien
// Ende hin aus dem Halter (Shopfoto RBS10176) und kommt durchs Fenster heraus,
// ohne dass der Deckel abgeht.
// ============================================================
fenster_x = [11.5, hx(uhr_xt[0]) + 0.6];
// Spiel zum Uhrmodul: Platine wandert je Seite bis 0,405 mm, Deckel 0,2 mm
// (Gegenpruefung 07.11.2026), dazu Luft
fenster_y = 12.2;
haken_arm  = 8;
haken_dick = 1.2;
haken_nase = 0.6;   // ragt 0,4 ins Wandfenster: Biegedehnung 1,5 * 1,2 * 0,4 / 8^2 = 1,1 %
haken_halt = z_hinten - haken_arm + 1.0 + 0.7;   // Haltekante der Nase
// Seitenhaken: ein Paar gleich rechts vom Fenster, eins rechts vom Koerper von
// R1/R2 (der reicht bis 0,05 mm an den Federweg der Nase); links ein Haken
// mittig in der Stirnwand
r12_rechts = hx((9.9 + 17.52) / 2 - 6.3 / 2);
haken_seite_x = [[fenster_x[1] + 0.2, fenster_x[1] + 3.2], [r12_rechts + 0.3, r12_rechts + 4.3]];
schlitz_y = [kabel_y - kabel_d/2 - 0.5, kabel_y + kabel_d/2 + 0.9];   // 8,5 bis 12,9
schlitz_grund = zb - 0.2;
zunge_z  = zb + kabel_d + 0.4;      // Zunge beginnt ueber dem Kabel
// Deckelrippen und Finger druecken die Platinenkanten; die Rahmenrippen laufen
// neben dem Uhrmodul, die Finger rechts neben XIAO und am Platinenende.
rahmen_x = [hx(uhr_xt[1]) - 0.2, fenster_x[1]];
rahmenrippen = [[rahmen_x[0], rahmen_x[1], fenster_y, yi - 0.2, zb + druck_luft, z_hinten],
                spiegel_y([rahmen_x[0], rahmen_x[1], fenster_y, yi - 0.2, zb + druck_luft, z_hinten])];
finger_x = [[109.0, 112.0], [hx(0) - 5.0, hx(0) - 0.3]];
finger = [for (f = finger_x, s = [1, -1])
    s > 0 ? [f[0], f[1], 12.0, yi - 0.2, zb + druck_luft, z_hinten]
          : spiegel_y([f[0], f[1], 12.0, yi - 0.2, zb + druck_luft, z_hinten])];
// Haken als Quader fuer die Pruefung, samt dem Weg, den sie beim Einrasten nach
// innen federn (Nasenhoehe)
haken_quader = concat(
    [for (h = haken_seite_x, s = [1, -1])
        s > 0 ? [h[0], h[1], yi - 0.2 - haken_dick - haken_nase, yi - 0.2, z_hinten - haken_arm, z_hinten]
              : spiegel_y([h[0], h[1], yi - 0.2 - haken_dick - haken_nase, yi - 0.2, z_hinten - haken_arm, z_hinten])],
    [[xl + 0.2, xl + 0.2 + haken_dick + haken_nase, -haken_mitte_y, haken_mitte_y, z_hinten - haken_arm, z_hinten]]);
zungen = [[0, xl + 0.4, schlitz_y[0] + 0.2, schlitz_y[1] - 0.2, zunge_z, tiefe],
          spiegel_y([0, xl + 0.4, schlitz_y[0] + 0.2, schlitz_y[1] - 0.2, zunge_z, tiefe])];
// Antenne innen am Deckel ueber dem XIAO. Vier Eckwinkel halten sie in Lage, die
// Mitten der Seiten bleiben frei, damit das Kabel an jeder Seite austreten kann.
ant_x = [hx(34) - ant_l / 2, hx(34) + ant_l / 2];
antenne = [ant_x[0], ant_x[1], -ant_b/2, ant_b/2, z_hinten - ant_d, z_hinten];
eck = 6;   // Schenkellaenge; Schenkel 1,2 breit (zwei Bahnen), 0,8 hoch
ecken = [for (sx = [0, 1], sy = [-1, 1]) each [
    [sx == 0 ? ant_x[0] - 1.5 : ant_x[1] - eck, sx == 0 ? ant_x[0] + eck : ant_x[1] + 1.5,
     sy > 0 ? ant_b/2 + 0.3 : -ant_b/2 - 1.5, sy > 0 ? ant_b/2 + 1.5 : -ant_b/2 - 0.3, z_hinten - 0.8, z_hinten],
    [sx == 0 ? ant_x[0] - 1.5 : ant_x[1] + 0.3, sx == 0 ? ant_x[0] - 0.3 : ant_x[1] + 1.5,
     sy > 0 ? ant_b/2 - eck : -ant_b/2 - 1.5, sy > 0 ? ant_b/2 + 1.5 : -ant_b/2 + eck, z_hinten - 0.8, z_hinten]]];
deckel_teile = concat(rahmenrippen, finger, haken_quader, zungen, ecken);
// Deckelplatte als Quader (ohne Fenster), fuer die Pruefung gegen die Bestueckung
deckel_platte = [[xl + 0.2, fenster_x[0], -yi + 0.2, yi - 0.2, z_hinten, tiefe],
                 [fenster_x[1], xr - 0.2, -yi + 0.2, yi - 0.2, z_hinten, tiefe],
                 [fenster_x[0], fenster_x[1], fenster_y, yi - 0.2, z_hinten, tiefe],
                 spiegel_y([fenster_x[0], fenster_x[1], fenster_y, yi - 0.2, z_hinten, tiefe])];

// ============================================================
// Pruefungen
// ============================================================
// Jeder Quader mit aufsteigenden Grenzen. Ein verdrehter Quader schneidet nie
// etwas, jede Pruefung mit ihm waere still wirkungslos (passiert am 07.11.2026,
// als hy() die Richtung wechselte).
for (q = concat([for (b = bestueckung) [b[0], b[2]]], [for (r = gehaeuse_teile) ["Gehaeuseteil", r]],
                [for (d = concat(deckel_teile, deckel_platte)) ["Deckelteil", d]], [["Antenne", antenne]]))
    assert(q[1][0] < q[1][1] && q[1][2] < q[1][3] && q[1][4] < q[1][5], str("Quader verdreht: ", q[0], " ", q[1]));
tiefe_max = max(tiefe, uhr_oben);
assert(tiefe_max <= spalt_spiegel - tiefe_reserve,
       str("Gehaeuse ", tiefe_max, " mm tief, Spalt ", spalt_spiegel, " minus Reserve ", tiefe_reserve));
assert(laenge <= 230, str("laenger als der Einschubweg: ", laenge));
assert(z_ziff >= 0.2, str("Ziffern stossen ans Glas, z ", z_ziff));
assert(anz_breite <= innen_hinten - 0.2 && anz_breite >= innen_vorn + 0.5, "Anzeige passt nicht auf die Schraege");
assert(pl_b <= innen_hinten - 0.6, "Platine zu breit fuer den Innenraum");
// Die Schraege muss hinter der Schiene liegen (2 mm Reserve fuer eine Lippe)
assert(z_sa > fluegel_dicke + 2, "Schraege ragt in die Schiene");
// Ziffern im Frontfenster, mit 1 mm Rand
assert(oeff_x[0] <= ziff_x[0] - 1 && oeff_x[1] >= ziff_x[1] + 1, "Ziffern nicht im Frontfenster");
assert(abs((ziff_x[0] + ziff_x[1]) / 2 - (laenge - ziffern_mitte_ab_rechts)) < 0.01, "Ziffernmitte verschoben");
// Fluegel bleiben, wo sie waren
fluegel_x = laenge - fluegel_ab_rechts - fluegel_laenge;
assert(fluegel_x > xl, "Fluegel laenger als das Gehaeuse");
// Uhrmodul liegt ganz unter dem Deckelfenster
assert(fenster_x[0] <= hx(uhr_xt[1]) - 0.3 && fenster_x[1] >= hx(uhr_xt[0]) + 0.3 &&
       fenster_y >= uhr_b/2 + (innen_hinten - pl_b)/2 + 0.2 + 0.05,
       "Uhrmodul ragt unter den Deckel");
// Antennenkabel: Stecker am XIAO bis zur naechsten Kante der Antenne, plus Anstieg
ufl = [hx(34), hy(22.75), zb + 2.54 + 2.0];
ant_weg = max(0, ant_x[0] - ufl[0], ufl[0] - ant_x[1]) + max(0, -ant_b/2 - ufl[1], ufl[1] - ant_b/2)
          + (z_hinten - ufl[2]);
assert(ant_weg + 5 <= ant_kabel, str("Antennenkabel zu kurz, Weg ", ant_weg));

// Bestueckung: im Innenraum, nicht in der Front, nicht im Deckel, keine
// Ueberschneidung untereinander (ausser innerhalb einer Gruppe).
for (i = [0 : len(bestueckung) - 1]) {
    n = bestueckung[i][0]; g = bestueckung[i][1]; t = bestueckung[i][2];
    if (g != "kabel1" && g != "kabel2")
        assert(t[0] >= xl - 0.01 && t[1] <= xr + 0.01, str(n, " ragt in die Stirnwand"));
    assert(max(abs(t[2]), abs(t[3])) <= innen_halb(t[4]) + 0.01, str(n, " zu breit fuer seine Tiefe"));
    assert(t[4] >= 0, str(n, " ragt vorn heraus"));
    for (j = [i + 1 : len(bestueckung) - 1])
        if (bestueckung[j][1] != g)
            assert(!ueberlappt(t, bestueckung[j][2]), str(n, " ueberschneidet ", bestueckung[j][0]));
    for (r = gehaeuse_teile)
        assert(!ueberlappt(t, r), str(n, " ueberschneidet Gehaeuseteil ", r));
    for (r = concat(deckel_teile, deckel_platte))
        assert(!ueberlappt(t, r), str(n, " ueberschneidet Deckelteil ", r));
    // Einbauweg der bestueckten Platine: gerade von hinten hinein
    for (r = gehaeuse_teile)
        assert(!ueberlappt(weg(t), r), str("Einbauweg von ", n, " versperrt durch ", r));
}
// Kabel laufen im Schlitz durch die Stirnwand
for (k = kabel)
    if (k[2][0] < xl)
        assert(min(abs(k[2][2]), abs(k[2][3])) >= schlitz_y[0] - 0.01 &&
               max(abs(k[2][2]), abs(k[2][3])) <= schlitz_y[1] + 0.01 && k[2][4] >= schlitz_grund - 0.01,
               str(k[0], " trifft die Stirnwand neben dem Schlitz"));
// Deckel: seine Teile duerfen sich nicht mit dem Gehaeuse schneiden (die Haken
// federn an der Wand vorbei, die Waende stehen nicht in der Liste), und auf dem
// Weg des Deckels von hinten darf kein Teil der Bestueckung im Weg stehen.
for (d = deckel_teile) {
    for (r = gehaeuse_teile)
        assert(!ueberlappt(d, r), str("Deckelteil ", d, " schneidet Gehaeuseteil ", r));
    for (b = bestueckung)
        assert(!ueberlappt(weg(d), b[2]), str("Deckel kommt nicht an ", b[0], " vorbei: ", d));
}
// Antenne: nicht ueber Bauteilen
for (b = bestueckung)
    assert(!ueberlappt(antenne, b[2]), str("Antenne liegt auf ", b[0]));
// Zellenwechsel: Zelle (20 mm) rutscht im Halter um 22 mm zum freien Ende und
// kommt dann gerade durch das Deckelfenster heraus. ANNAHME: Zelle mittig im
// Modul, unterhalb der Oberkante des Halters.
zelle_x = hx(94.3);
zelle_z = [uhr_oben - 4.5, uhr_oben - 1.0];
zellenweg_rutsch = [zelle_x - 10 - 22, zelle_x + 10, -10, 10, zelle_z[0], zelle_z[1]];
zellenweg_heraus = weg([zelle_x - 10 - 22, zelle_x - 10, -10, 10, zelle_z[0], zelle_z[1]]);
for (b = bestueckung)
    if (b[1] != "uhr")
        assert(!ueberlappt(zellenweg_rutsch, b[2]) && !ueberlappt(zellenweg_heraus, b[2]),
               str("Zelle kommt nicht heraus, im Weg: ", b[0]));
for (d = concat(deckel_teile, deckel_platte))
    assert(!ueberlappt(zellenweg_rutsch, d) && !ueberlappt(zellenweg_heraus, d),
           str("Zelle kommt nicht durchs Deckelfenster, im Weg: ", d));
// Klotz traegt das freie Ende: Pfosten unter dem Modul, Rippe darunter
assert(klotz_x[0] >= hx(uhr_xt[1]) && klotz_x[1] <= hx(uhr_xt[1]) + 4, "Klotz nicht unter dem freien Ende");
assert(abs(quer_x[0] - (klotz_x[0] + klotz_x[1]) / 2) < 1.0, "Querrippe nicht unter dem Klotz");

echo(str("Laenge ", laenge, " mm, Tiefe an den Waenden ", tiefe, ", mit Zellenhalter ", tiefe_max,
         ", Platine vorn bei z ", z_pl, ", Deckel innen bei z ", z_hinten));

// ============================================================
// Geometrie
// ============================================================
module laengs(l) { rotate([90, 0, 90]) linear_extrude(height = l) children(); }
module quader(t) { translate([t[0], t[2], t[4]]) cube([t[1] - t[0], t[3] - t[2], t[5] - t[4]]); }

module aussenprofil(h) {
    polygon([[-korpus_breite/2, 0], [korpus_breite/2, 0], [korpus_breite/2, z_sa],
             [aussen_hinten/2, z_se], [aussen_hinten/2, h], [-aussen_hinten/2, h],
             [-aussen_hinten/2, z_se], [-korpus_breite/2, z_sa]]);
}
// 0,3 mm ueber vorn und hinten hinaus, damit keine koplanare Flaeche bleibt
module innenprofil(h) {
    polygon([[-yv, -0.3], [yv, -0.3], [yv, z_sa], [yi, z_se], [yi, h + 0.3],
             [-yi, h + 0.3], [-yi, z_se], [-yv, z_sa]]);
}
module innenraum_plus() {
    translate([xl - 0.2, 0, 0]) laengs(laenge - 2 * xl + 0.4) offset(delta = 0.2) innenprofil(tiefe);
}

module rumpf(h) {
    difference() {
        laengs(laenge) aussenprofil(h);
        translate([xl, 0, 0]) laengs(laenge - 2 * xl) innenprofil(h);
    }
    for (s = [-1, 1])
        translate([fluegel_x, s > 0 ? korpus_breite/2 - 0.1 : -korpus_breite/2 - fluegel_ueber + spiel, 0])
            cube([fluegel_laenge, fluegel_ueber - spiel + 0.1, fluegel_dicke - spiel]);
}

hakenfenster_z = [z_hinten - haken_arm - 0.3, haken_halt + 0.15];

module gehaeuse(h = tiefe) {
    difference() {
        union() {
            rumpf(h);
            intersection() {
                innenraum_plus();
                for (t = gehaeuse_teile) quader(t);
            }
        }
        // Fenster fuer die Hakennasen, zum Loesen von aussen mit dem Fingernagel
        for (hk = haken_seite_x, s = [1, -1])
            translate([hk[0] - 0.5, s > 0 ? yi - 0.3 : -aussen_hinten/2 - 0.3, hakenfenster_z[0]])
                cube([hk[1] - hk[0] + 1.0, wand + 0.6, hakenfenster_z[1] - hakenfenster_z[0]]);
        translate([-0.3, -haken_mitte_y - 0.5, hakenfenster_z[0]])
            cube([xl + 0.6, 2 * haken_mitte_y + 1.0, hakenfenster_z[1] - hakenfenster_z[0]]);
        // Kabelschlitze links, zum Deckel hin offen
        for (s = [1, -1])
            translate([-0.3, s > 0 ? schlitz_y[0] : -schlitz_y[1], schlitz_grund])
                cube([xl + 0.6, schlitz_y[1] - schlitz_y[0], 40]);
        // Kennung auf der oberen Aussenwand (-y), 0,6 tief
        translate([16, -aussen_hinten/2 + 0.6, (z_se + tiefe) / 2]) rotate([90, 0, 0])
            linear_extrude(1) text("Uhr P4 ABS", size = 6, font = "Liberation Sans:style=Bold", halign = "left", valign = "center");
    }
}

// Seitenhaken: Arm, Nase mit Rampe zur Spitze und Haltekante zum Deckel hin
module seitenhaken(h) {
    for (s = [1, -1]) mirror([0, s > 0 ? 0 : 1, 0]) {
        translate([h[0], yi - 0.2 - haken_dick, z_hinten - haken_arm]) cube([h[1] - h[0], haken_dick, haken_arm + 0.01]);
        translate([h[0], 0, 0]) rotate([90, 0, 90]) linear_extrude(h[1] - h[0])
            polygon([[yi - 0.2, z_hinten - haken_arm], [yi - 0.2 + haken_nase, z_hinten - haken_arm + 1.0],
                     [yi - 0.2 + haken_nase, haken_halt], [yi - 0.2, haken_halt]]);
    }
}

module deckel_einbau() {
    difference() {
        translate([xl + 0.2, -yi + 0.2, z_hinten]) cube([xr - xl - 0.4, 2 * yi - 0.4, deckel]);
        translate([fenster_x[0], -fenster_y, z_hinten - 0.3]) cube([fenster_x[1] - fenster_x[0], 2 * fenster_y, deckel + 0.6]);
    }
    for (t = concat(rahmenrippen, finger, zungen, ecken)) quader(t);
    for (h = haken_seite_x) seitenhaken(h);
    // Haken links in der Stirnwand, Nase nach aussen (-x)
    translate([xl + 0.2, -haken_mitte_y, z_hinten - haken_arm]) cube([haken_dick, 2 * haken_mitte_y, haken_arm + 0.01]);
    translate([0, haken_mitte_y, 0]) rotate([90, 0, 0]) linear_extrude(2 * haken_mitte_y)
        polygon([[xl + 0.2, z_hinten - haken_arm], [xl + 0.2 - haken_nase, z_hinten - haken_arm + 1.0],
                 [xl + 0.2 - haken_nase, haken_halt], [xl + 0.2, haken_halt]]);
}

module klotz_teil() {
    for (k = klotz) quader(k[2]);
}

if (teil == "gehaeuse") gehaeuse();
if (teil == "probe") intersection() { gehaeuse(); translate([-1, -30, -1]) cube([laenge + 2, 60, 13 + 1]); }
// Deckel zum Drucken: Aussenseite aufs Bett, Haken zeigen nach oben
if (teil == "deckel") translate([0, 0, tiefe]) rotate([180, 0, 0]) deckel_einbau();
// Klotz zum Drucken: Grundplatte aufs Bett
if (teil == "klotz") translate([-klotz_lippe[0], 0, -zb]) klotz_teil();
if (teil == "belegung") {
    %gehaeuse();
    color("gray", 0.5) deckel_einbau();
    farben = [["anz", "gold"], ["uhr", "royalblue"], ["klotz", "red"], ["kabel1", "black"], ["kabel2", "black"],
              ["xiao", "purple"], ["wandler", "teal"], ["pegel", "orange"], ["pl", "darkgreen"]];
    for (b = bestueckung) {
        f = [for (p = farben) if (p[0] == b[1]) p[1]];
        color(len(f) > 0 ? f[0] : "silver") quader(b[2]);
    }
    color("white") quader(antenne);
}
