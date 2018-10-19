## Ubicar todos los scripts en $Home\[My ]Documents\WindowsPowerShell

Set-PSReadlineKeyHandler -Key Tab -Function Complete

## Prompt
function prompt
{
    $black = "$([char]27)[0;30m"
    $red = "$([char]27)[0;31m"
    $green = "$([char]27)[0;32m"
    $yellow = "$([char]27)[0;33m"
    $blue = "$([char]27)[0;34m"
    $magenta = "$([char]27)[0;35m"
    $cyan = "$([char]27)[0;36m"
    $white = "$([char]27)[0;37m"
    $default = "$([char]27)[0;39m"

    $bblack = "$([char]27)[1;30m"
    $bred = "$([char]27)[1;31m"
    $bgreen = "$([char]27)[1;32m"
    $byellow = "$([char]27)[1;33m"
    $bblue = "$([char]27)[1;34m"
    $bmagenta = "$([char]27)[1;35m"
    $bcyan = "$([char]27)[1;36m"
    $bwhite = "$([char]27)[1;37m"

    $current = "$cyan$env:USERNAME$default at $magenta$(($env:COMPUTERNAME).ToLower())$default in $blue$(Get-Location)$default "
    $branch = ""
    $dirty = ""
    $ahead = ""
    $behind = ""

    if (git status 2> $null)
    {
        $gline =  "$(git branch -vv | where {$_ -Match '\* '})"
        $match = [regex]::Match($gline, '\* (\w+).+\[(\w+)/(\w+).+\].+')

        if ($match.Success)
        {
            $branch = $match.Captures.Groups[1].Value
            $remote = $match.Captures.Groups[2].Value
            $upstream = $match.Captures.Groups[3].Value

            $dirty = [regex]::Match("$(git status -suno)", '\w .+')
            if ($dirty.Success) { $dirty=" $byellow*$default" }
            else { $dirty = "" }

            $gst = git status --short --branch | where {$_ -match '## '}

            $stmatch = [regex]::Match($gst, '.*behind (\d+).*')
            if ($stmatch.Success) {$stcount = $stmatch.Captures.Groups[1].Value} else {$stcount = 0}
            if ($stcount -gt 0) { $behind = " $bred-$stcount$default" }

            $stmatch = [regex]::Match($gst, '.*ahead (\d+).*')
            if ($stmatch.Success) {$stcount = $stmatch.Captures.Groups[1].Value} else {$stcount = 0}
            if ($stcount -gt 0) { $ahead=" $bgreen+$stcount$default" }
        }
        else
        {
            $match = [regex]::Match($gline, '\* (\w+).+')
            $branch = $match.Captures.Groups[1].Value

            $dirty = [regex]::Match("$(git status -suno)", '\w .+')
            if ($dirty.Success) { $dirty=" $byellow*$default" }
            else { $dirty = "" }
        }
        $branch="on $bblack$branch$default"
    }

    $first = ""
    $middle = "$current$branch$dirty$behind$ahead"
    $last = "$yellow>>$default "
    return "$first`n$middle`n$last"
}

## Unix like
function touch
{
    Param([Parameter(Mandatory=$true)] [string]$Path)

    if (Test-Path -LiteralPath $Path) { (Get-Item -Path $Path).LastWriteTime = Get-Date }
    else { New-Item -Type File -Path $Path }
}

del alias:curl -Force
function curl
{
    Param([Parameter(Mandatory=$true)] [System.Uri]$Url)

    $CurrentProgressPreference = $ProgressPreference
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $Url.OriginalString -OutFile $Url.Segments[-1]
    $ProgressPreference = $CurrentProgressPreference
}

New-Alias -Name which -Value Get-Command
New-Alias -Name grep -Value Select-String
# Grep: gb -vv | where {$_ -Match '\* '}
# Sed:  gb --color=never | % {$_ -Replace '\*\ ', ''}
New-ALias -Name open -Value start

function manual-virtualenv
{
    if (!$args) { $args = 3 }
    $param = [string]$args
    while ($param.StartsWith('-')) { $param = $param.Substring(1) }

    if ($param -eq 'rm')
    {
        if (Test-Path -Path '.venv')
        {
            echo "Eliminando virtual environment..."
            rm -r .venv
        }
        else
        {
            echo "No existe virtual environment."
        }
        return
    }

    if (Test-Path -Path '.venv')
    {
        echo "Eliminando virtual environment actual..."
        rm -r .venv
    }
    switch ($param)
    {
        "2"
        {
            echo "Creando virtual environment con Python 2..."
            virtualenv .venv > $null
        }
        "3"
        {
            echo "Creando virtual environment con Python 3..."
            python -m venv .venv
        }
        default { echo "Parámetro no soportado ($args)" }
    }
}
New-ALias -Name venv -Value manual-virtualenv

## Utilidades
function clean-dir { Get-ChildItem .\ -Include $args -Recurse | foreach ($_) {Remove-Item $_.FullName} }

## Alias para Git
$commit_format="%C(auto)%h %C(cyan)%ad%C(auto) %ae %s%d"
$date_format="short"

New-Alias -Name g -Value git

function git-clone { g clone $args }
New-Alias -Name gcl -Value git-clone

function git-add { g add $args }
New-Alias -Name ga -Value git-add

function git-branch { if (!$args) { g branch --all --verbose --verbose } else { g branch $args }  }
New-Alias -Name gb -Value git-branch

function git-blame { g blame --date=short $args }
New-Alias -Name gbl -Value git-blame

del alias:gc -Force
function git-commit { g commit $args }
New-Alias -Name gc -Value git-commit

function git-commit-amend { g commit --amend --no-edit $args }
New-Alias -Name gca -Value git-commit-amend

function git-checkout { g checkout $args }
New-Alias -Name gcheck -Value git-checkout

function git-cherry { g cherry --abbrev --verbose $args }
New-Alias -Name gcherry -Value git-cherry

function git-cherry-pick { g cherry-pick $args }
New-Alias -Name gchpick -Value git-cherry-pick

function git-diff { g diff --patience $args }
New-Alias -Name gd -Value git-diff

function git-fetch { if (!$args) { g fetch --all --prune } else { g fetch $args }  }
New-Alias -Name gf -Value git-fetch

del alias:gl -Force
function git-log { g log --graph --pretty=format:$commit_format --date=$date_format $args }
New-Alias -Name gl -Value git-log

function git-log-diff-branches { g log --graph --pretty=format:$commit_format --date=relative $args }
New-Alias -Name glb -Value git-log-diff-branches

del alias:gm -Force
function git-merge { g merge $args }
New-Alias -Name gm -Value git-merge

function git-push { g push $args }
New-Alias -Name gpush -Value git-push

function git-pull { g pull $args }
New-Alias -Name gpull -Value git-pull

function git-reset { g reset $args }
New-Alias -Name gr -Value git-reset

function git-rm { g rm $args }
New-Alias -Name grm -Value git-rm

function git-status { g status --short --branch $args }
New-Alias -Name gs -Value git-status

function git-show { g show --stat --pretty=format:$commit_format --date=$date_format $args }
New-Alias -Name gsh -Value git-show

function git-stash { if (!$args) { g stash --include-untracked } else { g stash $args } }
New-Alias -Name gst -Value git-stash

function git-tag { g tag $args }
New-Alias -Name gt -Value git-tag

function git-rebase { if (!$args) { g rebase --interactive --autostash } else { g rebase $args } }
New-Alias -Name grb -Value git-rebase

function git-remote { if (!$args) { g remote --verbose } else { g remote $args }  }
New-Alias -Name grem -Value git-remote
