Write-Host "###################################" -ForegroundColor Cyan
Write-Host "#      PAYA'S DOTFILE HELPER      #" -ForegroundColor Cyan
Write-Host "###################################`n`n" -ForegroundColor Cyan

Write-Host "WELCOME, $Env:USERNAME!"
Write-Host "We'll be setting up your computer..."

Write-Host "`nInstalling Powershell 7..." -ForegroundColor DarkBlue
winget install Microsoft.Powershell
Write-Host "Done!" -ForegroundColor White -BackgroundColor Green
Write-Host -BackgroundColor Black

Write-Host "`nInstalling chezmoi..." -ForegroundColor DarkBlue
winget install twpayne.chezmoi
Write-Host "Done!" -ForegroundColor White -BackgroundColor Green
Write-Host -BackgroundColor Black

Write-Host "`nInstalling 1Password CLI..." -ForegroundColor DarkBlue
winget install AgileBits.1Password.CLI
Write-Host "Done!" -ForegroundColor White -BackgroundColor Green
Write-Host -BackgroundColor Black

Write-Host "`nInstalling 1Password..." -ForegroundColor DarkBlue
winget install AgileBits.1Password
Write-Host "Done!" -ForegroundColor White -BackgroundColor Green
Write-Host -BackgroundColor Black

Write-Host "`nSign into 1password, then close it:"
start 1password
Pause
op signin

Write-Host "Initializing dotfiles from https://github.com/Tinkering-Townsperson/dotfiles.git ..." -ForegroundColor DarkBlue
chezmoi init https://github.com/Tinkering-Townsperson/dotfiles.git
Write-Host "Done!" -ForegroundColor White -BackgroundColor Green
Write-Host "`n" -BackgroundColor Black

$showDiff = $Host.UI.PromptForChoice("Show a diff of incoming file changes?", "Choose an option:", @("&1. Yes", "&2. No"), 0)

chezmoi status

if ($showDiff -eq 0) {
    chezmoi diff
}

$proceedApply = $Host.UI.PromptForChoice("Are you happy with these incoming changes and would like to apply them to your system?", "Choose an option:", @("&1. Yes", "&2. No"), 0)

if ($proceedApply -eq 0)
{
    Write-Host "Applying changes..." -ForegroundColor Yellow

    chezmoi apply -v
}


Write-Host "Thank you for using my dotfiles helper!" -ForegroundColor White -BackgroundColor Cyan
Write-Host "Find more repositories at https://github.com/Tinkering-Townsperson" -ForegroundColor White -BackgroundColor Cyan
Write-Host "Or visit my website at https://tinkering-townsperson.github.io" -ForegroundColor White -BackgroundColor Cyan
