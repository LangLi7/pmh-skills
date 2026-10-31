# Herkunft dieses Bestands

Vendored Kopie von **/brag** — ein Skill, der aus dem aktuellen Projekt ein kurzes
Launch-Video baut (Story, Motion, Musik, Share-Copy), gerendert über Hyperframes.

| Feld | Wert |
|---|---|
| Upstream | https://github.com/latent-spaces/brag |
| Commit | `669ab9286aa28b6c3ee30e75f181ee74319d012a` (`main`, Klon vom 27.10.2026) |
| Lizenz | MIT (siehe [`LICENSE`](LICENSE)); Musik und SFX darunter eigene Lizenzen |
| Umfang | 2 Fähigkeiten, 293 Dateien, 15,9 MB — davon 13 MB Musik |

## Aufbau

```
brag/
├── skills/
│   ├── brag/                 ← der volle Ablauf (289 Dateien)
│   │   ├── SKILL.md          ← Einstieg, Invocation-Parsing, Phasen
│   │   ├── slim.md           ← dieselbe Fähigkeit als Einzeldatei
│   │   ├── references/       ← step-1-inspect … step-4-deliver, tones, audio
│   │   ├── scripts/          ← analyze_music_cues.py (Python, uv)
│   │   └── assets/           ← 5 Musiktitel + SFX + Cue-Maps
│   └── brag-slim/            ← Einzeldatei-Fassung, ohne mitgelieferte Assets
├── plugin.json               ← Upstream-Manifest, unverändert
├── README.md                 ← Upstream-README, unverändert
└── LICENSE                   ← MIT
```

`brag` und `brag-slim` sind zwei Fähigkeiten, nicht zwei Fassungen desselben Namens:
`brag` schickt einen Kompositionsauftrag an Hyperframes, `brag-slim` baut das Video ohne
Hyperframes mit den Werkzeugen, die auf der Maschine liegen. Der Ablauf in `brag` wechselt
bei Claude Opus 5.5 selbst auf `brag-slim`; `--full` erzwingt den Hyperframes-Weg.

## Wie die Skills geladen werden

```
~\.agents\skills\brag        →  units\skills\brag\skills\brag
~\.agents\skills\brag-slim   →  units\skills\brag\skills\brag-slim
```

`units\skills\link-skills.ps1` legt die Junctions an; `brag` steht in `$collectionen`.
Nachgemessen mit dem Frontmatter-Parser des Kerns: **2 von 2** laden, beide für das Modell
aufrufbar (kein `disable-model-invocation`).

## Voraussetzungen — gemessen am 27.10.2026

| Prüfung | Stand |
|---|---|
| `npx hyperframes doctor` | **0.8.207 (latest)**, Start über npx, keine globale Installation |
| Node.js | v24.19.0 ✓ (verlangt ≥ 22) |
| FFmpeg / FFprobe | vorhanden (Winget-Build N-125875) ✓ |
| Chrome | System-Chrome erkannt ✓ |
| Docker | 29.9.2, läuft ✓ |
| `uv` für `analyze_music_cues.py` | 0.12.5 ✓ |
| Arbeitsspeicher | **nur 1,6 GB frei von 31,8 GB** — Doctor warnt: Renders können fehlschlagen |
| Whisper (Transkription) | fehlt, optional |
| TTS Kokoro (`--voice`) | fehlt, optional — `pip install kokoro-onnx soundfile` |
| Musik-Generierung MusicGen | fehlt, optional — der Skill bringt eigene Musiktitel mit |

Der Normalfall (Video ohne Voiceover) ist damit lauffähig. Zwei Dinge bleiben echt:
der knappe Arbeitsspeicher und die fehlende Kokoro-Installation, falls `--voice` gewünscht ist.

## Nicht übernommen

- `examples/` — Beispiel-Websites als Benchmark-Suite, mehrere MB
- `docs/` — die Launch-Site (GitHub Pages) samt Bildern
- `.claude/`, `.agents/`, `.codex-plugin/`, `.opencode/` — Discovery-Symlinks anderer Agenten;
  hier ersetzt durch die Junctions im Benutzer-Scope
- `.github/`, `scripts/` des Upstream-Repos

## Lizenzen der mitgelieferten Medien

Die Fähigkeit ist MIT. Die Musik ist **CC BY 4.0** von [ende.app](https://ende.app/en)
(„Happy Beats / Business Moves"), die Soundeffekte stammen von [Kenney](https://kenney.nl/).
Wer die Videos veröffentlicht, muss die Musik nennen; die Quelle steht im Upstream-README.

## Aktualisieren

```powershell
$tmp = "$env:TEMP\brag"
if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force }
git clone --depth 1 --filter=blob:none --sparse https://github.com/latent-spaces/brag.git $tmp
git -C $tmp sparse-checkout set skills
# skills/ erneut übernehmen, dazu LICENSE, README.md, plugin.json
# Commit-Hash und Datum in dieser Datei nachziehen
.\link-skills.ps1
```
