# About
Custom prompt for Windows PowerShell that implements the Powerline theme
This prompt is inspired by the [agnoster theme](https://gist.github.com/agnoster/3712874) for [oh-my-zsh](https://gist.github.com/agnoster/3712874)

# How to install
* Install the [Powerline-patched fonts](https://github.com/powerline/fonts) for the icons to render correctly.
* Download the gist files
* Extract the archive to one of your PowerShell Profile folders (ex. %UserProfile%\Documents\WindowsPowerShell )
* Open PowerShell<br>
The first time, it will ask you whether you want to run the scripts. The install.ps1 script will get called on the first run and it will make the files look like you created them, so this warning won't appear again. The script also cleans the directory so you'll be left off with just what you need.<br>

# How to modify
To modify colors and variables, edit the Config.ps1 script. Here, you can change the colors, glyphs and some switches for git and the theme.
To add/remove segments, comment/uncomment the "print_\*" function calls.

# How to extend
To add your own segment, add a function, preferably, but not necessairly, to the PromptUtils.ps1 script and then call it from the "prompt" function in profile.ps1.
To render the segment, call the "print_segment" function, which accepts 3 parameters: background color, foreground color and the text