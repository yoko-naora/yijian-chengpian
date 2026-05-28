# Install yijian-chengpian skill for Claude Code
param($Target = "$env:USERPROFILE\.claude\skills\yijian-chengpian")

$ScriptDir = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path $MyInvocation.MyCommand.Path -Parent }
$RepoRoot = Split-Path -Parent $ScriptDir
$SkillSource = Join-Path $RepoRoot "skill\yijian-chengpian"

Write-Host "Installing yijian-chengpian to $Target..."

if (Test-Path $Target) {
    Write-Host "  Removing existing installation..."
    Remove-Item -Recurse -Force $Target
}

Copy-Item -Recurse $SkillSource $Target
Write-Host "Done! yijian-chengpian skill installed for Claude Code."
