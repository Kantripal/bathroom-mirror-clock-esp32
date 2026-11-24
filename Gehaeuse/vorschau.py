#!/usr/bin/env python3
"""Vorschau des Gehaeuses als lokale HTML-Seite: drehbares 3D-Modell (Gehaeuse,
Deckel, alle Teile der Bestueckung als Quader) und Schnittbilder.

Aufruf: python3 vorschau.py ZIELORDNER DATUM
Legt in ZIELORDNER die Seite DATUM-Gehaeuse-P4-Vorschau.html und die Bilder
DATUM-Gehaeuse-P4-*.png an. Die Seite laedt three.js von cdnjs, sonst nichts aus
dem Netz; die Modelle stehen in der Datei selbst.
"""
import base64, json, re, struct, subprocess, sys, tempfile
from pathlib import Path

HIER = Path(__file__).resolve().parent
SCAD = HIER / "gehaeuse.scad"


def openscad(args, scad):
    r = subprocess.run(["openscad", "--backend", "Manifold", *args, str(scad)],
                       capture_output=True, text=True)
    if "ERROR" in r.stderr or r.returncode != 0:
        sys.exit(f"OpenSCAD meldet einen Fehler:\n{r.stderr}")
    return r.stderr


def stl_binaer_b64(pfad):
    """ASCII-STL in Binaer-STL wandeln (ein Viertel der Groesse), als base64."""
    text = Path(pfad).read_text()
    dreiecke = re.findall(r"vertex\s+(\S+)\s+(\S+)\s+(\S+)\s+vertex\s+(\S+)\s+(\S+)\s+(\S+)\s+"
                          r"vertex\s+(\S+)\s+(\S+)\s+(\S+)", text)
    daten = bytearray(80) + struct.pack("<I", len(dreiecke))
    for d in dreiecke:
        daten += struct.pack("<12fH", 0, 0, 0, *map(float, d), 0)
    return base64.b64encode(bytes(daten)).decode()


def main():
    ziel, datum = Path(sys.argv[1]), sys.argv[2]
    tmp = Path(tempfile.mkdtemp())
    hilfe = tmp / "hilfe.scad"
    hilfe.write_text(f'include <{SCAD}>\n'
                     'if (zeige == "deckel") deckel_einbau();\n'
                     'echo(boxen = [for (b = bestueckung) [b[0], b[1], b[2]]], antenne = antenne, laenge = laenge);\n')
    openscad(["-o", str(tmp / "g.stl"), "-D", 'teil="gehaeuse"'], SCAD)
    echo = openscad(["-o", str(tmp / "d.stl"), "-D", 'teil="keins"', "-D", 'zeige="deckel"'], hilfe)
    m = re.search(r"ECHO: boxen = (\[.*\]), antenne = (\[.*?\]), laenge = (\S+)", echo)
    boxen, antenne, laenge = json.loads(m.group(1)), json.loads(m.group(2)), float(m.group(3))

    # Schnittbilder und Ansichten, gerendert mit Farben
    schnitt = tmp / "schnitt.scad"
    schnitt.write_text(f'include <{SCAD}>\n' + (HIER / "vorschau_schnitt.scad").read_text())
    bilder = [
        ("laengs", "Laengsschnitt in der Mitte: Glas unten, Wand (rot) oben", "2000,560", "71,-110,15,71,0,15", "-1"),
        ("uhrmodul", "Querschnitt durch das Uhrmodul", "900,900", "123.5,0,15,43.5,0,15", "43.5"),
        ("xiao", "Querschnitt durch XIAO und Anzeige", "900,900", "183.8,0,15,103.8,0,15", "103.8"),
    ]
    for name, _, gr, kam, sx in bilder:
        openscad(["--render", "-o", str(ziel / f"{datum}-Gehaeuse-P4-Schnitt-{name}.png"), f"--imgsize={gr}",
                  "--colorscheme=Tomorrow", "--projection=o", f"--camera={kam}", "-D", 'teil="keins"',
                  "-D", f"sx={sx}"], schnitt)
    ansichten = [("hinten", "gehaeuse", "35,0,15"), ("deckel", "deckel", "35,0,20"), ("klotz", "klotz", "50,0,35")]
    for name, teil, rot in ansichten:
        openscad(["--render", "-o", str(ziel / f"{datum}-Gehaeuse-P4-{name}.png"), "--imgsize=1600,900",
                  "--colorscheme=Tomorrow", "--viewall", "--autocenter", "--projection=p",
                  f"--camera=0,0,0,{rot},0", "-D", f'teil="{teil}"'], SCAD)

    seite = (HIER / "vorschau_vorlage.html").read_text()
    seite = (seite.replace("__GEHAEUSE__", stl_binaer_b64(tmp / "g.stl"))
                  .replace("__DECKEL__", stl_binaer_b64(tmp / "d.stl"))
                  .replace("__BOXEN__", json.dumps(boxen))
                  .replace("__ANTENNE__", json.dumps(antenne))
                  .replace("__LAENGE__", f"{laenge:.2f}")
                  .replace("__DATUM__", datum))
    seite = seite.replace("__BILDER__", "\n".join(
        f'<figure><img src="{datum}-Gehaeuse-P4-Schnitt-{n}.png" alt="{t}"><figcaption>{t}</figcaption></figure>'
        for n, t, *_ in bilder) + "\n" + "\n".join(
        f'<figure><img src="{datum}-Gehaeuse-P4-{n}.png" alt="{n}"><figcaption>{t}</figcaption></figure>'
        for n, t in [("hinten", "Gehaeuse von hinten, ohne Deckel"), ("deckel", "Deckel, Innenseite"),
                     ("klotz", "Klotz unter dem freien Ende des Uhrmoduls")]))
    out = ziel / f"{datum}-Gehaeuse-P4-Vorschau.html"
    out.write_text(seite)
    print(out)


if __name__ == "__main__":
    main()
