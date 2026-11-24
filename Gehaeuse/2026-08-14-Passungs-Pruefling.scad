// ============================================================
// Passungs-Pruefling fuer die Einschubschiene im Badspiegel
//
// Das ist NICHT das fertige Gehaeuse, sondern nur eine 10 mm dicke
// Scheibe vom Querschnitt, dreimal nebeneinander mit unterschiedlichem
// Spiel. Zweck: in zwanzig Minuten Druckzeit herausfinden, welches Mass
// in die Schiene passt, statt nach zwei Stunden Druck zu merken, dass
// es klemmt oder wackelt.
//
// So gehts: alle drei drucken, der Reihe nach in die Schiene schieben.
// Der beste ist der, der ohne Gewalt hineingeht und nicht von selbst
// wieder herausfaellt. Seine Nummer steht eingepraegt auf der Stirnseite.
// Diese Nummer sagst du mir, dann baue ich das Gehaeuse mit dem Wert.
//
// DRUCKAUSRICHTUNG: stehend, so wie die Datei es anlegt. Dadurch ist
// jede Druckschicht exakt der Querschnitt, den wir pruefen wollen.
// Liegend gedruckt waere die Hoehe durch die Schichtdicke gerastert und
// die Messung waere nichts wert.
// Ohne Support, ohne Brim. Falls die erste Schicht breiter ausfaellt
// (Elefantenfuss), im Slicer die Elefantenfuss-Korrektur einschalten.
// ============================================================

// ---- Gemessen am Original, 14.08.2026, Messschieber ----
korpus_breite = 27.01;   // Gehaeuse aussen, breite Seite
korpus_hoehe  = 17.54;   // Gehaeuse aussen, flache Seite
wand          = 1.52;    // Wandstaerke, direkt gemessen
fluegel_dicke = 2.00;    // Dicke der seitlichen Fluegel

// Ueberstand je Seite, gerechnet aus zwei Messungen: ueber die
// Fluegelspitzen 34.00, ueber den Korpus 27.01, Differenz halbiert.
fluegel_ueberstand = 3.495;

// Die Fluegel schliessen buendig mit der Displayseite ab (16.08.2026). Ihre Mitte liegt also eine halbe Fluegeldicke unter der
// Oberkante.
fluegel_mitte_ab_display = fluegel_dicke / 2;

// ---- Pruefling-Einstellungen ----
pruefling_laenge = 10;      // Scheibendicke, reicht zum Einschieben
spiel_liste      = [0, 0.15, 0.30];  // je Seite, wird vom Mass abgezogen
abstand          = 8;       // Luecke zwischen den Prueflingen auf dem Bett

// ============================================================

// Querschnitt als 2D-Profil. spiel wird auf JEDER Seite abgezogen,
// die Aussenmasse schrumpfen also um das Doppelte.
module profil(spiel) {
    difference() {
        union() {
            square([korpus_breite - 2*spiel, korpus_hoehe - 2*spiel], center = true);
            // Fluegel links und rechts. Die Displayseite liegt hier oben,
            // also in +y, deshalb wird der Abstand von dort abgezogen.
            for (seite = [-1, 1])
                translate([seite * (korpus_breite - 2*spiel) / 2,
                           korpus_hoehe/2 - fluegel_mitte_ab_display])
                    square([2 * fluegel_ueberstand, fluegel_dicke - 2*spiel],
                           center = true);
        }
        // Hohlraum. Nur damit der Pruefling sich aehnlich verformt wie
        // das spaetere Gehaeuse und nicht als Vollklotz alles aufweitet.
        square([korpus_breite - 2*spiel - 2*wand,
                korpus_hoehe  - 2*spiel - 2*wand], center = true);
    }
}

module pruefling(spiel, nummer) {
    difference() {
        linear_extrude(height = pruefling_laenge) profil(spiel);
        // Nummer als Kerben im rechten Fluegel: 0, 1 oder 2 Kerben.
        // Bis 25.10.2026 stand hier eine eingepraegte Ziffer in der Mitte,
        // die lag im Hohlraum und kam nie aufs Teil.
        for (k = [0 : nummer - 1])
            translate([(korpus_breite - 2*spiel)/2 + 1 + k * 1.5,
                       korpus_hoehe/2 - fluegel_dicke - 0.5, pruefling_laenge - 1.5])
                cube([0.8, fluegel_dicke + 1, 2]);
    }
}

for (i = [0 : len(spiel_liste) - 1])
    translate([i * (korpus_breite + abstand), 0, 0])
        pruefling(spiel_liste[i], i);
