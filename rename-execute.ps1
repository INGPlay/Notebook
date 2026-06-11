$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

$dir = 'S:\SourceTree\Notebook\Work\인포마인드\업무'
$files = Get-ChildItem -LiteralPath $dir -Filter *.md

function Parse-Note {
    param($file)
    $content = [System.IO.File]::ReadAllText($file.FullName)
    if ($null -eq $content) { $content = '' }
    $lines = $content -split "`r?`n"

    $fmLines = @()
    $bodyLines = @()
    $fmEnd = -1
    if ($lines.Count -gt 0 -and $lines[0] -eq '---') {
        for ($i = 1; $i -lt $lines.Count; $i++) {
            if ($lines[$i] -eq '---') { $fmEnd = $i; break }
        }
    }
    if ($fmEnd -gt 0) {
        $fmLines = @($lines[1..($fmEnd-1)])
        if ($fmEnd + 1 -lt $lines.Count) {
            $bodyLines = @($lines[($fmEnd+1)..($lines.Count-1)])
        }
    } else {
        $bodyLines = @($lines)
    }

    $created = $null; $date = $null
    foreach ($l in $fmLines) {
        if ($l -match '^created:\s*(.+)$') { $created = $matches[1].Trim() }
        elseif ($l -match '^date:\s*(.+)$') { $date = $matches[1].Trim() }
    }

    $titleIdx = -1; $titleLine = $null
    for ($i = 0; $i -lt $bodyLines.Count; $i++) {
        if ($bodyLines[$i] -match '^#{1,6}\s+(.+)$') {
            $titleIdx = $i; $titleLine = $matches[1].Trim(); break
        }
    }

    return [PSCustomObject]@{
        File      = $file
        FmLines   = $fmLines
        BodyLines = $bodyLines
        Created   = $created
        Date      = $date
        TitleIdx  = $titleIdx
        TitleLine = $titleLine
    }
}

function Compute-NewDate {
    param($parsed)
    $createdYear = $null; $createdMonth = $null
    if ($parsed.Created -match '^(\d{4})-(\d{2})-(\d{2})') {
        $createdYear = [int]$matches[1]; $createdMonth = [int]$matches[2]
    }
    $titleMonth = $null; $titleDay = $null; $titleYear = $null
    if ($parsed.TitleLine) {
        if ($parsed.TitleLine -match '(\d{4})/(\d{1,2})/(\d{1,2})') {
            $titleYear = [int]$matches[1]; $titleMonth = [int]$matches[2]; $titleDay = [int]$matches[3]
        }
        elseif ($parsed.TitleLine -match '(\d{4})-(\d{1,2})-(\d{1,2})') {
            $titleYear = [int]$matches[1]; $titleMonth = [int]$matches[2]; $titleDay = [int]$matches[3]
        }
        elseif ($parsed.TitleLine -match '(\d{1,2})/(\d{1,2})') {
            $titleMonth = [int]$matches[1]; $titleDay = [int]$matches[2]
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
    if ($finalYear -and $titleMonth -and $titleDay) {
        return ('{0:D4}-{1:D2}-{2:D2}' -f $finalYear, $titleMonth, $titleDay)
    }
    return $null
}

function Build-NewFm {
    param($baseFmLines)
    $newFm = @()
    $hasType = $false
    foreach ($l in $baseFmLines) {
        if ($l -match '^type:\s*') {
            if (-not $hasType) {
                $newFm += 'type: 일지'
                $hasType = $true
            }
        } else {
            $newFm += $l
        }
    }
    if (-not $hasType) {
        $newFm = @('type: 일지') + $newFm
    }
    return ,$newFm
}

function Get-BodyStripped {
    param($parsed)
    $tmp = @()
    for ($i = 0; $i -lt $parsed.BodyLines.Count; $i++) {
        if ($i -eq $parsed.TitleIdx) { continue }
        $tmp += $parsed.BodyLines[$i]
    }
    while ($tmp.Count -gt 0 -and $tmp[0] -match '^\s*$') {
        if ($tmp.Count -eq 1) { $tmp = @() } else { $tmp = @($tmp[1..($tmp.Count - 1)]) }
    }
    while ($tmp.Count -gt 0 -and $tmp[-1] -match '^\s*$') {
        if ($tmp.Count -eq 1) { $tmp = @() } else { $tmp = @($tmp[0..($tmp.Count - 2)]) }
    }
    return ,$tmp
}

# Parse all
$parsedAll = @()
foreach ($f in $files) {
    $p = Parse-Note -file $f
    $p | Add-Member -NotePropertyName 'NewDate' -NotePropertyValue (Compute-NewDate -parsed $p)
    $parsedAll += $p
}

$missing = @($parsedAll | Where-Object { -not $_.NewDate })
if ($missing.Count -gt 0) {
    Write-Host "ABORT: $($missing.Count) files have no resolvable date."
    foreach ($m in $missing) { Write-Host "  $($m.File.Name)" }
    exit 1
}

$groups = $parsedAll | Group-Object NewDate

$targets = @{}
$mergeCount = 0
foreach ($g in $groups) {
    $newDate = $g.Name
    $newFileName = "$newDate.md"
    $newPath = Join-Path $dir $newFileName

    $sorted = $g.Group | Sort-Object @{Expression = {
        if ($_.File.BaseName -match '\s+(\d+)$') { [int]$matches[1] } else { 0 }
    }}, @{Expression = { $_.File.Name }}

    if ($sorted.Count -gt 1) { $mergeCount++ }

    $newFm = Build-NewFm -baseFmLines $sorted[0].FmLines

    $bodyParts = @()
    for ($i = 0; $i -lt $sorted.Count; $i++) {
        $b = Get-BodyStripped -parsed $sorted[$i]
        if ($i -gt 0) {
            $bodyParts += ''
            $bodyParts += '---'
            $bodyParts += ''
        }
        if ($b.Count -gt 0) { $bodyParts += $b }
    }

    $content = "---`r`n" + ($newFm -join "`r`n") + "`r`n---`r`n# $newDate`r`n`r`n" + ($bodyParts -join "`r`n") + "`r`n"
    $targets[$newPath] = $content
}

Write-Host "Total source files: $($parsedAll.Count)"
Write-Host "Target files: $($targets.Count)"
Write-Host "Merged targets: $mergeCount"

# Stage: write to .staged files
$stagedPaths = @()
foreach ($kv in $targets.GetEnumerator()) {
    $stagedPath = "$($kv.Key).staged"
    [System.IO.File]::WriteAllText($stagedPath, $kv.Value, $utf8NoBom)
    $stagedPaths += $stagedPath
}
Write-Host "Staged $($stagedPaths.Count) files."

# Delete originals
$deleteCount = 0
foreach ($p in $parsedAll) {
    Remove-Item -LiteralPath $p.File.FullName -Force
    $deleteCount++
}
Write-Host "Deleted $deleteCount originals."

# Promote staged
foreach ($s in $stagedPaths) {
    $final = $s.Substring(0, $s.Length - 7)
    Move-Item -LiteralPath $s -Destination $final -Force
}
Write-Host "Promoted $($stagedPaths.Count) staged files."
Write-Host "Done."
