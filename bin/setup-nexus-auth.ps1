<#
.SYNOPSIS
  One-time setup so Scoop can reach Pragma's authenticated Nexus registry.

.DESCRIPTION
  Scoop downloads app archives with .NET's WebClient, not curl — it never reads
  a `_netrc` file. The only way to make Scoop send credentials on every request
  to a given host is its built-in `private_hosts` config (an array of
  {match, headers} entries, applied to url/checkver/autoupdate downloads alike).

  This script registers a Basic-auth header (built from your Nexus user token)
  for Pragma's registry host, merging with any private_hosts entries you
  already have configured for other buckets.

  Run this once, before `scoop bucket add pragma ...` / `scoop install pragma-ai`.

.PARAMETER NexusUser
  Your Nexus username (usually your Pragma email).

.PARAMETER NexusToken
  Your Nexus user token — NOT your login password.
  Generate one from the Nexus UI: profile icon > User Token > Access Token.

.PARAMETER NexusHostPattern
  Regex matched against the full download URL. Defaults to Pragma's prod and
  dev registries.

.EXAMPLE
  irm https://raw.githubusercontent.com/somospragma/pragma-ai-cli-formula/main/bin/setup-nexus-auth.ps1 | iex
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$NexusUser,

    [Parameter(Mandatory = $true)]
    [string]$NexusToken,

    [string]$NexusHostPattern = 'registry(-dev)?\.pragma\.com\.co'
)

$ErrorActionPreference = 'Stop'

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    throw "Scoop is not installed. Install it first: https://scoop.sh"
}

$pair = "${NexusUser}:${NexusToken}"
$basicAuth = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($pair))

# `scoop config private_hosts` prints a placeholder message (wording varies
# by version) when the key has never been set — ConvertFrom-Json rejects that
# non-JSON text, which is exactly the signal we want to fall back to [].
$existing = @()
try {
    $existing = @(scoop config private_hosts | ConvertFrom-Json)
} catch {
    $existing = @()
}

$existing = @($existing | Where-Object { $_.match -ne $NexusHostPattern })
$existing += [PSCustomObject]@{
    match   = $NexusHostPattern
    headers = "Authorization=Basic $basicAuth"
}

# Windows PowerShell 5.1 lacks -AsArray and collapses single-element
# collections to a scalar object, so force array brackets manually.
$configValue = $existing | ConvertTo-Json -Compress
if ($existing.Count -eq 1) { $configValue = "[$configValue]" }
scoop config private_hosts $configValue | Out-Null

Write-Host "Nexus credentials configured for Scoop (host pattern: $NexusHostPattern)."
Write-Host ""
Write-Host "You can now run:"
Write-Host "  scoop bucket add pragma https://github.com/somospragma/pragma-ai-cli-formula"
Write-Host "  scoop install pragma-ai"
