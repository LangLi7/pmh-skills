# Herkunft dieses Bestands

Vendored Kopie von **UI Skills** — neun Fähigkeiten für Design-Engineering, darunter die
Motion-Fähigkeit der Seite `ui-skills.com/skills/motion`.

| Feld | Wert |
|---|---|
| Upstream | https://github.com/ibelick/ui-skills |
| Commit | `59193a75432e5f41c6980f53b9e6a7bd56919947` (`main`, Klon vom 27.10.2026) |
| Lizenz | MIT (siehe [`LICENSE`](LICENSE)) |
| Umfang | 9 Fähigkeiten unter `skills/`, 11 Dateien |

## Aufbau

```
ui-skills/
├── skills/
│   ├── baseline-ui/               ← UI-Grundordnung: Abstände, Hierarchie, Typografie
│   ├── component-canvas/          ← Vollbild-Canvas über vorhandenen Komponenten
│   ├── create-canvas/             ← freies Canvas zum Vergleichen und Iterieren
│   ├── create-design-md/          ← DESIGN.md aus Repo oder Website ableiten
│   ├── fixing-accessibility/      ← ARIA, Fokus, Kontrast, Formularfehler
│   ├── fixing-metadata/           ← Titel, Open Graph, JSON-LD, Canonicals
│   ├── fixing-motion-performance/ ← Ruckeln, Layout-Thrashing, Compositor, Blur
│   ├── improve-ui/                ← Prüfung gegen die eigene Design-Evidenz, Pläne
│   └── ui-skills-root/            ← Einstieg: welchen Kontext als Erstes laden
├── README.md                      ← Upstream-README, unverändert
└── LICENSE                        ← MIT
```

Nur der Ordner `skills/` wird geladen; `src/`, `bin/`, `migrations/` sind die Website und die
CLI des Upstreams und bleiben draußen.

## Warum nur diese neun

`ui-skills.com` ist **kein Skill-Repo, sondern ein Katalog über fremde Skills**: 437 Einträge in
`src/data/registry.ts`, davon 107 mit dem Thema `motion`. Diese Einträge verweisen per
`rawUrl` auf andere Repositories (greensock, emilkowalski, remotion-dev, iart-ai und weitere).
Im geklonten Repo liegen nur die neun eigenen Fähigkeiten als Dateien vor — sie sind der
tatsächliche Inhalt dieses Repositories.

Der `motion`-Katalog wurde vollständig durchgesehen, aber **nicht** übernommen: 23 der 107
Namen liegen bereits als Fähigkeit vor (aus `iart-motion-skills`, `motion-design` und
`emil-design-eng`), und viele der übrigen sind inhaltliche Dubletten (etwa `greensock/gsap-core`
neben `gsap-web`). Das Laden aller 107 würde den Katalog des Harness aufblähen, ohne neue
Fähigkeit zu bringen.

## Wie die Skills geladen werden

```
~\.agents\skills\fixing-motion-performance  →  units\skills\ui-skills\skills\fixing-motion-performance
```

`units\skills\link-skills.ps1` legt die Junctions an; `ui-skills` steht in `$collectionen`.
Nachgemessen mit dem Frontmatter-Parser des Kerns: **9 von 9** laden, Namen stimmen mit den
Ordnernamen überein. Keine der neun trägt `disable-model-invocation` — sie sind auch für das
Modell aufrufbar.

## Abweichungen vom Upstream

**Keine.** Alle Dateien sind unverändert. Insbesondere `fixing-metadata` behält seine
mehrzeilige `description:` im YAML-Block (`>`); der Parser des Kerns liest sie korrekt.

## Nicht übernommen

- `src/`, `bin/`, `migrations/`, `tests/`, `public/`, `scripts/`, `wrangler.jsonc` — Website und
  CLI des Upstreams
- `skills/ui-skills-root` ist mit übernommen: es ist der Einstieg, der erst den kleinsten
  nützlichen Kontext wählt, statt alles zu laden

## Aktualisieren

```powershell
$tmp = "$env:TEMP\ui-skills"
if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force }
git clone --depth 1 https://github.com/ibelick/ui-skills.git $tmp
# skills/, LICENSE, README.md erneut übernehmen
# Commit-Hash und Datum in dieser Datei nachziehen
.\link-skills.ps1
```
