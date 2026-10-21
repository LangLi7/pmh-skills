# Legt fuer jeden Skill-Ordner dieses Repositories eine Junction im Benutzer-Scope an.
# Es wird nichts kopiert: der Inhalt bleibt an einem Ort, die Junction ist die Verbindung.
# Wiederholbar -- vorhandene Verbindungen werden uebersprungen, nicht ersetzt.
$ErrorActionPreference = 'Stop'

$root  = Split-Path -Parent $MyInvocation.MyCommand.Path
$scope = Join-Path $env:USERPROFILE '.agents\skills'

if (-not (Test-Path $scope)) {
    New-Item -ItemType Directory -Force -Path $scope | Out-Null
    Write-Host "angelegt: $scope"
}

$script:angelegt = 0
$script:vorhanden = 0

Get-ChildItem $root -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') } |
    ForEach-Object {
        $link = Join-Path $scope $_.Name
        if (Test-Path $link) {
            $item = Get-Item $link -Force
            if ($item.LinkType -eq 'Junction') {
                Write-Host "uebersprungen (Junction existiert): $($_.Name)"
            } else {
                Write-Host "WARNUNG: $link existiert und ist keine Junction -- nicht angefasst"
            }
            $script:vorhanden++
        } else {
            New-Item -ItemType Junction -Path $link -Target $_.FullName | Out-Null
            Write-Host "angelegt: $($_.Name)"
            $script:angelegt++
        }
    }

Write-Host ""
Write-Host "$($script:angelegt) Verbindung(en) angelegt, $($script:vorhanden) bereits vorhanden."
Write-Host "Der Katalog des Harness liest den Benutzer-Scope; ein Neustart ist nicht noetig."
