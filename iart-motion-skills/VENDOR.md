# Herkunft dieses Bestands

Vendored Kopie der **iart.ai Motion-Skill-Packs** — 55 Fähigkeiten aus 19 Repositories.

| Feld | Wert |
|---|---|
| Katalog-Repository | https://github.com/iart-ai/motion-skills |
| Lizenz | MIT, je Pack eine eigene `LICENSE` |
| Klon | 27.10.2026, jeweils `main` |
| Upstream-Doku | Das Katalog-Repo enthält **keine** Skills, nur die Liste der 19 Packs (siehe [`README.md`](README.md)) |

## Aufbau

Ein Ordner je Pack, darin unverändert `skills/<name>/` plus `references/`, `scripts/`,
`templates/`:

```
iart-motion-skills/
├── tiktok-video-skills/
│   ├── skills/caption-animation/  countdown-video/  short-form-video/
│   └── …
├── web-animation-skills/
│   └── skills/60fps-animation/  accessible-animation/  gsap-web/  lottie-animation/ …
└── …
```

Der Pack-Baum bleibt intakt, weil `SKILL.md` und `scripts/` relative Pfade innerhalb des Packs
nutzen (`templates/lower-third.html`, `scripts/render.mjs`). Geladen wird trotzdem jeder Skill
einzeln — über eine Junction im Benutzer-Scope:

```
~\.agents\skills\gsap-web  →  units\skills\iart-motion-skills\web-animation-skills\skills\gsap-web
```

## Die 19 Packs

| Pack | Skills | Commit | Inhalt |
|---|---|---|---|
| `tiktok-video-skills` | 3 | `2a775336` | Caption-Animation, Countdown, Short-Form-Video |
| `text-message-video-skills` | 1 | `3a800e1e` | Textnachrichten-Story |
| `youtube-video-skills` | 2 | `f3df381d` | Audiogramm, Intro/Outro |
| `ecommerce-video-skills` | 3 | `2bd0dd19` | Fotoshow, Produktdemo, Promo |
| `ad-video-skills` | 3 | `0de0f2a1` | Ad-Creative, Launch-Video, Testimonial |
| `data-animation-skills` | 3 | `8ce2709c` | Chart, Infografik, Präsentationsvideo |
| `explainer-video-skills` | 5 | `3e2d411b` | Erklärvideo, Diagramm, Isometrie, Whiteboard, Jahresrückblick |
| `map-animation-skills` | 1 | `390ca98b` | redaktionelle Kartenanimation |
| `web-animation-skills` | 9 | `b6dba3eb` | GSAP, SVG, Lottie, Seitenübergang, Mikro-Interaktion, 60 fps, A11y, ASCII, Glassmorphism |
| `motion-design-skills` | 9 | `3c129f76` | After Effects, Animationsprinzipien, Beat-Sync, Farbmotion, Logo, Art-Direction, Hintergrund, Remotion, Bildkomposition |
| `kinetic-typography-skills` | 1 | `fccc94bd` | kinetische Typografie |
| `freelance-motion-skills` | 5 | `d85c2b48` | Briefing, Preis, Revisionsrunden, Brand-Motion, Liefervorgaben |
| `webgl-animation-skills` | 3 | `50697d65` | Three.js, Partikel, GLSL-Shader |
| `manim-skills` | 1 | `a15833c4` | Manim-Mathematikanimation |
| `generative-illustration-skills` | 1 | `e7d62437` | generative Illustration |
| `javascript-animation-skills` | 2 | `f7d0882a` | Canvas-Film ohne Assets, Soundtrack |
| `lower-thirds-skills` | 1 | `aa8ef7ed` | Bauchbinden mit Alphakanal (WebM, ProRes 4444) |
| `b-roll-skills` | 1 | `a51e34b0` | B-Roll aus dem Sprechtext |
| `talking-head-skills` | 1 | `a315032c` | Sprecherkopf aus Foto und Stimme |

## Nicht übernommen

- **`showcase.gif`** in jedem Pack (72,5 MB) — Banner für das jeweilige Upstream-README, kein
  Skill-Inhalt.
- **`.mp4`-Demo-Dateien** (`talking-head-skills/examples/one-idea/`) — Beispielrendering des
  Upstream-README, von keinem `SKILL.md` referenziert. Die Arbeitsdateien dieses Beispiels
  (`plan.json`, `film.json`, Artwork) sind erhalten.
- **`.git`** je Pack — die Stände stehen oben als Commit-Kurzform.
- **`tiktok-video-skills/skills/lower-thirds`** — trägt denselben Namen wie
  `lower-thirds-skills/skills/lower-thirds`. Behalten wurde die dedizierte Fassung: sie
  beschreibt den Alphakanal-Export (WebM/ProRes), die TikTok-Fassung die Animation und
  Vorlagenpflege über viele Namen. Wer sie zusätzlich will, kopiert den Ordner unter einem
  eigenen Namen zurück und passt `name:` im Frontmatter an; sonst führt der Katalog zwei
  gleichnamige Skills.

## Aktualisieren

```powershell
foreach ($p in 'tiktok-video-skills','web-animation-skills','motion-design-skills') {
  git clone --depth 1 "https://github.com/iart-ai/$p.git" "$env:TEMP\iart\$p"
  # Pack-Ordner ersetzen, Commit-Tabelle oben nachziehen
}
```

Danach `../../link-skills.ps1` erneut laufen lassen.
