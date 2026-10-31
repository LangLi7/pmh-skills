# Herkunft dieses Bestands

Sechs Fähigkeiten aus drei Fremd-Repositories — die Motion-Lücke, die nach dem Einspielen von
`ui-skills` und `iart-motion-skills` geblieben ist. Ausgewählt aus dem `motion`-Katalog von
`ui-skills.com`, der 107 Einträge fremder Autoren bündelt.

| Fähigkeit | Upstream | Commit | Lizenz |
|---|---|---|---|
| `animate` | emilkowalski/skills | `2d228630` | MIT |
| `review-animations` | ebd. | `2d228630` | MIT |
| `improve-animations` | ebd. | `2d228630` | MIT |
| `find-animation-opportunities` | ebd. | `2d228630` | MIT |
| `transitions-dev` | Jakubantalik/transitions-dev | `038b0bdc` | MIT |
| `userinterface-wiki` | raphaelsalaja/userinterface-wiki | `256a9540` | MIT |

Registry-Stand, aus dem die Auswahl stammt: `ibelick/ui-skills` @ `59193a75` (25.10.2026).

## Was jede Fähigkeit tut

| Fähigkeit | Rolle |
|---|---|
| `animate` | baut eine Animation von Null: ob überhaupt, wozu, welches Werkzeug, welche Eigenschaften, welche Kurve, wie unterbrechbar, wie der Ausstieg läuft. Schreibt die Umsetzung. |
| `review-animations` | prüft vorhandene Animations- und Motion-Dateien gegen eine hohe Qualitätslatte; Standard ist „beanstanden", Freigabe muss verdient werden. |
| `improve-animations` | führt ein Codebase-Audit als Motion-Berater durch und liefert priorisierte, selbstständig ausführbare Umsetzungspläne. Liest nur, ändert nichts. |
| `find-animation-opportunities` | sucht Stellen, die nicht animieren, es aber sollten — und verwirft alles, was nur Lärm wäre. Schreibt exakte Werte, setzt nicht um. |
| `transitions-dev` | zwölf produktionsreife CSS-Übergänge als Vorlagen: Card-Resize, Number-Pop, Notification-Badge, Text-Swap, Dropdown, Modal, Panel, Page-Slide, Icon-Swap, Success-Check, Avatar-Group, Error-Shake. |
| `userinterface-wiki` | 152 Regeln in 12 Kategorien (Timing, Easing, Federn, Typografie, Fokus, Audio …) mit `file:line`-Befunden. |

## Die Lizenz-Ausweichung, offen benannt

Der `motion`-Katalog nennt für zwei Einträge `raphaelsalaja/skill`:
`12-principles-of-animation` und `to-spring-or-not-to-spring`. Dieses Repository hat
**keine Lizenz** — kein `LICENSE`, keine Angabe in `README.md`, laut GitHub-API `license: none`.
Ohne Lizenz gilt Standardurheberrecht; fremde Dateien daraus zu übernehmen wäre keine
Übernahme, sondern eine Kopie ohne Recht.

Deshalb steht statt dieser beiden die **offizielle, MIT-lizenzierte Fassung desselben Autors**
im Bestand: `raphaelsalaja/userinterface-wiki` (`skills/SKILL.md`, 152 Regeln, MIT, 933 Sterne).
Sie deckt dieselben Themen ab — Federn (15 Treffer), Easing, Dauer, Unterbrechbarkeit — und ist
vom Autor selbst als Paket für Agenten veröffentlicht.

**Was das nicht ist:** eine 1:1-Kopie der beiden Einzeldateien. Wer die exakten Dateien will,
muss die Lizenzfrage selbst entscheiden; ohne Freigabe des Autors hole ich sie nicht.

## Aufbau

```
ui-motion-picks/
├── skills/
│   ├── animate/                     SKILL.md + RECIPES.md
│   ├── review-animations/           SKILL.md + STANDARDS.md
│   ├── improve-animations/          SKILL.md + AUDIT.md + PLAN-TEMPLATE.md
│   ├── find-animation-opportunities/ SKILL.md
│   ├── transitions-dev/             SKILL.md + 12 Vorlagen + _root.css
│   └── userinterface-wiki/          SKILL.md
├── LICENSE-emilkowalski             MIT, Copyright Emil Kowalski
├── LICENSE-transitions-dev          MIT, Copyright Jakub Antalík
├── LICENSE-userinterface-wiki.md    MIT, Copyright Raphael Salaja
└── VENDOR.md                        diese Datei
```

Die Beidateien (`RECIPES.md`, `STANDARDS.md`, `AUDIT.md`, `PLAN-TEMPLATE.md`, die zwölf
Übergangsvorlagen) sind **nicht** Beiwerk: die `SKILL.md` verweist relativ darauf
(`RECIPES.md`, `01-card-resize.md`). Ein Ausrollen nur der `SKILL.md` würde diese Verweise
brechen, deshalb liegt jeder Ordner vollständig.

## Wie die Skills geladen werden

```
~\.agents\skills\animate        →  units\skills\ui-motion-picks\skills\animate
~\.agents\skills\transitions-dev →  units\skills\ui-motion-picks\skills\transitions-dev
```

`units\skills\link-skills.ps1` legt die Junctions an; `ui-motion-picks` steht in
`$collectionen`. Nachgemessen mit dem Frontmatter-Parser des Kerns: **6 von 6** laden.

**Ein Sonderfall:** `review-animations` trägt upstream `disable-model-invocation: true`. Der
Kern kennt den Schlüssel und übernimmt ihn — die Fähigkeit ist damit **nur menschlich**
aufrufbar und erscheint nicht im Modell-Katalog. Das ist die Absicht des Autors (eine Prüfung
soll man anfordern), keine Fehlfunktion.

## Aktualisieren

```powershell
$tmp = "$env:TEMP\motion-picks"
git clone --depth 1 https://github.com/emilkowalski/skills.git "$tmp\emil"
git clone --depth 1 https://github.com/Jakubantalik/transitions-dev.git "$tmp\transitions"
# skills/<name>/ samt Beidateien erneut übernehmen, LICENSE je Quelle nachziehen
# Commit-Hashes und Datum in dieser Datei nachziehen
.\link-skills.ps1
```
