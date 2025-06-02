function prompt {
    $lastExit = if ($?) { "" } else { "$([char]0x274C) " }  # ❌
    $admin = if (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrator")) {
        "$([char]0x1F512) "  # 🔒
    } else { "" }

    $path = "$([char]0x1F4C2) " + (Get-Location).Path  # 📂
    
    $git = ""
    if (Test-Path .git -or (Get-Command git -ErrorAction SilentlyContinue)) {
        try {
            $branch = git rev-parse --abbrev-ref HEAD 2>$null
            if ($branch) {
                $git = "  $branch"  # nf-dev-git
            }
        } catch {}
    }

    "$lastExit$admin$path$git`n❯ "
}

# File and Directory Helpers
function touch { param($f) "" | Out-File $f -Encoding ASCII }
function nf    { param($f) New-Item -ItemType File -Path . -Name $f }
function mkcd  { param($d) mkdir $d -Force; Set-Location $d }

# Navigation
function docs  { Set-Location ([Environment]::GetFolderPath("MyDocuments")) }
function desk  { Set-Location ([Environment]::GetFolderPath("Desktop")) }
function home  { Set-Location $HOME }

# Process Helpers
function k9    { param($n) Stop-Process -Name $n }

# File Listing
function la    { Get-ChildItem | Format-Table -AutoSize }
function ll    { Get-ChildItem -Force | Format-Table -AutoSize }

# Git Shortcuts
function gs    { git status }
function ga    { git add . }
function gc    { param($m) git commit -m "$m" }
function gp    { git push }
function gcl   { param($url) git clone $url }
function gcom  { param($m) git add .; git commit -m "$m" }
function lazyg { param($m) git add .; git commit -m "$m"; git push }

# Clipboard
function cpy   { param($t) Set-Clipboard $t }
function pst   { Get-Clipboard }

# Search
function ff    { param($n) Get-ChildItem -Recurse -Filter "*$n*" -ErrorAction SilentlyContinue | ForEach-Object { $_.FullName } }
function grep  { param($r, $d) if ($d) { Get-ChildItem $d | Select-String $r } else { $input | Select-String $r } }

# My Docker Dev Container
function RunDockerEnvironment {
    param(
        [string[]]$Ports
    )

    # Determine container runtime
    $containerCmd = if (Get-Command docker -ErrorAction SilentlyContinue) {
        "docker"
    } elseif (Get-Command podman -ErrorAction SilentlyContinue) {
        "podman"
    } else {
        Write-Error "Neither Docker nor Podman is installed."
        return
    }

    # Base Docker args
    $argsList = @(
        "run"
        "-it"
        "--rm"
        "-v", "$pwd/:/home/devuser/project"
    )

    # Add -p args if ports provided
    if ($Ports -and $Ports.Count -gt 0) {
        foreach ($port in $Ports) {
            if ($port -match '^\d+$') {
                $argsList += "-p"
                $argsList += "$port`:$port"
            } else {
                $argsList += "-p"
                $argsList += $port
            }
        }
    }

    # Append image name
    $argsList += "andrijkoenig/dev-env:latest"

    # Run container
    & $containerCmd @argsList
}

Set-Alias rde RunDockerEnvironment
