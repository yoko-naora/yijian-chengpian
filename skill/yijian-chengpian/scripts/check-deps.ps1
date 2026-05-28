# Check dependencies for yijian-chengpian (Windows PowerShell)
param([switch]$Json)

$results = @()

$checks = @(
    @{Name="ffmpeg"; Cmd="ffmpeg"; Args="-version"; MinVer=""},
    @{Name="ffprobe"; Cmd="ffprobe"; Args="-version"; MinVer=""},
    @{Name="node"; Cmd="node"; Args="--version"; MinVer="22"},
    @{Name="python"; Cmd="python"; Args="--version"; MinVer="3.10"},
    @{Name="git"; Cmd="git"; Args="--version"; MinVer=""},
    @{Name="yt-dlp"; Cmd="yt-dlp"; Args="--version"; MinVer=""},
    @{Name="hyperframes"; Cmd="npx"; Args="hyperframes --version"; MinVer=""},
    @{Name="chrome-headless"; Cmd="npx"; Args="hyperframes browser path"; MinVer=""}
)

foreach ($c in $checks) {
    try {
        $output = & $c.Cmd $c.Args 2>&1 | Out-String
        $results += @{ name=$c.Name; status="OK"; info=$output.Trim().Split("`n")[0] }
    } catch {
        $results += @{ name=$c.Name; status="MISSING"; info="not found" }
    }
}

if ($Json) {
    $results | ConvertTo-Json
} else {
    Write-Host "`nyijian-chengpian Dependency Check`n================================`n"
    foreach ($r in $results) {
        $icon = if ($r.status -eq "OK") { "[OK]" } else { "[!!]" }
        Write-Host "$icon $($r.name): $($r.info)"
    }
    $missing = ($results | Where-Object { $_.status -ne "OK" }).Count
    if ($missing -gt 0) {
        Write-Host "`n$missing dependency(s) missing. Run setup.md Phase 1 for install instructions."
    } else {
        Write-Host "`nAll dependencies OK."
    }
}
