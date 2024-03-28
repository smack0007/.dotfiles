$Profile = $MyInvocation.MyCommand.Path;
$ProfileRoot = $PSScriptRoot;
$DotfilesRoot = (Get-Item $ProfileRoot).Parent.FullName;

# Set the HOME environment variable for git
$env:HOME = $env:USERPROFILE;

# Add current directory to path
$env:PATH = $ProfileRoot + ";" + $env:PATH;

$colors = @{
    "hostBackground" = $Host.UI.RawUI.BackgroundColor;
    "distroBackground" = [ConsoleColor]::White;
    "distroForeground" = [ConsoleColor]::Black;
    "pathBackground" = [ConsoleColor]::Blue;
    "pathForeground" = [ConsoleColor]::White;
    "gitUnchangedBackground" = [ConsoleColor]::Green;
    "gitChangedBackground" = [ConsoleColor]::DarkYellow;
    "gitForeground" = [ConsoleColor]::Black;
};

$glyphs = @{
    "windows_logo" = [char]::ConvertFromUtf32(0xF17A)
    "left_hard_divider" = [char]::ConvertFromUtf32(0xE0B0)
    "folder_open" = [char]::ConvertFromUtf32(0xF07B)
    "git_branch" = [char]::ConvertFromUtf32(0xE725)
};

function __writePromptDivdier
{
    param([ConsoleColor] $fromColor, [ConsoleColor] $toColor)
    Write-Host $glyphs["left_hard_divider"] -ForegroundColor $fromColor -BackgroundColor $toColor -NoNewLine;
}

function __updateWindowTitle
{
    $title = "";

    if (Test-Administrator) {
        $title += "ADMIN: ";
    }

    $title += $pwd;
    $Host.UI.RawUI.WindowTitle = $title;
}

function global:prompt
{
    # If not the first line of output then add an extra
    # line to seperate commands.
    if ($Host.UI.RawUI.CursorPosition.Y -ne 0) {
        Write-Host "";
    }

    $path = $pwd.Path;

    if (!$path.EndsWith("\")) {
        $path = $path + "\";
    }

    Write-Host (" " + $glyphs["windows_logo"] + " ") -BackgroundColor $colors["distroBackground"] -ForegroundColor $colors["distroForeground"] -NoNewLine;
    __writePromptDivdier $colors["distroBackground"] $colors["pathBackground"];
    Write-Host (" " + $glyphs["folder_open"] + " " + $path + " ") -BackgroundColor $colors["pathBackground"] -ForegroundColor $colors["pathForeground"] -NoNewLine;

    $gitBranch = git branch --show-current;
    if ($gitBranch) {
        $gitStatus = git status -s;
        if ($gitStatus) {
            $gitBackgroundColor = $colors["gitChangedBackground"];
        } else {
            $gitBackgroundColor = $colors["gitUnchangedBackground"];
        }
        
        __writePromptDivdier $colors["pathBackground"] $gitBackgroundColor;
        Write-Host (" " + $glyphs["git_branch"] + " " + $gitBranch + " ") -BackgroundColor $gitBackgroundColor -ForegroundColor $colors["gitForeground"] -NoNewLine;
        __writePromptDivdier $gitBackgroundColor $colors["hostBackground"];
    } else {
        __writePromptDivdier $colors["pathBackground"] $colors["hostBackground"];
    }
 
    Write-Host "";
    return "# ";
}

#
# Commands
#

function dotfiles-cd { Set-Location $DotfilesRoot; }
function dotfiles-code { code $DotfilesRoot; }
function dotfiles-explorer { explorer $DotfilesRoot; }
function dotfiles-gitex { pushd $DotfilesRoot; gitex; popd; }
function dotfiles-pull { pushd $DotfilesRoot; git pull; popd; }
function dotfiles-push { param($message) pushd $DotfilesRoot; git add -A && git commit -m "$message" && git push; popd; }
function dotfiles-status { pushd $DotfilesRoot; git status -s; popd; }

function env-get { param($key) $value = [System.Environment]::GetEnvironmentVariable($key); Write-Host $value; }
Set-Alias -Name get-env -Value env-get;

function env-list { Get-ChildItem Env:* | Sort-Object Name; }
Set-Alias -Name list-env -Value env-list;

function env-set { param($key, $value) [System.Environment]::SetEnvironmentVariable($key, $value); }
Set-Alias -Name set-env -Value env-set;

Remove-Alias -Name cd;
function cd { param($dir) Set-Location $dir; __updateWindowTitle }

function fork {
    & wt -w 0 -d "$(Get-Location)" "${env:PROGRAMFILES}\PowerShell\7\pwsh.exe" -noe -nop -nol -f "C:\cmd\pwsh\init.ps1" @args
}

function git-bash { & "${env:PROGRAMFILES}\Git\usr\bin\bash.exe" --login -i -l }

Set-Alias -Name e -Value explorer;
Set-Alias -Name grep -Value Select-String;
Set-Alias -Name ll -Value Get-ChildItem;

function mcd { param($dir) mkdir $dir && cd $dir; }
function mkdirp { param($dir) mkdir -p $dir; }

function rimraf { param($path) rm -r -force $path; }

# Credit: https://github.com/stephenn/powershell_sudo
function sudo() {
    if ($args.Length -eq 1) {
        start-process $args[0] -verb "runAs"
    }
    if ($args.Length -gt 1) {
        start-process $args[0] -ArgumentList $args[1..$args.Length] -verb "runAs"
    }
}

function time {
    $Command = "$args";
    (Measure-Command { Invoke-Expression $Command 2>&1 | Out-Default }).ToString();
}

function which { param($command) (Get-Command $command).Path; }

# 7z
if (Test-Path "C:\Program Files\7-Zip\7z.exe") {
    Set-Alias -Name 7z -Value "C:\Program Files\7-Zip\7z.exe";
}

function wslcode { param($dir) wsl.exe -- code $dir; }

#
# Functions
#

function Test-Administrator  
{  
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}

__updateWindowTitle

# If any arguments are passed to the script
if ($args.Length -gt 0) {
    & @args
}