. $PSScriptRoot\PromptUtils.ps1

Function elevate_process() {
    $file, [string]$arguments = $args
    $psi = new-object System.Diagnostics.ProcessStartInfo $file;
    $psi.Arguments = $arguments;
    $psi.Verb = "runas";
    $psi.WorkingDirectory = Get-Location;
    [System.Diagnostics.Process]::Start($psi);
}

Function prompt {
    print_status
#    print_prompt_number
    print_context
    print_dir
    print_npm
    print_git
    end_segment
    return [char]0x200A
}

Set-Alias sudo elevate_process
