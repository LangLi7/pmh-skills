# Herkunft dieses Bestands

Vendored Kopie von **prompt-engineering** — ein Skill, der Prompt-Entwürfe umschreibt statt sie
auszuführen: Diagnose, kanonische Struktur, Technikwahl nach Aufgabenart und Zielmodell, kurzes
Änderungsprotokoll.

| Feld | Wert |
|---|---|
| Upstream | https://github.com/PhAlves23/prompt-engineering-skill |
| Commit | `01e1745060f06404d5a183a3082d1ca02ef19020` (`main`, Klon vom 27.10.2026) |
| Lizenz | MIT (siehe [`LICENSE`](LICENSE)) |
| Umfang | 1 Fähigkeit, 13 Dateien, 78 KB |
| Original | Claude-Code-Agent-Skill im Plugin-Format; dasselbe Repo bringt Adapter für Cursor, Windsurf, Copilot, Codex, Cline und eine Gemini-Extension |

## Warum es hier liegt

Der Skill war für Claude Code gebaut. Er wird hier gebraucht, weil die Crew-Rollen — allen voran
der `planner` — Texte schreiben, die andere Agenten ausführen: Rollen-Prompts, Aufgabenbriefings,
Abnahmekriterien, Übergaben. Genau dafür ist der Skill da.

## Was angepasst wurde

Die Anpassung ist bewusst klein und an vier Stellen sichtbar. Alles andere ist Upstream.

| Datei | Änderung |
|---|---|
| `SKILL.md` | Abschnitt **Harness note (DeepSeek Harness)** nach der Einleitung: Zielmodell ist die Sitzungsroute, Werkzeugnamen, Crew-Verweis. Frontmatter-`description` nennt jetzt die Sitzungsroute zuerst und den Crew-Fall. Ein Eintrag in der Referenzliste. |
| `references/model-profiles.md` | Neuer erster Abschnitt **DeepSeek (session route in DSH) — DEFAULT HERE**; die Überschrift des Claude-Abschnitts lautet jetzt „UPSTREAM DEFAULT". Upstream-Inhalt unverändert. |
| `references/dsh-harness.md` | **Neu.** Werkzeug-Zuordnung Claude Code → DSH, Zielmodell-Regeln, Crew-Nutzung, was hier keine Entsprechung hat. |

Das war der ganze Eingriff: eine neue Datei, ein neuer Abschnitt, ein Vorwort. Die Techniken,
Aufgabenmuster, Beispiele, Prüflisten und Quellen sind unangetastet.

## Die Zuordnung im Kern

| Upstream (Claude Code) | DSH |
|---|---|
| `Read` / `Glob` / `Grep` | `read` / `glob` / `grep` |
| `Bash` | `pwsh` |
| `Task` | `subagent` |
| `AskUserQuestion` | `ask_user_question` |
| `/prompt-engineering` (Slash) | `skill`-Werkzeug mit `prompt-engineering` |
| `~/.claude/skills/…` | `~/.agents/skills/prompt-engineering` (Junction) |

## Was bewusst nicht übernommen wurde

- **`plugins/prompt-engineering/.claude-plugin/`** — Plugin-Manifest und Marketplace-Eintrag;
  der Harness kennt keinen `/add-plugin`-Pfad, geladen wird über die Junction.
- **`adapters/`** — Cursor-, Windsurf-, Copilot-, Codex- und Cline-Regeln. Sie sind aus
  `adapters/_core.md` generiert und enthalten dieselben Regeln in anderer Verpackung; für DSH
  ersetzt sie `references/dsh-harness.md` plus der Skill selbst.
- **`GEMINI.md`, `gemini-extension.json`, `.cursor-plugin/`** — andere Harnesses.
- **`install.sh`, `scripts/build-adapters.sh`** — Installations- und Build-Skripte für die
  Adapter; hier gibt es nichts zu bauen.
- **`assets/banner.png`, `assets/banner.html`, `assets/logo.png`** — 770 KB Marketing-Bilder für
  das Repo, nicht für den Skill.
- **`docs/`, `CHANGELOG.md`, `CONTRIBUTING.md`, `CITATION.cff`** — Repo-Verwaltung.

Die `assets/canonical-template.md` **ist** übernommen: die `SKILL.md` verweist darauf.

## Wie der Skill geladen wird

```
~\.agents\skills\prompt-engineering  →  units\skills\prompt-engineering-skill\skills\prompt-engineering
```

`units\skills\link-skills.ps1` legt die Junction an; `prompt-engineering-skill` steht in
`$collectionen`. Nachgemessen mit dem Frontmatter-Parser des Kerns: lädt, für das Modell
aufrufbar.

## Aktualisieren

```powershell
$tmp = "$env:TEMP\prompt-eng"
git clone --depth 1 https://github.com/PhAlves23/prompt-engineering-skill.git $tmp
# plugins/prompt-engineering/skills/prompt-engineering/ erneut übernehmen, LICENSE nachziehen
# dann die drei Anpassungen oben erneut anwenden (SKILL.md, model-profiles.md, dsh-harness.md)
# Commit-Hash und Datum hier nachziehen
.\link-skills.ps1
```
