#!"C:\Program Files\PowerShell\7\pwsh.EXE"
# dot-functions.ps1
# source this in the nomal way to use the functions and add to $PROFILE
    # Get-Alias
    # Get-Variable
    # Get-Command -CommandType Function

# Recursively take ownership and set owner with full permissions
function Own-Full-Perms {
    param ( [string]$_path )

    takeown /F "$_path" /R /D Y /SKIPSL >$null 
    icacls "$_path" /grant:r ${env:USERNAME}:F /T /L /C /Q
}


# Make directory subtree case-sensitive (even not empty) by moving data to new sensitive dirs
function Move-CaseSensitive-InPlace {
    param ( [string]$_path )

    # Define dirs
    $_dirs = @($_path) + (Get-ChildItem -Path $_path -Recurse -Directory).FullName

    # Loop through each, rename, create new case sensitive, move contents, remove
    foreach ($_dir in $_dirs) {
        # Rename orig -> temp, create new empty orig
        Rename-Item -Path $_dir -NewName "${_dir}__"
        New-Item -Path $_dir -ItemType Directory

        # At the PS prompt, simply entering 'fsutil.exe file SetCaseSensitiveInfo $_dir enable' works but not in script
        Start-Process -FilePath "fsutil.exe" -ArgumentList "file SetCaseSensitiveInfo $_dir enable" `
          -Wait -NoNewWindow -RedirectStandardOutput $null

        # Move contents from the renamed folder & then remove empty folder
        Get-ChildItem -Path "${_dir}__" | Move-Item -Destination $_dir
        # better check _dir is empty before deletion
        if (Get-ChildItem -path "${_dir}__") {
            Write-Host "${_dir}__ not empty. Exiting."
            exit
        } else {
            Remove-Item -Path "${_dir}__"
        }
    }
}
