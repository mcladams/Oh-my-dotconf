# ensure ssh-agent will work for gcm
Set-Service ssh-agent -StartupType Manual

# import our modules
foreach ($psmod in (Get-ChildItem -Path $HOME\Documents\Powershell\Modules).Name) {
    Import-Module $psmod
    Write-Host "$psmod loaded - try `"Get-Command -Modules $psmod`""
}

# powershell profile for dotconf git; use 'conf' not 'git' in $HOME
function conf { git --git-dir="$HOME\.conf.git\" --work-tree=$HOME $args }

# aliases
  Set-Alias -Name npp -Value "$env:PROGRAMFILES\Notepad++\notepad++.exe"
# prevent conf rm removing from working tree
  Set-Alias -Name "conf rm" -Value "conf rm --cached"
try { $null = gcm pshazz -ea stop; pshazz init 'default' } catch { }

# variables
Set-Variable -Name "EDITOR" -Option "AllScope" -Scope "Global" -Value "nano"

# prompt
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\kali.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\night-owl.omp.json" | Invoke-Expression
