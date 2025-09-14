function prompt {
    $currentPath = (Get-Location).Path

    $green = "`e[92m"   
    $reset = "`e[0m"

    "$green$currentPath $ $reset"
}


# File and Directory Helpers
function touch { param($f) "" | Out-File $f -Encoding ASCII }
function nf    { param($f) New-Item -ItemType File -Path . -Name $f }
function mkcd  { param($d) mkdir $d -Force; Set-Location $d }

# Navigation
# Passe die Pfade an deine Projekte an
$global:projects = @{
    "backend" = "C:\Users\DeinName\Projects\Backend"
    "frontend" = "C:\Users\DeinName\Projects\Frontend"
}

function proj {
    param(
        [Parameter(Mandatory=$true)]
        [string]$name
    )
    if ($projects.ContainsKey($name)) {
        Set-Location $projects[$name]
    } else {
        Write-Host "Projekt '$name' nicht gefunden" -ForegroundColor Red
    }
}


function docs  { Set-Location ([Environment]::GetFolderPath("MyDocuments")) }
function desk  { Set-Location ([Environment]::GetFolderPath("Desktop")) }
function home  { Set-Location $HOME }

# File Listing
function la    { Get-ChildItem | Format-Table -AutoSize }
function ll    { Get-ChildItem -Force | Format-Table -AutoSize }

# Git Shortcuts
function gs    { git status }
function ga    { git add . }
function gp    { git push }
function gc    { param($m) git add .; git commit -m "$m" }

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
