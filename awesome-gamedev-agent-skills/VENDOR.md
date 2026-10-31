# Herkunft dieses Bestands

Vendored Kopie von **awesome-gamedev-agent-skills** — 76 Game-Dev-Skills plus Router.

| Feld | Wert |
|---|---|
| Upstream | https://github.com/gamedev-skills/awesome-gamedev-agent-skills |
| Commit | `184b72be02884f782a0058f2eeae2ce4277453e4` (`main`, Klon vom 27.10.2026) |
| Lizenz | Apache-2.0 (siehe [`LICENSE`](LICENSE), [`NOTICE`](NOTICE)) |
| Umfang | 76 Fähigkeiten unter `skills/`, ein Router unter `router/` |

## Aufbau

```
awesome-gamedev-agent-skills/
├── router/              ← Einstieg: erkennt Engine und Aufgabe, wählt Skills
│   ├── SKILL.md
│   ├── agents/
│   └── references/
├── skills/
│   ├── godot/           ← 16    unity/  ← 8     unreal/ ← 6
│   ├── web-engines/     ← 6     other-engines/ ← 11
│   ├── disciplines/     ← 15    genres/ ← 9     workflows/ ← 4
│   └── ebitengine/      ← 1
├── docs/                ← SKILL-FORMAT, INSTALLATION, COMPATIBILITY, VERSION-SUPPORT
├── README.md            ← Upstream-README, unverändert
├── LICENSE              ← Apache-2.0
└── NOTICE
```

Der Baum bleibt **wie im Upstream**, weil `router/SKILL.md` repo-relative Pfade nennt
(`skills/godot/…`). Ein flaches Ausrollen würde diese Verweise brechen.

## Wie die Skills geladen werden

Der Katalog liest **direkte Kinder** einer Skill-Wurzel. Deshalb liegt jeder Skill als eigene
Junction im Benutzer-Scope, nicht der Sammelordner:

```
~\.agents\skills\godot-2d-movement   →   units\skills\awesome-gamedev-agent-skills\skills\godot\godot-2d-movement
~\.agents\skills\router              →   units\skills\awesome-gamedev-agent-skills\router
```

`units\skills\link-skills.ps1` legt diese Verbindungen an — wiederholbar, ohne zu kopieren.

## Nicht übernommen

- `docs/assets/` (1,9 MB Banner-PNG, nur für das Upstream-README)
- `.github/`, `tests/`, `scripts/`, `templates/`, `.claude-plugin/` — Werkzeug des Upstream-Repos,
  nicht Teil der Fähigkeiten
- `.git/` — der Stand steht oben als Commit-Hash

## Aktualisieren

```powershell
$tmp = "$env:TEMP\gamedev-skills"
if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force }
git clone --depth 1 https://github.com/gamedev-skills/awesome-gamedev-agent-skills.git $tmp
# skills/, router/, docs/*.md, LICENSE, NOTICE, README.md erneut übernehmen
# Commit-Hash und Datum in dieser Datei nachziehen
```

Nach dem Übernehmen `link-skills.ps1` erneut laufen lassen; es überspringt vorhandene Junctions.
