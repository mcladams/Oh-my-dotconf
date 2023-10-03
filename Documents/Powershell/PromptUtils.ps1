$CURRENT_BG=$null
$NPM_VERSION=$null

. $PSScriptRoot\Config.ps1

if (Get-Command npm -ErrorAction SilentlyContinue) {
    $Global:NPM_VERSION = $(npm --version)
}
if (Test-Path $PSScriptRoot\install.ps1) {
    . $PSScriptRoot\install.ps1
}


Function print_segment($bg = 'Black', $fg = 'Blue', $str) {
    if($CURRENT_BG -and $CURRENT_BG -ne $bg) {
        Write-Host "$SEGMENT_DELIMETER_GLYPH" -ForegroundColor $CURRENT_BG -BackgroundColor $bg -NoNewline
    }
    $Global:CURRENT_BG = $bg
    Write-Host $str -ForegroundColor $fg -BackgroundColor $bg -NoNewline
}

Function end_segment() {
    Write-Host "$SEGMENT_DELIMETER_GLYPH" -ForegroundColor $CURRENT_BG -BackgroundColor Black -NoNewline
    $Global:CURRENT_BG=$null
    $Host.UI.RawUI.WindowTitle="Windows PowerShell v$($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)"
}

Function print_status() {
    if (-Not $?) {
        Write-Host "$PREV_CMD_FAIL_GLYPH " -ForegroundColor Red -NoNewline
        $flag=$TRUE
    }
    Get-Job | % {
        if ($_.State -eq "Running") {
            Write-Host "$BGTASK_GLYPH " -ForegroundColor Cyan -NoNewline
            $flag=$TRUE
        }
    }
    if ((whoami /all | select-string S-1-16-12288) -ne $null) {
        Write-Host "$ELEVATED_GLYPH " -ForegroundColor Yellow -NoNewline
        $flag=$TRUE
    }
    if ($flag) {$Global:CURRENT_BG='Black'}
}

Function print_prompt_number() {
    ${Global:CNT_OF_PRMT}++

    Write-Host '#' -NoNewline
    print_segment $PRMT_NUM_BG $PRMT_NUM_FG $("000000000${GLOBAL:CNT_OF_PRMT}").ToString().Substring($("000000000${GLOBAL:CNT_OF_PRMT}").length-4 , 4)
}

Function print_context() {
    if($PRINT_DEFAULT_USER -or ($DEFAULT_USER -ne ${env:UserName})) {
        print_segment $CONTEXT_BG $CONTEXT_FG "${env:UserName}@${env:ComputerName}"
    }
}

Function print_dir() {
    if ($COLLAPSE_DIR -and ((($pwd).ToString().ToCharArray() | Where-Object {$_ -eq '\'} | Measure-Object).Count) -gt 1) {
        print_segment $DIR_BG $DIR_FG " $($pwd.Drive.Root)..\$($pwd | Split-Path -Leaf)"
    }
    else {
        print_segment $DIR_BG $DIR_FG " $pwd"
    }
}

Function print_git() {
    if(Get-Command git -ErrorAction SilentlyContinue) {
        if ($(git rev-parse --is-inside-work-tree 2>$null)) {
            $branch = $(git symbolic-ref HEAD 2>$null).ToString().Substring(11)
            $gitStatus=$(git status | select -last 1)
            if (($gitStatus -eq "nothing to commit, working directory clean") -or
                (($gitStatus -eq "nothing added to commit but untracked files present (use `"git add`" to track)") -and $DISABLE_UNTRACKED_FILES_DIRTY)) {
                print_segment $GIT_CLEAN_BG $GIT_CLEAN_FG "$GIT_BRANCH_GLYPH $branch"
            }
            elseif ($gitStatus -eq "nothing added to commit but untracked files present (use `"git add`" to track)") {
                print_segment $GIT_DIRTY_BG $GIT_DIRTY_FG "$GIT_BRANCH_GLYPH $branch $GIT_UNTRACKED_GLYPH"
            }
            elseif ($gitStatus -eq "no changes added to commit (use `"git add`" and/or `"git commit -a`")") {
                print_segment $GIT_DIRTY_BG $GIT_DIRTY_FG "$GIT_BRANCH_GLYPH $branch $GIT_DIRTY_GLYPH"
            }
        }
    }
}

Function print_npm() {
    if ((Get-Command npm -ErrorAction SilentlyContinue) -and (!$NPM_HIDE_NO_PACKAGE -or (Test-Path .\package.json))) {
        print_segment $NPM_BG $NPM_FG "npm $NPM_VERSION"
    }
}
