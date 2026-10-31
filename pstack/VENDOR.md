# Herkunft dieses Bestands

Vendored Kopie von **pstack** — 58 Fähigkeiten für strenge Engineering-Abläufe, zwei Agenten
und die zugehörige Doku.

| Feld | Wert |
|---|---|
| Upstream | https://github.com/cursor/plugins/tree/main/pstack |
| Commit | `519d36aa98955bf680db01bcde5fdfba686dc901` (`main`, Klon vom 27.10.2026) |
| Version | `0.15.34` (aus [`plugin.json`](plugin.json)) |
| Autorin | Lauren Tan ([poteto](https://x.com/poteto)) |
| Lizenz | MIT (siehe [`LICENSE`](LICENSE)) |
| Umfang | 58 Fähigkeiten unter `skills/`, 3 unter `automations/benny/skills/`, 2 Agenten, 10 Kapitel Doku |

## Aufbau

```
pstack/
├── skills/            ← 58 Fähigkeiten, je ein Ordner mit SKILL.md
│   ├── poteto-mode/   ← Einstieg: der rigide Arbeitsablauf
│   ├── setup-pstack/  ← einmalig: Modellwahl je Rolle
│   ├── principle-*/   ← 26 Prinzipien (Namensschema `principle-…`)
│   └── …              ← architect, arena, swarm, tdd, unslop, why, how …
├── agents/            ← poteto-agent.md, comment-sicko.md
├── automations/       ← benny: Cursor-Automation, bringt 3 eigene Fähigkeiten mit
│   └── benny/skills/  ← reproduce-and-fix-issues, setup-benny, triage-issue-reports
├── docs/
│   ├── guide/         ← 01-setup … 10-recipes-and-pitfalls, mit Bildern
│   └── harness/       ← claude-code.md: Zuordnung der Cursor-Namen
├── plugin.json        ← Upstream-Manifest, unverändert
├── .cursor-plugin/    ← Cursor-Metadaten, unverändert
├── README.md          ← Upstream-README, unverändert
└── LICENSE            ← MIT
```

Der Baum bleibt **wie im Upstream**, weil die Skills relative Pfade nennen
(`../../docs/harness/claude-code.md`, `references/…`). Ein flaches Ausrollen würde diese
Verweise brechen.

## Wie die Skills geladen werden

Der Katalog liest **direkte Kinder** einer Skill-Wurzel. Deshalb liegt jeder Skill als eigene
Junction im Benutzer-Scope, nicht der Sammelordner:

```
~\.agents\skills\poteto-mode   →   units\skills\pstack\skills\poteto-mode
~\.agents\skills\architect     →   units\skills\pstack\skills\architect
```

`units\skills\link-skills.ps1` legt diese Verbindungen an — wiederholbar, ohne zu kopieren.
Nachgemessen mit dem Frontmatter-Parser des Kerns (`packages/skill/skill-filesystem`): **58 von
58** Dateien unter `skills/` laden, Namen stimmen mit den Ordnernamen überein. Eingehängt sind
**61** Junctions — die 58 plus die 3 aus `automations/benny/skills/`.

## Aufruf-Schalter

pstack markiert 57 der 58 Fähigkeiten aus `skills/` (und alle 3 aus `automations/`) mit
`disable-model-invocation: true`. Der Kern kennt diesen Schlüssel und übernimmt ihn: diese
Fähigkeiten ruft **nur der Mensch** auf, das Modell sieht sie nicht als Werkzeug. Einzige
Ausnahme ist `setup-pstack` — die Einrichtung darf das Modell vorschlagen.

## Zwei Namenskollisionen

`tdd` und `teach` liegen bereits als Fähigkeiten im Projekt-Scope dieses Repositories
(`.agents/skills/`, aus `mattpocock/skills`). Der Kern löst Namensgleichheit über den Rang:
Projekt-Scope (200) gewinnt gegen Benutzer-Scope (500).

| Name | In diesem Repository | Außerhalb dieses Repositories |
|---|---|---|
| `tdd` | `mattpocock/skills` (Test-Referenz) | pstack (Bug-Fix-TDD) |
| `teach` | `mattpocock/skills` | pstack |

Das ist keine Fehlfunktion, aber es ist eine stille: die pstack-Variante ist hier nicht
erreichbar. Wer beide braucht, hängt die pstack-Fassung unter eigenem Namen ein und zieht
`name:` im Frontmatter nach.

## Grenze: pstack ist Cursor-first

Die Skills sind für Cursor geschrieben. Sie nennen Werkzeuge und Pfade, die es in anderen
Harnesses nicht gibt:

| Was die Skills voraussetzen | Im Harness |
|---|---|
| `Task`, `AskQuestion` | Subagenten und `ask_user_question` — Namen weichen ab |
| `~/.cursor/rules/pstack-models.mdc` | fehlt; `/setup-pstack` schreibt dorthin |
| Bugbot, Automations, `api2.cursor.sh` | nicht vorhanden; betroffene Schritte entfallen |
| Slash-Aufruf `/name` | Fähigkeit als Datei lesen und befolgen |

Upstream liefert eine Zuordnung nur für Claude Code (`docs/harness/claude-code.md`). Für den
Harness gibt es sie **nicht** — die Übersetzung der Werkzeugnamen passiert im Betrieb, nicht in
dieser Kopie. Die Abläufe selbst (Prinzipien, `poteto-mode`, `architect`, `swarm`, `unslop`)
sind harness-neutral formuliert und davon nicht betroffen.

**Gemessen, nicht behauptet:** Das `skill`-Werkzeug antwortet auf eine der 60 nur menschlich
aufrufbaren Fähigkeiten mit `skill "poteto-help" is not available for model invocation`. Das ist
die beabsichtigte Wirkung des Schlüssels. Der Weg bleibt trotzdem offen und ist derselbe, den
das Claude-Code-Adapter beschreibt: die `SKILL.md` lesen und befolgen.

```
~/.agents/skills/poteto-mode/SKILL.md
```

## Nicht übernommen

- `.git/` — der Stand steht oben als Commit-Hash

Alles andere, auch `.cursor-plugin/` und `plugin.json`, bleibt unverändert liegen: es ist
Herkunftsnachweis, kein Ladepfad.

## Aktualisieren

```powershell
$tmp = "$env:TEMP\pstack"
if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force }
git clone --depth 1 --filter=blob:none --sparse https://github.com/cursor/plugins.git $tmp
git -C $tmp sparse-checkout set pstack
# pstack/ erneut über units/skills/pstack/ kopieren
# Commit-Hash, Version und Datum in dieser Datei nachziehen
.\link-skills.ps1
```
