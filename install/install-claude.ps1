# Install yijian-chengpian skill for Claude Code
param($Target = "$env:USERPROFILE\.claude\skills\yijian-chengpian")

$Source = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$SkillSource = Join-Path $Source "skill\yijian-chengpian"

Write-Host "Installing yijian-chengpian to $Target..."

if (Test-Path $Target) {
    Write-Host "  Removing existing installation..."
    Remove-Item -Recurse -Force $Target
}

Copy-Item -Recurse $SkillSource $Target
Write-Host "Done! yijian-chengpian skill installed for Claude Code."
