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

**307 Fähigkeiten** (gezählt am 27.10.2026, davon 61 aus `pstack`, 9 aus `ui-skills`, 6 aus
`ui-motion-picks`, 2 aus `brag` und 1 aus `prompt-engineering-skill`), aus zwölf Quellen. Die
Zahl steht nicht für Qualität — sie steht für Rollen, die vorher leer waren.

Die erste Tabelle beschreibt den Ursprungsbestand (21 Fähigkeiten); die später ergänzten
Sammlungen stehen darunter.

### Recherche und Wissenschaft (11)

| Fähigkeit | Herkunft | Lizenz | Läuft |
|---|---|---|---|
| `deep-research` | Imbad0202/academic-research-skills | **CC BY-NC 4.0** | Netz |
| `academic-paper` | ebd. | **CC BY-NC 4.0** | Pandoc/LaTeX für Export |
| `academic-paper-reviewer` | ebd. | **CC BY-NC 4.0** | keine |
| `academic-pipeline` | ebd. | **CC BY-NC 4.0** | koordiniert die drei oben |
| `sr-screener` | ebd. | **CC BY-NC 4.0** | keine |
| `literature-review` | K-Dense-AI/scientific-agent-skills | MIT | Netz (PubMed, arXiv, Semantic Scholar) |
| `paper-lookup` | ebd. | MIT | Netz, 18 APIs, keine Schlüssel |
| `citation-management` | ebd. | MIT | Netz (OpenAlex, PubMed, Scholar) |
| `peer-review` | ebd. | MIT | keine |
| `market-research-reports` | ebd. | MIT | keine |
| `parallel-web` | ebd. | MIT | **Parallel-CLI 0.9.3**, installiert |

### Werkzeuge und Plattformen (1)

