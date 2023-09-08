# set env and install to c:\Scoop for user
$env:SCOOP='SCOOP'
[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP)
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
# essentials
scoop install 7zip git curl sudo
sudo scoop install --globsal 7zip git curl
# four levels of unix utils install in order or comment
busybox
gow 
coreutils findutils
uutils-coreutils
# buckets
scoop bucket add extras
scoop bucket add versions
scoop bucket add nerd-fonts
scoop bucket add nonportable
# tools/apps
scoop install aria2 git-with-openssh grep sed gawk
install duf dust ripgrep lsd fd delta bat zoxide czkawka hyperfine helix
scoop install CascadiaCode-NF JetBrainsMono-NF FiraCode-NF
# apps
scoop install nano neovim kdiff3 vcredist2022 wsl-ssh-agent concfg 
pshazz lxrunoffline
sudo Set-Service ssh-agent -StartupType Manual
concfg export console-backup.json
