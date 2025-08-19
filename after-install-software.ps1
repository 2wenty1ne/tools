# Windows Software Installation Script using winget
# Run this script as Administrator for best results

# Check if winget is available
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Error: winget is not installed or not available in PATH" -ForegroundColor Red
    Write-Host "Please install App Installer from Microsoft Store or Windows Package Manager from GitHub"
    exit 1
}

Write-Host "Starting software installation..." -ForegroundColor Green

# Define software packages to install
$packages = @(
    # Coding
    "Microsoft.VisualStudioCode",
    "Git.Git",
    "Python.Python.3",
    "OpenJS.NodeJS",
    "GoLang.Go",
    "PostgreSQL.PostgreSQL"
    "Figma.Figma",

    # Gaming
    "Valve.Steam",
    "Blizzard.BattleNet",
    "Ubisoft.Connect",
    "EpicGames.EpicGamesLauncher",
    "Discord.Discord",

    # Programs
    "Bitwarden.Bitwarden",
    "Mozilla.Firefox",
    "Zen-Team.Zen-Browser",
    "Obsidian.Obsidian",
    "Proton.ProtonVPN",
    "Telegram.TelegramDesktop",

    # Tools
    "TurtleBeach.ROCCATSwarm",
    "SteelSeries.GG",
    "JAMSoftware.TreeSize.Free",
    "7zip.7zip",
    "PDFsam.PDFsam",
    "ALCPU.CoreTemp",
    "dotPDN.PaintDotNet",
    "Genymobile.scrcpy",
    "Adobe.Acrobat.Reader.64-bit",
    "Microsoft.PowerToys"
)

$packages_not_in_winget = @(
    "Nvidia App",
    "VMware Workstation"
)

# Function to install a package
function Install-Package {
    param([string]$packageId)
    
    Write-Host "Installing $packageId..." -ForegroundColor Yellow
    
    try {
        winget install --id $packageId --accept-package-agreements --accept-source-agreements --silent
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ Successfully installed $packageId" -ForegroundColor Green
        } else {
            Write-Host "✗ Failed to install $packageId (Exit code: $LASTEXITCODE)" -ForegroundColor Red
        }
    }
    catch {
        Write-Host "✗ Error installing $packageId : $_" -ForegroundColor Red
    }
    
    Write-Host ""
}

# Install each package
foreach ($package in $packages) {
    Install-Package -packageId $package
}

Write-Host "Installation script completed!" -ForegroundColor Green
Write-Host "Some applications may require a system restart to function properly." -ForegroundColor Yellow

# Optional: Check what was installed
Write-Host "`nInstalled packages:" -ForegroundColor Cyan
winget list | Select-String -Pattern ($packages -join "|")

Write-Host "Don't forget to install: `n"
foreach ($package_not_in_winget in $packages_not_in_winget) {
    Write-Host "- $package_not_in_winget `n"
}

# Pause to see results
Read-Host -Prompt "Press Enter to exit"