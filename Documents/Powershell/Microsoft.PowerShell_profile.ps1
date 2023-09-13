# powershell profile for dotconf git; use 'conf' not 'git' in $HOME
function conf { git --git-dir=$HOME\.conf.git --work-tree=$HOME $args }

# aliases
Set-Alias -Name npp -Value "$env:PROGRAMFILES\Notepad++\notepad++.exe"

# something from pshazz module for loading ssh agent or keys
try { $null = gcm pshazz -ea stop; pshazz init } catch { }

# script to update scoop weekly
if (Get-Command scoop 2> $null) {
  $doUpdate = $true;
  if ($lastupdate = Get-Content "$env:LOCALAPPDATA\last-scoop-update-timestamp" 2> $null) {
    if ( (Get-Date -UnixTimeSeconds ([int]$lastupdate + 7 * 24 * 60)) -gt (Get-Date) ) {
      $doUpdate = $false
    }
  }
  if ($doUpdate) {
    scoop update;
    sudo scoop update -a -g;
    sudo scoop cleanup -a -g;
    Get-Date -UFormat "%s" > "$env:LOCALAPPDATA\last-scoop-update-timestamp";
  }
}

# check if Documents is a link and replace with target
#if ( !$(Get-Item $env:USERPROFILE\Downloads).target) {
#	$targ = $(echo $env:USERPROFILE\Downloads)
#} else {
#	$targ = $(Get-Item $env:USERPROFILE\Downloads).target
#}
