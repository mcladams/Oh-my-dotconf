#!"C:\Program Files\PowerShell\7\pwsh.EXE"
# Make-CaseSensitive-InPlace.ps1
param ( [string]$targetdir )

# uncomment if we need to recurively take ownership of the directory
# takeown /F "$targetdir" /R /D Y /SKIPSL >$null

# uncomment if we need to give ourselves full permissions of the dir tree
# icacls "$targetdir" /grant:r ${env:USERNAME}:F /T /L /C /Q


# Make directory subtree case-sensitive (even not empty) by moving data to new sensitive dirs
function Move-to-CaseSensitive {
    param ( [string]$_path )

    # Define dirs
    $_dirs = @(Get-Item -Path $_path).FullName + (Get-ChildItem -Path $_path -Recurse -Directory).FullName

    # Loop through each, rename, create new case sensitive, move contents, remove
    foreach ($_dir in $_dirs) {
        # Rename orig -> temp, create new empty orig
        Rename-Item -Path $_dir -NewName "${_dir}__"
        New-Item -Path $_dir -ItemType Directory

        # fsutil.exe file... works at commadline, not in script without encapsulatio of parameters
        Start-Process -FilePath "fsutil.exe" -ArgumentList "file SetCaseSensitiveInfo $_dir enable" `
          -Wait -NoNewWindow -RedirectStandardOutput "${env:Temp}\null.txt"

        # Move contents from the renamed folder & then remove empty folder
        Get-ChildItem -Path "${_dir}__" -Force | Move-Item -Destination $_dir
        # better check _dir is empty before deletion
        if (Get-ChildItem -path "${_dir}__") {
            Write-Host "${_dir}__ not empty. Exiting."
            exit
        } else {
            Remove-Item -Path "${_dir}__"
        }
    }
}

Move-to-CaseSensitive $targetdir