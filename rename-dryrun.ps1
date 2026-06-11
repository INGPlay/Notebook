$ErrorActionPreference = 'Stop'
$dir = 'S:\SourceTree\Notebook\Work\인포마인드\업무'
$files = Get-ChildItem -Path $dir -Filter *.md

$results = @()
$warnings = @()

foreach ($f in $files) {
    $content = Get-Content -Path $f.FullName -Raw -Encoding UTF8
    $lines = $content -split "`r?`n"

    # Parse frontmatter
    $created = $null
    $date = $null
    $type = $null
    $inFm = $false
    $fmEndIdx = -1
    $titleLine = $null
    $titleIdx = -1

    for ($i = 0; $i -lt $lines.Length; $i++) {
        $line = $lines[$i]
        if ($i -eq 0 -and $line -eq '---') { $inFm = $true; continue }
        if ($inFm -and $line -eq '---') { $inFm = $false; $fmEndIdx = $i; continue }
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

    # Parse year from created
    $createdYear = $null
    $createdMonth = $null
    if ($created -match '^(\d{4})-(\d{2})-(\d{2})') {
        $createdYear = [int]$matches[1]
        $createdMonth = [int]$matches[2]
    }

    # Parse the title to extract first date
    $titleMonth = $null
    $titleDay = $null
    $titleYear = $null
    if ($titleLine) {
        # YYYY/MM/DD format
        if ($titleLine -match '(\d{4})/(\d{1,2})/(\d{1,2})') {
            $titleYear = [int]$matches[1]
            $titleMonth = [int]$matches[2]
            $titleDay = [int]$matches[3]
        }
        # MM/DD or M/D format
        elseif ($titleLine -match '(\d{1,2})/(\d{1,2})') {
            $titleMonth = [int]$matches[1]
            $titleDay = [int]$matches[2]
        }
        # YYYY-MM-DD format (already converted)
        elseif ($titleLine -match '(\d{4})-(\d{2})-(\d{2})') {
            $titleYear = [int]$matches[1]
            $titleMonth = [int]$matches[2]
            $titleDay = [int]$matches[3]
        }
    }

    # Determine final year
    $finalYear = $null
    if ($titleYear) {
        $finalYear = $titleYear
    } elseif ($titleMonth -and $createdYear -and $createdMonth) {
        $finalYear = $createdYear
        # Year boundary heuristics
        if ($titleMonth -eq 12 -and $createdMonth -eq 1) { $finalYear = $createdYear - 1 }
        elseif ($titleMonth -eq 1 -and $createdMonth -eq 12) { $finalYear = $createdYear + 1 }
    }

    $newName = $null
    if ($finalYear -and $titleMonth -and $titleDay) {
        $newName = ('{0:D4}-{1:D2}-{2:D2}.md' -f $finalYear, $titleMonth, $titleDay)
    }

    $results += [PSCustomObject]@{
        OldName    = $f.Name
        Created    = $created
        Date       = $date
        Type       = $type
        Title      = $titleLine
        NewName    = $newName
    }

    if (-not $newName) {
        $warnings += "Could not determine date for: $($f.Name) | Title: $titleLine | Created: $created"
    }
}

# Detect collisions
$collisions = $results | Where-Object { $_.NewName } | Group-Object NewName | Where-Object { $_.Count -gt 1 }

Write-Host "=== TOTAL FILES: $($results.Count) ==="
Write-Host "=== UNABLE TO DETERMINE DATE: $($warnings.Count) ==="
foreach ($w in $warnings) { Write-Host "  $w" }
Write-Host ""
Write-Host "=== COLLISIONS: $($collisions.Count) ==="
foreach ($c in $collisions) {
    Write-Host "  Target: $($c.Name) <- $($c.Group.OldName -join ', ')"
}

# Output mapping summary
$results | Export-Csv -Path 'S:\SourceTree\Notebook\rename-mapping.csv' -Encoding UTF8 -NoTypeInformation
Write-Host ""
Write-Host "Mapping saved to rename-mapping.csv"
