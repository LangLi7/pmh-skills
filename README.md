# pmh-skills — Skill-Inhalte als eigenes Repository

> **Was hier liegt:** Fähigkeiten im `SKILL.md`-Format, die **nicht** zum Kern gehören und
> **nicht** im Prometheus-Harness-Repository versioniert werden. Ein eigener Ort, eine eigene
> Historie.
>
> **Entschieden am 21.10.2026:** Skill-Inhalte liegen in einem eigenen Repo und werden als
> **vierte Skill-Wurzel** eingehängt; echte Code-Units (Plugins, Bibliotheken) bleiben als
> Package im Monorepo, weil sie Typecheck und Tests brauchen.

## Aufbau

```
units/skills/
├── README.md                 ← diese Datei
├── LICENSE                   ← MIT des übernommenen Skills
├── THIRD_PARTY_LICENSES.md   ← Hinweise auf Drittbestandteile
└── diagram-design/           ← ein Ordner je Fähigkeit
    ├── SKILL.md              ← Pflicht: Frontmatter (name, description, license)
    ├── references/           ← Nachschlagewerk, wird bei Bedarf gelesen
    ├── scripts/              ← ausführbare Helfer
    └── assets/               ← Bilder und Vorlagen
```

**Regel:** ein Ordner = eine Fähigkeit, `SKILL.md` als Pflichtdatei. Kein rekursives Suchen —
`skill-filesystem` liest **direkte** Kinder der Wurzel.

## Bestand

| Fähigkeit | Herkunft | Lizenz | Stand | Umfang |
|---|---|---|---|---|
| `diagram-design` | [cathrynlavery/diagram-design](https://github.com/cathrynlavery/diagram-design) | MIT | v2.6, geklont 21.10.2026 | 287 Dateien, 5,13 MB |

**Was `diagram-design` kann:** 45 Diagrammtypen als in sich geschlossene HTML-Datei mit
Inline-SVG (Architektur, Sequenz, ER, Zustand, Swimlane, Quadrant, Wardley, Sankey, Gantt,
Explosionsaxonometrie …), dazu Import und Neuzeichnen aus draw.io, Mermaid und Excalidraw mit
Fidelity-Ledger. Kein Mermaid im Output, 4px-Raster. Python nur für Export (PNG) und
Selbstprüfung.

**Warum es hier liegt:** Es schließt die Lücke **L4** aus
[`docs/bestand/checkup-skills-plugins.md`](../../docs/bestand/checkup-skills-plugins.md) — PMH
hat sechs Design-Skills und keinen einzigen Diagramm-Skill.

## Einhängen als vierte Wurzel

Der Anbieter `packages/skill/skill-filesystem` liest Wurzeln mit Rang 100–600. Diese Wurzel
kommt **zusätzlich** zu Projekt-, Benutzer- und Bündel-Skills dazu; der Rang entscheidet nur
bei Namensgleichheit.

| Wurzel | Rang | Wo |
|---|---|---|
| Projekt (`<repo>/.agents/skills`) | 100 | im Harness-Repository |
| Laufzeit (registriert) | 250 | zur Laufzeit |
| **Diese Wurzel (`units/skills`)** | **300** | **dieses Repository** |
| Benutzer (`<home>/skills`) | 400 | Benutzerverzeichnis |
| Bündel (mitgeliefert) | 600 | im Kern |

**Der Stand ist gemessen, nicht behauptet:** `diagram-design` ist **geladen** — der Katalog der
Sitzung führt ihn, und das `skill`-Werkzeug liefert seinen Rumpf samt Ressourcenpfad. Der Weg
ist eine **Junction** im Benutzer-Scope (Rang 400), keine Kopie:

```
~\.agents\skills\diagram-design   →   units\skills\diagram-design
```

Der Kern-Anbieter liest den Benutzer-Scope ohnehin; die Registry hat den Katalog **ohne
Neustart** neu gelesen.

**Die vierte Wurzel (Rang 300) bleibt offen.** Sie braucht `skill-plugin` in
`scripts/profile-patch.mjs` (`EIGENE_PAKETE`), und dieses Einhängen ist bisher **ungemessen**
(siehe `docs/status/skill-uebertragung.md` §6). Sie ist damit Architektur, nicht Voraussetzung.

## Auf einem neuen Rechner: die Junction wiederherstellen

Die Junction liegt außerhalb des Repos und ist deshalb **nicht versioniert**. Ohne sie ist ein
Skill vorhanden, aber nicht geladen. Ein Befehl genügt:

```powershell
.\link-skills.ps1
```

Das Skript legt für jeden Ordner mit `SKILL.md` eine Junction im Benutzer-Scope an, überspringt
vorhandene und sagt, was es getan hat. Es **kopiert nichts** — der Inhalt bleibt an einem Ort.

## Lizenz und Herkunft

Der Skill ist MIT-lizenziert; die `LICENSE` liegt unverändert daneben. `THIRD_PARTY_LICENSES.md`
nennt Drittbestandteile. **Bei jeder Aktualisierung** wird die Quelle im Commit genannt
(Commit-Hash des Upstream), damit nachvollziehbar bleibt, welcher Stand übernommen wurde.

## Was hier nicht liegt

- **Code-Units** (Plugins, Bibliotheken wie `pretext`) — sie brauchen Typecheck und Tests und
  bleiben als Package im Monorepo.
- **Der Kern** — er wird nie umgeschrieben (`MAPPING.md`, `docs/decisions/core-supply.md`).
- **Kopien von Skills, die schon im Benutzer-Scope liegen** — eine Kopie wäre eine zweite Quelle
  der Wahrheit.