| Fähigkeit | Herkunft | Lizenz | Läuft |
|---|---|---|---|
| `agent-reach` | Panniantong/agent-reach | MIT | **CLI installiert**; Kanäle noch nicht (`agent-reach doctor` → „No channels installed") |

### Qualität und Entscheidungen (3)

| Fähigkeit | Herkunft | Lizenz | Rolle |
|---|---|---|---|
| `architecture-decision-records` | affaan-m/ecc | MIT | Entscheidung mit Kontext, Alternativen, Folgen — die ADR-Rolle |
| `eval-harness` | ebd. | MIT | Evals vor dem Code, pass@k und pass^k — die Lücke **L6** |
| `agent-eval` | ebd. | MIT | Vergleich von Agenten auf eigenen Aufgaben |

### Sicherheit (5)

| Fähigkeit | Herkunft | Lizenz | Richtung |
|---|---|---|---|
| `analyzing-sbom-for-supply-chain-vulnerabilities` | mukul975/…-CyberSecurity-Skills | Apache-2.0 | defensiv: SBOM gegen NVD |
| `building-detection-rules-with-sigma` | ebd. | Apache-2.0 | defensiv: portable Detection-Regeln |
| `analyzing-supply-chain-malware-artifacts` | ebd. | Apache-2.0 | defensiv: Lieferketten-Vorfälle |
| `offensive-api-security` | SnailSploit/claude-red | MIT | offensiv: OWASP API Top 10 |
| `offensive-ai-security` | ebd. | MIT | offensiv: Prompt-Injection, Modellangriffe |

**Vorbehalt zu den zwei offensiven Skills:** Sie sind Dual-Use. Aufgenommen, weil `security-audit`
nur *Anleitung* ist und die Prüfung einer eigenen API eine Methode braucht — nicht als Werkzeug
gegen fremde Systeme. Wer sie einsetzt, prüft Auftrag und Ziel selbst.

### Gestaltung (1)

| Fähigkeit | Herkunft | Lizenz | Umfang |
|---|---|---|---|
| `diagram-design` | cathrynlavery/diagram-design | MIT | 287 Dateien, 45 Diagrammtypen, Python für Export und Selbsttest |

### Spieleentwicklung (76 + Router)

| Sammlung | Herkunft | Lizenz | Umfang |
|---|---|---|---|
| `awesome-gamedev-agent-skills/` | gamedev-skills/awesome-gamedev-agent-skills | **Apache-2.0** | 76 Fähigkeiten + Router, 12 Engines |

Ein Baum, keine 76 Einzelordner: der Router nennt repo-relative Pfade (`skills/godot/…`), ein
flaches Ausrollen würde sie brechen. Geladen werden die Skills trotzdem einzeln — jede Fähigkeit
liegt als eigene Junction im Benutzer-Scope:

```
~\.agents\skills\godot-2d-movement  →  ...\awesome-gamedev-agent-skills\skills\godot\godot-2d-movement
~\.agents\skills\router             →  ...\awesome-gamedev-agent-skills\router
```

| Gruppe | Anzahl | Inhalt |
|---|---|---|
| Engine-Skills | 48 | Godot 16, Unity 8, Unreal 6, Web-Engines 6, andere Engines 11, Ebitengine 1 |
| Disziplinen | 15 | Asset-Produktion, Game-AI, Prozedurales, Dialog, Speichern, Audio, Shader, Physik, Level, Input, Game-Feel, UI/UX, Kamera, Performance |
| Genres | 9 | Platformer, Roguelike, RPG, FPS, Tower Defense, Kartenspiel, Visual Novel, Survival, Puzzle |
| Workflows | 4 | Game Jam, schneller Prototyp, Steam, itch.io |

Herkunft, Commit-Hash, Umfang und der Weg zum Aktualisieren stehen in
[`awesome-gamedev-agent-skills/VENDOR.md`](awesome-gamedev-agent-skills/VENDOR.md).

### Design-Engineering (9)

| Sammlung | Herkunft | Lizenz | Umfang |
|---|---|---|---|
| `ui-skills/` | ibelick/ui-skills | MIT | 9 Fähigkeiten: Motion-Performance, UI-Audit, DESIGN.md, Accessibility, Metadaten |

`ui-skills.com` ist **ein Katalog über fremde Fähigkeiten**, kein Skill-Repo: 437 Einträge,
davon 107 mit dem Thema `motion`. Im Repository liegen nur diese neun als Dateien vor; der Rest
verweist per `rawUrl` auf andere Projekte (greensock, emilkowalski, remotion-dev, iart-ai und
weitere). Übernommen sind deshalb die neun — die Motion-Seite wurde vollständig durchgesehen,
aber nicht als Sammlung eingehängt: 23 der 107 Namen liegen bereits als Fähigkeit vor, viele
weitere sind inhaltliche Dubletten (etwa `greensock/gsap-core` neben `gsap-web`).

**Nebenbefund, gemessen:** Der Katalog, den das Modell im Prompt sieht, hat eine Obergrenze.
Während dieser Sitzung sind Fähigkeiten daraus verschwunden, als ein anderer Prozess 56
Motion-Fähigkeiten einhängte. Ein pauschales Einhängen aller 107 würde also andere Fähigkeiten
verdrängen, ohne eine neue hinzuzugewinnen.

Herkunft, Commit und Aktualisierungsweg stehen in [`ui-skills/VENDOR.md`](ui-skills/VENDOR.md).

### Launchvideo (2)

| Sammlung | Herkunft | Lizenz | Umfang |
|---|---|---|---|
| `brag/` | latent-spaces/brag | MIT, Medien darunter CC BY 4.0 / CC0 | 2 Fähigkeiten, 13 MB mitgelieferte Musik |

`brag` macht aus dem aktuellen Projekt ein kurzes Launch-Video — Story, Motion, Musik und
Share-Copy — und rendert es über Hyperframes. `brag-slim` ist die Einzeldatei-Fassung ohne
Hyperframes und ohne mitgelieferte Assets; derselbe Einstieg, anderer Weg.

Die beiden Fähigkeiten sind jetzt geladen (`brag`, `brag-slim`). Die Laufzeit ist geprüft:
`npx hyperframes doctor` meldet Version 0.8.207, Node 24, FFmpeg, Chrome und Docker in Ordnung.
Zwei echte Lücken bleiben: der Rechner hatte beim Test **1,6 GB freien Arbeitsspeicher** (der
Doctor warnt vor fehlschlagenden Renders), und **Kokoro fehlt** — `--voice` braucht
`pip install kokoro-onnx soundfile`.

Herkunft, Lizenzen der Musik (Namensnennung nötig) und der Aktualisierungsweg stehen in
[`brag/VENDOR.md`](brag/VENDOR.md); die Prüftabelle der Voraussetzungen steht dort ebenfalls.

### Prompt-Engineering (1)

| Fähigkeit | Herkunft | Lizenz | Rolle |
|---|---|---|---|
| `prompt-engineering` | PhAlves23/prompt-engineering-skill | MIT | schreibt Prompts um statt sie auszuführen: Diagnose, kanonische Struktur, Technikwahl, Änderungsprotokoll |

Der Skill war für Claude Code gebaut und ist für den Harness angepasst: Zielmodell ist die
Sitzungsroute statt Claude 4.x, die Werkzeuge heißen `read`, `subagent`, `ask_user_question`
statt `Read`, `Task`, `AskUserQuestion`, und ein eigener Abschnitt beschreibt die Nutzung für
die Crew. Die Anpassung ist klein und lückenlos dokumentiert —
[`prompt-engineering-skill/VENDOR.md`](prompt-engineering-skill/VENDOR.md) führt jede geänderte
Datei und jede bewusst nicht übernommene.

Gedacht für den `planner` und die Rollen-Prompts der Crew: die Texte, die andere Agenten
ausführen, sind Prompts und werden von diesem Skill schärfer. Die Crew-Skills selbst bleiben
unangetastet — sie gehören dem Paket `@deepseek-ai/dsh-llm-crew`, nicht diesem Bestand.

### Motion-Nachlese (6)

| Fähigkeit | Herkunft | Lizenz | Rolle |
|---|---|---|---|
| `animate` | emilkowalski/skills | MIT | Animation von Null bauen, Entscheidungen in der richtigen Reihenfolge |
| `review-animations` | ebd. | MIT | vorhandene Motion gegen eine hohe Latte prüfen; **nur menschlich aufrufbar** |
| `improve-animations` | ebd. | MIT | Codebase-Audit mit priorisierten Umsetzungsplänen, liest nur |
| `find-animation-opportunities` | ebd. | MIT | Stellen finden, die animieren sollten — und den Rest verwerfen |
| `transitions-dev` | Jakubantalik/transitions-dev | MIT | zwölf fertige CSS-Übergänge mit Vorlagen |
| `userinterface-wiki` | raphaelsalaja/userinterface-wiki | MIT | 152 Regeln in 12 Kategorien, Befunde mit `file:line` |

Diese sechs schließen die Lücke, die der `motion`-Katalog von `ui-skills.com` offen ließ (107
fremde Einträge, 23 davon schon vorhanden). Ausgewählt wurden die, die inhaltlich wirklich
fehlten.

**Eine Lizenz-Ausweichung, die benannt bleiben muss:** Der Katalog nennt für
`12-principles-of-animation` und `to-spring-or-not-to-spring` das Repository
`raphaelsalaja/skill` — **ohne Lizenz**. Ohne Lizenz gilt Standardurheberrecht; diese beiden
Dateien sind deshalb nicht übernommen. Statt ihrer steht die offizielle, MIT-lizenzierte
Fassung desselben Autors im Bestand: `userinterface-wiki`, die Federn, Easing und Dauer
abdeckt.

Herkunft, Commits und die Begründung stehen in
[`ui-motion-picks/VENDOR.md`](ui-motion-picks/VENDOR.md).

### Motion Design und Animation (56)

| Sammlung | Herkunft | Lizenz | Umfang |
|---|---|---|---|
| `motion-design` | LottieFiles/motion-design-skill | MIT | Motion-Grundlagen: Timing, Easing, Choreografie, Disney-Prinzipien für UI |
| `iart-motion-skills/` | iart-ai/motion-skills (19 Pack-Repos) | MIT | 55 Fähigkeiten: Web-Animation, WebGL, Manim, Remotion, Video-Packs |

`motion-design` ist ein einzelner, in sich geschlossener Skill (`director/`, `patterns/`,
`reference/` als Unterordner) und liegt deshalb flach wie jeder andere Skill. Stand:
`f9a8a04` (`main`, LottieFiles/motion-design-skill).

`iart-ai/motion-skills` ist dagegen **kein** Skill-Repo, sondern der Katalog über 19 Pack-Repos —
der Klon enthält keinen `SKILL.md`. Übernommen sind alle 19 Packs, je Pack als eigener Ordner
mit `skills/<name>/`; die 55 Einzelfähigkeiten liegen als Junctions im Benutzer-Scope. Eine
Fassung wurde ausgelassen (`tiktok-video-skills/skills/lower-thirds`, doppelter Name), Gründe
und Nachrüstweg stehen in [`iart-motion-skills/VENDOR.md`](iart-motion-skills/VENDOR.md).

### Engineering-Abläufe (58)

| Sammlung | Herkunft | Lizenz | Umfang |
|---|---|---|---|
| `pstack/` | cursor/plugins → `pstack` (Lauren Tan) | MIT | 58 Fähigkeiten + 3 Automatisierungs-Skills, 2 Agenten, 10 Kapitel Doku |

`pstack` ist das Original, nicht ein Fork: Lauren Tan (poteto) pflegt es im offiziellen
Plugin-Repository von Cursor. Von dort stammt es, nicht aus einem der zahlreichen Nachbauten
(`pstack-claude`, `open-pstack`, `pstack-codex` …).

Der Baum bleibt wie im Upstream (`skills/`, `agents/`, `docs/`, `automations/`); geladen wird
jede Fähigkeit einzeln über eine Junction im Benutzer-Scope. **57 der 58** Fähigkeiten tragen
`disable-model-invocation: true` — der Kern kennt den Schlüssel und übernimmt ihn, sie sind
also nur menschlich aufrufbar; nur `setup-pstack` darf das Modell vorschlagen.

Zwei Namen kollidieren mit dem Projekt-Scope: `tdd` und `teach` liegen bereits aus
`mattpocock/skills` vor und gewinnen dort über den Rang. Die pstack-Fassung ist **in diesem
Repository** damit nicht erreichbar, außerhalb schon. Herkunft, Commit, Aktualisierungsweg und
die Cursor-Abhängigkeiten (Task, AskQuestion, `~/.cursor/rules/pstack-models.mdc`) stehen in
[`pstack/VENDOR.md`](pstack/VENDOR.md).



`units/design-md/` — **84 `DESIGN.md`-Dateien** aus `VoltAgent/awesome-design-md` (MIT), plus
Index. Sie sind **kein Skill** (keine `SKILL.md`-Struktur), sondern Nachschlagewerk für
Marken- und Oberflächenentscheidungen. Wer sie nutzt, liest sie; der Katalog führt sie nicht.

---

**Was die Research-Skills können:** `literature-review` führt systematische, scoping- und
narrative Literaturreviews über PubMed, arXiv, bioRxiv und Semantic Scholar mit dokumentierter
Suchabdeckung; `paper-lookup` durchsucht 18 wissenschaftliche APIs und liefert reproduzierbare
Provenienz; `citation-management` prüft Zitate gegen OpenAlex/PubMed und erzeugt BibTeX;
`peer-review` erstellt evidenzgebundene Gutachten; `market-research-reports` baut
nachvollziehbare Marktforschung mit TAM/SAM/SOM; `parallel-web` deckt Websuche und
Tiefenrecherche ab; `deep-research` ist die 13-Agenten-Pipeline mit acht Modi.

**Was `diagram-design` kann:** 45 Diagrammtypen als in sich geschlossene HTML-Datei mit
Inline-SVG (Architektur, Sequenz, ER, Zustand, Swimlane, Quadrant, Wardley, Sankey, Gantt,
Explosionsaxonometrie …), dazu Import und Neuzeichnen aus draw.io, Mermaid und Excalidraw mit
Fidelity-Ledger. Kein Mermaid im Output, 4px-Raster. Python nur für Export (PNG) und
Selbstprüfung.

**Lizenzhinweis, der bleiben muss:** Die fünf `academic-*`-Skills stehen unter **CC BY-NC 4.0**
— Namensnennung, **keine kommerzielle Nutzung**. Die `LICENSE-CC-BY-NC-4.0.md` liegt daneben.
Wer PMH kommerziell betreibt, muss diese fünf entfernen oder lizenzieren. Alle übrigen sind
MIT oder Apache-2.0.

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
