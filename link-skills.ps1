# Legt fuer jeden Skill-Ordner dieses Repositories eine Junction im Benutzer-Scope an.
# Es wird nichts kopiert: der Inhalt bleibt an einem Ort, die Junction ist die Verbindung.
# Wiederholbar -- vorhandene Verbindungen werden uebersprungen, nicht ersetzt.
#
# Zwei Formen:
#   flach    -- ein Ordner je Faehigkeit, direkt unter diesem Verzeichnis
#   Sammlung -- ein Upstream-Baum mit vielen Skills darin (router + 76, 19 Packs,
#               pstack mit 58 Faehigkeiten unter skills/).
#               Nur Sammlungen aus $collectionen werden durchsucht. Baeume, die
#               hier nicht stehen, bleiben unangetastet.
$ErrorActionPreference = 'Stop'

$root  = Split-Path -Parent $MyInvocation.MyCommand.Path
$scope = Join-Path $env:USERPROFILE '.agents\skills'
# Repository-Wurzel: units/skills liegt zwei Ebenen darunter. Gebraucht fuer relative
# Pfade im Register.
$projectRoot = Split-Path -Parent (Split-Path -Parent $root)

$collectionen = @(
    'awesome-gamedev-agent-skills',
    'iart-motion-skills',
    # Cursor-Plugin von Lauren Tan; der Harness kennt keinen /add-plugin-Pfad,
    # geladen wird es wie jede andere Sammlung ueber eine Junction je Faehigkeit.
    'pstack',
    # ibelick/ui-skills: neun Faehigkeiten unter skills/, Registry bleibt draussen.
    'ui-skills',
    # latent-spaces/brag: Launchvideo-Skill, zwei Faehigkeiten unter skills/.
    'brag',
    # Kuratierter Motion-Satz aus fremden Repos (emilkowalski, transitions-dev,
    # userinterface-wiki); Auswahl und Lizenzen stehen in VENDOR.md.
    'ui-motion-picks',
    # PhAlves23/prompt-engineering-skill: Umschreiben von Prompts; fuer den
    # planner und die Rollen-Prompts der Crew angepasst (siehe VENDOR.md).
    'prompt-engineering-skill'
)

# Weitere Namen, unter denen eine Sammlung im Register auffindbar sein soll: der
# Upstream-Autor, das Repository, das Thema. Nur diese Liste macht /emilkowalski
# auffindbar, obwohl das Verzeichnis ui-motion-picks heisst.
$aliase = @{
    'awesome-gamedev-agent-skills' = @('gamedev', 'game-dev', 'awesome-gamedev', 'games')
    'iart-motion-skills'           = @('iart', 'motion-skills', 'motion')
    'pstack'                       = @('lauren-tan', 'laurentan', 'cursor-plugin')
    'ui-skills'                    = @('ibelick', 'uiskills', 'ui-skills.com')
    'brag'                         = @('latent-spaces', 'launch-video', 'launchfilm', 'hyperframes')
    'ui-motion-picks'              = @('emilkowalski', 'emil', 'transitions-dev', 'userinterface-wiki', 'raphaelsalaja', 'jakubantalik', 'motion')
    'prompt-engineering-skill'     = @('prompt-engineering', 'prompting', 'ph-alves')
    'flach'                        = @('eigene', 'lokal', 'local')
}

if (-not (Test-Path $scope)) {
    New-Item -ItemType Directory -Force -Path $scope | Out-Null
    Write-Host "angelegt: $scope"
}

$script:angelegt = 0
$script:vorhanden = 0
$script:gesehen = @{}
# Der Registereintrag je Faehigkeit: Name -> Sammlung und Ziel. Wird als index.json
# geschrieben, damit der Web-Client die Faehigkeiten nach Sammlung gruppieren kann,
# ohne aus einem Junction-Pfad zu raten.
$script:index = [ordered]@{}

