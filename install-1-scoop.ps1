# set env and install to c:\Scoop for user
#$env:SCOOP='c:\scoop'
#[Environment]::SetEnvironmentVariable('SCOOP', 'c:\scoop')
#Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
#irm get.scoop.sh | iex

# scoop install essentials
scoop install 7zip git curl sudo
sudo scoop install --global 7zip git curl

# four levels of unix utils install in order or comment out
# note: later scoop installs of a command overwrite previous shim
scoop install busybox
scoop install gow
scoop install coreutils #findutils
scoop install uutils-coreutils

# scoop buckets
scoop bucket add extras
scoop bucket add versions
scoop bucket add nerd-fonts
scoop bucket add nonportable

# linux utils
scoop install aria2 git-with-openssh grep sed gawk
# rust apps
scoop install duf dust ripgrep lsd fd delta bat zoxide czkawka hyperfine
# fonts
scoop install Cascadia-Code CascadiaCode-NF FiraCode FiraCode-NF 
JetBrains-Mono JetBrainsMono

# apps
scoop install nano neovim kdiff3 vcredist2022 wsl-ssh-agent concfg pshazz lxrunoffline
sudo Set-Service ssh-agent -StartupType Manual
concfg export console-backup.json
