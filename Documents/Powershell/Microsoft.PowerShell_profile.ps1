# powershell profile for dotconf git; use 'conf' not 'git' in $HOME
function conf { git --git-dir="$HOME\.conf.git\" --work-tree=$HOME $args }

# aliases
  Set-Alias -Name npp -Value "$env:PROGRAMFILES\Notepad++\notepad++.exe"
# prevent conf rm removing from working tree
  Set-Alias -Name "conf rm" -Value "conf rm --cached"
