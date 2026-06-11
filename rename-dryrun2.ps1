$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$files = Get-ChildItem -Path . -Filter *.md

$results = @()
$warnings = @()

foreach ($f in $files) {
    $content = Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8
    $lines = $content -split "`r?`n"

    $created = $null
    $date = $null
    $type = $null
    $inFm = $false
    $titleLine = $null
    $titleIdx = -1

    for ($i = 0; $i -lt $lines.Length; $i++) {
        $line = $lines[$i]
        if ($i -eq 0 -and $line -eq '---') { $inFm = $true; continue }
        if ($inFm -and $line -eq '---') { $inFm = $false; continue }
        if ($inFm) {
            if ($line -match '^created:\s*(.+)$') { $created = $matches[1].Trim() }
            elseif ($line -match '^date:\s*(.+)$') { $date = $matches[1].Trim() }
            elseif ($line -match '^type:\s*(.+)$') { $type = $matches[1].Trim() }
        } else {
            if ($titleIdx -lt 0 -and ($line -match '^#{1,2}\s+(.+)$')) {
                $titleLine = $matches[1].Trim()
                $titleIdx = $i
            }
        }
    }

    $createdYear = $null
    $createdMonth = $null
    if ($created -match '^(\d{4})-(\d{2})-(\d{2})') {
        $createdYear = [int]$matches[1]
        $createdMonth = [int]$matches[2]
    }

    $titleMonth = $null
    $titleDay = $null
    $titleYear = $null
    if ($titleLine) {
        if ($titleLine -match '(\d{4})/(\d{1,2})/(\d{1,2})') {
            $titleYear = [int]$matches[1]
            $titleMonth = [int]$matches[2]
            $titleDay = [int]$matches[3]
        }
        elseif ($titleLine -match '(\d{4})-(\d{1,2})-(\d{1,2})') {
            $titleYear = [int]$matches[1]
            $titleMonth = [int]$matches[2]
            $titleDay = [int]$matches[3]
        }
        elseif ($titleLine -match '(\d{1,2})/(\d{1,2})') {
            $titleMonth = [int]$matches[1]
            $titleDay = [int]$matches[2]
        }
    }

    $finalYear = $null
    if ($titleYear) {
        $finalYear = $titleYear
    } elseif ($titleMonth -and $createdYear -and $createdMonth) {
        $finalYear = $createdYear
        if ($titleMonth -eq 12 -and $createdMonth -eq 1) { $finalYear = $createdYear - 1 }
        elseif ($titleMonth -eq 1 -and $createdMonth -eq 12) { $finalYear = $createdYear + 1 }
    }

    $newName = $null
    if ($finalYear -and $titleMonth -and $titleDay) {
        $newName = ('{0:D4}-{1:D2}-{2:D2}.md' -f $finalYear, $titleMonth, $titleDay)
    }

    $results += [PSCustomObject]@{
        OldName = $f.Name
        Created = $created
        Date    = $date
        Type    = $type
        Title   = $titleLine
        NewName = $newName
    }

    if (-not $newName) {
        $warnings += "NoDate: $($f.Name) | Title=[$titleLine] | Created=[$created]"
    }
}

$collisions = $results | Where-Object { $_.NewName } | Group-Object NewName | Where-Object { $_.Count -gt 1 }

Write-Host "TOTAL FILES: $($results.Count)"
Write-Host "UNRESOLVED: $($warnings.Count)"
foreach ($w in $warnings) { Write-Host "  $w" }
Write-Host ""
Write-Host "COLLISIONS: $($collisions.Count)"
foreach ($c in $collisions) {
    $names = ($c.Group | ForEach-Object { $_.OldName }) -join ' | '
    Write-Host "  -> $($c.Name)  <<  $names"
}

$results | Export-Csv -Path '..\..\..\rename-mapping.csv' -Encoding UTF8 -NoTypeInformation
