# ─────────────────────────────────────────────────────────────────
#  bootstrap.ps1 — link this repo's Windows configs into place
#  Usage:   .\bootstrap.ps1                # link everything applicable
#           .\bootstrap.ps1 -Tools nvim    # link only specified tools
#
#  Requires Developer Mode enabled OR running as Administrator
#  (for SymbolicLink to files; Junction to directories does not).
# ─────────────────────────────────────────────────────────────────
[CmdletBinding()]
param(
    [string[]]$Tools = @()
)

$ErrorActionPreference = 'Stop'
$Repo = Split-Path -Parent $MyInvocation.MyCommand.Path

function Should-Link {
    param([string]$Tool)
    if ($Tools.Count -eq 0) { return $true }
    return $Tools -contains $Tool
}

function Link-Path {
    param(
        [string]$Source,        # path inside the repo
        [string]$Destination,   # path in user profile
        [ValidateSet('Junction', 'SymbolicLink')]
        [string]$LinkType = 'Junction'
    )

    if (-not (Test-Path $Source)) {
        Write-Host "  skip: $Source does not exist in repo"
        return
    }

    $destDir = Split-Path -Parent $Destination
    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }

    if (Test-Path $Destination) {
        $item = Get-Item $Destination -Force
        if ($item.LinkType) {
            # existing link — remove
            Remove-Item $Destination -Recurse -Force
        } else {
            # real file/dir — back it up
            $backup = "$Destination.backup"
            if (Test-Path $backup) {
                Write-Error "  $Destination exists and $backup also exists. Resolve manually."
                return
            }
            Move-Item $Destination $backup
            Write-Host "  backed up: $Destination -> $backup"
        }
    }

    New-Item -ItemType $LinkType -Path $Destination -Target $Source | Out-Null
    Write-Host "  linked:    $Destination -> $Source"
}

Write-Host "Linking from: $Repo"
Write-Host ""

if (Should-Link 'nvim') {
    Write-Host "nvim:"
    Link-Path -Source "$Repo\nvim" -Destination "$env:LOCALAPPDATA\nvim" -LinkType Junction
}

# git/ is template-only — copy D:\repos\dotfiles\git\gitconfig to $env:USERPROFILE\.gitconfig
# by hand on a new machine. Not symlinked, not auto-linked.

# Add other Windows-applicable tools here as you create their folders:
# - powershell\Microsoft.PowerShell_profile.ps1 -> $PROFILE     (SymbolicLink)
# - starship\starship.toml                      -> $env:USERPROFILE\.config\starship.toml

Write-Host ""
Write-Host "Done. Restart your terminal (or reopen nvim) to apply."
