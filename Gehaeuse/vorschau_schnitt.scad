// Schnittbild fuer vorschau.py: wird hinter ein include von gehaeuse.scad gehaengt.
// sx = x des Querschnitts, -1 = Laengsschnitt bei y = 0. Farben wie bei "belegung".
sx = 43.5;
module scheibe() {
    if (sx >= 0) translate([sx - 0.05, -40, -5]) cube([0.1, 80, 50]);
    else translate([-5, -0.05, -5]) cube([200, 0.1, 50]);
}
schnitt_farben = [["anz", "gold"], ["uhr", "royalblue"], ["klotz", "red"], ["kabel1", "black"], ["kabel2", "black"],
                  ["xiao", "purple"], ["wandler", "teal"], ["pegel", "orange"], ["pl", "darkgreen"]];
color("lightgray") intersection() { gehaeuse(); scheibe(); }
color("dimgray") intersection() { deckel_einbau(); scheibe(); }
for (b = bestueckung) {
    f = [for (p = schnitt_farben) if (p[0] == b[1]) p[1]];
    color(len(f) > 0 ? f[0] : "silver") intersection() { quader(b[2]); scheibe(); }
}
color("white") intersection() { quader(antenne); scheibe(); }
// Wand hinter dem Spiegel
color("red") if (sx >= 0) translate([sx - 0.05, -20, spalt_spiegel]) cube([0.1, 40, 0.3]);
             else translate([-5, -0.05, spalt_spiegel]) cube([150, 0.1, 0.3]);
