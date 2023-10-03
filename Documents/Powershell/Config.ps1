#If this isn't the user using the shell, username@host will be displayed (if enabled)
$DEFAULT_USER='Mike'

#True to print username@host event if it's the default user
$PRINT_DEFAULT_USER=$FALSE

#Glyphs
$SEGMENT_DELIMETER_GLYPH=[char]0xE0B0 # î‚°
$PREV_CMD_FAIL_GLYPH=[char]0x2718 # âœ˜
$BGTASK_GLYPH=[char]0x2699 # âš™
$ELEVATED_GLYPH=[char]0x26A1 # âš¡
$GIT_BRANCH_GLYPH=[char]0xE0A0 # î‚ 
$GIT_DIRTY_GLYPH=[char]0x25CF # â—
$GIT_UNTRACKED_GLYPH=[char]0x271A # âœš

#True to collapse folder names between drive letter and current folder name
$COLLAPSE_DIR=$FALSE

#True to mark git repos with untracked files clean
$DISABLE_UNTRACKED_FILES_DIRTY=$FALSE

#True to only show the npm version if the current folder contains package.json
$NPM_HIDE_NO_PACKAGE=$TRUE

#Segment colors
$PRMT_NUM_BG='Black'
$PRMT_NUM_FG='Blue'
$CONTEXT_BG='Yellow'
$CONTEXT_FG='Black'
$DIR_BG='Blue'
$DIR_FG='Black'
$GIT_CLEAN_BG='Green'
$GIT_CLEAN_FG='Black'
$GIT_DIRTY_BG='Yellow'
$GIT_DIRTY_FG='Black'
$NPM_BG='Magenta'
$NPM_FG='Black'