function Add-SkillLink {
    param([string]$Name, [string]$Target, [string]$Quelle)

    # Auch doppelte Namen bekommen einen Eintrag: der Index beschreibt den Bestand,
    # die Verknuepfung nur den Gewinner.
    $script:index[$Name] = [ordered]@{ source = $Quelle; path = $Target }

    if ($script:gesehen.ContainsKey($Name)) {
        Write-Host "WARNUNG: Name '$Name' doppelt ($($script:gesehen[$Name]) / $Target) -- nur der erste wird verlinkt"
        return
    }
    $script:gesehen[$Name] = $Target

    $link = Join-Path $scope $Name
    if (Test-Path $link) {
        $item = Get-Item $link -Force
        if ($item.LinkType -eq 'Junction') {
            Write-Host "uebersprungen (Junction existiert): $Name"
        } else {
            Write-Host "WARNUNG: $link existiert und ist keine Junction -- nicht angefasst"
        }
        $script:vorhanden++
    } else {
        New-Item -ItemType Junction -Path $link -Target $Target | Out-Null
        Write-Host "angelegt: $Name"
        $script:angelegt++
    }
}

# flache Faehigkeiten
Get-ChildItem $root -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') } |
    ForEach-Object { Add-SkillLink -Name $_.Name -Target $_.FullName -Quelle 'flach' }

# Sammlungen
foreach ($name in $collectionen) {
    $base = Join-Path $root $name
    if (-not (Test-Path $base)) {
        Write-Host "Hinweis: Sammlung fehlt -- $name"
        continue
    }
    Write-Host ""
    Write-Host "Sammlung: $name"
    Get-ChildItem $base -Directory -Recurse -Depth 3 -ErrorAction Stop |
        Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') } |
        ForEach-Object { Add-SkillLink -Name $_.Name -Target $_.FullName -Quelle $name }
}

# Der Registereintrag. Pfade relativ zum Repository, damit der Index auch dann gilt,
# wenn der Bestand woanders liegt als heute.
$indexPfad = Join-Path $root 'index.json'
$eintraege = @(
    foreach ($eintrag in $script:index.GetEnumerator()) {
        $pfad = $eintrag.Value.path
        if ($pfad.StartsWith($projectRoot, [StringComparison]::OrdinalIgnoreCase)) {
            $pfad = $pfad.Substring($projectRoot.Length).TrimStart('\', '/') -replace '\\', '/'
        }
        [ordered]@{ name = $eintrag.Key; source = $eintrag.Value.source; path = $pfad }
    }
)
$nachQuelle = [ordered]@{}
foreach ($eintrag in $eintraege) {
    if (-not $nachQuelle.Contains($eintrag.source)) { $nachQuelle[$eintrag.source] = 0 }
    $nachQuelle[$eintrag.source]++
}
# Die Sammlungen mit ihren Aliassen: das ist die Suchgrundlage des Web-Clients.
$sammlungen = @(
    foreach ($quelle in $nachQuelle.GetEnumerator()) {
        [ordered]@{
            name    = $quelle.Key
            count   = $quelle.Value
            aliases = @(if ($aliase.ContainsKey($quelle.Key)) { $aliase[$quelle.Key] } else { @() })
        }
    }
)
$index = [ordered]@{
    schema      = 1
    generatedAt = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
    total       = $eintraege.Count
    sources     = $nachQuelle
    collections = $sammlungen
    skills      = $eintraege
}
$index | ConvertTo-Json -Depth 5 | Set-Content -Path $indexPfad -Encoding utf8
Write-Host ""
Write-Host "$($script:angelegt) Verbindung(en) angelegt, $($script:vorhanden) bereits vorhanden."
Write-Host "Register geschrieben: $indexPfad ($($eintraege.Count) Eintraege, $($nachQuelle.Count) Sammlungen)"
Write-Host "Der Katalog des Harness liest den Benutzer-Scope; ein Neustart ist nicht noetig."
