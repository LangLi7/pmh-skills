#!/bin/sh
# =============================================================================
# Prometheus Harness — Fähigkeiten in den Benutzer-Scope verknüpfen (POSIX sh)
# =============================================================================
#
# **Was dieses Skript tut.** Für jede Fähigkeit in diesem Verzeichnis legt es
# einen symbolischen Verweis unter `~/.agents/skills` an. Es wird nichts kopiert:
# der Inhalt bleibt an einem Ort, der Verweis ist die Verbindung.
#
# **Warum es das PowerShell-Skript nicht ersetzt.** `link-skills.ps1` schreibt
# zusätzlich `index.json` (die Gruppierung nach Sammlung für den Web-Client).
# Dieses Skript verknüpft nur — dafür läuft es auf Linux und macOS, wo es kein
# PowerShell gibt.
#
# **Wiederholbar.** Vorhandene Verweise werden übersprungen, nicht ersetzt.
# Eine echte Datei gleichen Namens wird nicht angefasst.
#
# Aufruf:
#     sh units/skills/link-skills.sh
#     sh units/skills/link-skills.sh --pruefen   # nur zeigen, nichts anlegen
# =============================================================================

set -eu

root=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
scope="${HOME}/.agents/skills"
pruefen=0
[ "${1:-}" = '--pruefen' ] && pruefen=1

# Sammlungen: ein Upstream-Baum mit mehreren Fähigkeiten darin. Nur diese werden
# rekursiv durchsucht — ein fremder Baum, der hier nicht steht, bleibt unberührt.
sammlungen='awesome-gamedev-agent-skills iart-motion-skills pstack ui-skills brag ui-motion-picks prompt-engineering-skill'

angelegt=0
vorhanden=0

verknuepfe() {
  name=$1
  ziel=$2
  if [ -e "${scope}/${name}" ] || [ -L "${scope}/${name}" ]; then
    echo "uebersprungen (existiert): ${name}"
    vorhanden=$((vorhanden + 1))
    return 0
  fi
  if [ "$pruefen" = 1 ]; then
    echo "wuerde anlegen: ${name} -> ${ziel}"
    angelegt=$((angelegt + 1))
    return 0
  fi
  ln -s "$ziel" "${scope}/${name}"
  echo "angelegt: ${name}"
  angelegt=$((angelegt + 1))
}

if [ "$pruefen" = 0 ]; then
  mkdir -p "$scope"
fi

# Flache Fähigkeiten: ein Ordner je Fähigkeit, SKILL.md direkt darin.
for d in "$root"/*/; do
  [ -d "$d" ] || continue
  [ -f "${d}SKILL.md" ] || continue
  name=$(basename "$d")
  verknuepfe "$name" "${d%/}"
done

# Sammlungen: SKILL.md bis Tiefe 3.
for c in $sammlungen; do
  [ -d "$root/$c" ] || continue
  echo ""
  echo "Sammlung: $c"
  find "$root/$c" -maxdepth 3 -name SKILL.md -type f | while IFS= read -r f; do
    d=$(dirname "$f")
    name=$(basename "$d")
    verknuepfe "$name" "$d"
  done
done

echo ""
if [ "$pruefen" = 1 ]; then
  echo "${angelegt} wuerde(n) angelegt, ${vorhanden} bereits vorhanden."
  echo "Nichts geschrieben (--pruefen)."
else
  echo "${angelegt} Verknuepfung(en) angelegt, ${vorhanden} bereits vorhanden."
  echo "Der Katalog des Harness liest den Benutzer-Scope; ein Neustart ist noetig."
fi
