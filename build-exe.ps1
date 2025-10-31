# PowerShell script to compile thumbnail generator
Write-Host "Compiling thumbnail generator..." -ForegroundColor Green

# Check if ps2exe module is installed
if (!(Get-Module -ListAvailable -Name ps2exe)) {
    Write-Host "Installing ps2exe module..." -ForegroundColor Yellow
    Install-Module -Name ps2exe -Force -Scope CurrentUser
}

# Import the module
Import-Module ps2exe

# Compile the script
try {
    Invoke-ps2exe -inputFile "ThumbnailGenerator.ps1" -outputFile "ThumbnailGenerator.exe" -title "ThumbnailGenerator" -description "Batch Image Thumbnail Generator" -company "Local" -version "1.0.0.0" -copyright "Local" -noConsole:$false
    
    if (Test-Path "ThumbnailGenerator.exe") {
        Write-Host "Compilation successful! Generated ThumbnailGenerator.exe" -ForegroundColor Green
        Write-Host "You can place this exe file in any directory containing images to run it" -ForegroundColor Cyan
    } else {
        Write-Host "Compilation failed - exe file not found" -ForegroundColor Red
    }
} catch {
    Write-Host "Compilation error: $($_.Exception.Message)" -ForegroundColor Red
}

Read-Host "Press Enter to exit"