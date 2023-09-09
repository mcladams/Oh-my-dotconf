# powershell profile for dotconf git
try { $null = gcm pshazz -ea stop; pshazz init } catch { }

function conf { git --git-dir=$HOME\.conf.git --work-tree=$HOME $args }

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
