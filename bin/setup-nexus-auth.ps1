<#
.SYNOPSIS
  One-time setup so Scoop can reach Pragma's authenticated Nexus registry.

.DESCRIPTION
  Scoop downloads app archives with .NET's WebClient, not curl — it never reads
  a `_netrc` file. The only way to make Scoop send credentials on every request
  to a given host is its built-in `private_hosts` config (an array of
  {match, headers} entries, applied to url/checkver/autoupdate downloads alike).

  This can't be set via `scoop config private_hosts <value>`: Scoop's own
  set_config stores whatever string you pass verbatim (it only special-cases
  "True"/"False"), so a pre-serialized JSON array ends up saved as a literal
  *string* property instead of a nested array. Scoop's download code then
  fails with "Cannot bind argument to parameter 'StringData' because it is
  null." This script instead reads/writes Scoop's config.json directly, the
  same way Scoop itself does (lib/core.ps1), so private_hosts ends up as a
  real array — and repairs the entry if an older version of this script
  already wrote it as a broken string.

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
    [string]$NexusUser,
    [string]$NexusToken,
    [string]$NexusHostPattern = 'registry(-dev)?\.pragma\.com\.co'
)

# Mandatory-parameter prompting never fires here: this script is meant to be
# run via `irm ... | iex`, and Invoke-Expression evaluates its input as plain
# statements rather than a real command invocation — the parameter binder
# that triggers "supply a value for the following parameters" only runs when
# a script/function is actually *called* (e.g. `.\script.ps1`), not when its
# text is piped into iex. So [Parameter(Mandatory = $true)] silently leaves
# these $null under iex instead of prompting. Fall back to Read-Host instead,
# which works the same regardless of how this script was invoked.
if (-not $NexusUser) {
    $NexusUser = Read-Host "Nexus username (usually your Pragma email)"
}
if (-not $NexusToken) {
    $NexusToken = Read-Host "Nexus user token (Nexus UI > profile icon > User Token — not your login password)"
}

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    throw "Scoop is not installed. Install it first: https://scoop.sh"
}

$pair = "${NexusUser}:${NexusToken}"
$basicAuth = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($pair))

# Mirrors Scoop's own config path resolution (lib/core.ps1: $configHome /
# $configFile) — deliberately not going through `scoop config` for this key,
# see the .DESCRIPTION above.
$configHome = if ($env:XDG_CONFIG_HOME) { $env:XDG_CONFIG_HOME } else { "$env:USERPROFILE\.config" }
$configFile = Join-Path $configHome "scoop\config.json"

$config = if (Test-Path $configFile) {
    Get-Content -Raw -Path $configFile | ConvertFrom-Json -ErrorAction Stop
} else {
    [PSCustomObject]@{}
}

# Recover from a previous broken run (private_hosts saved as a JSON-encoded
# *string*) instead of silently discarding it.
$raw = $config.private_hosts
$existing = @()
if ($raw -is [string]) {
    try { $existing = @($raw | ConvertFrom-Json -ErrorAction Stop) } catch { $existing = @() }
} elseif ($null -ne $raw) {
    $existing = @($raw)
}

$existing = @($existing | Where-Object { $_.match -ne $NexusHostPattern })
$existing += [PSCustomObject]@{
    match   = $NexusHostPattern
    headers = "Authorization=Basic $basicAuth"
}

$config | Add-Member -MemberType NoteProperty -Name 'private_hosts' -Value $existing -Force

New-Item -ItemType Directory -Force -Path (Split-Path $configFile) | Out-Null
$json = $config | ConvertTo-Json -Depth 6
# Write without a BOM — Windows PowerShell 5.1's `-Encoding utf8` adds one,
# and while Scoop's own reader tolerates it, plain UTF-8 matches config.json
# as Scoop itself writes it.
[System.IO.File]::WriteAllText($configFile, $json, (New-Object System.Text.UTF8Encoding($false)))

Write-Host "Nexus credentials configured for Scoop (host pattern: $NexusHostPattern)."
Write-Host ""
Write-Host "You can now run:"
Write-Host "  scoop bucket add pragma https://github.com/somospragma/pragma-ai-cli-formula"
Write-Host "  scoop install pragma-ai"
