## Ubicar todos los scripts en $Home\[My ]Documents\WindowsPowerShell

## Ubicación por defecto en D:
Set-Location D:\

Set-PSReadlineKeyHandler -Key Tab -Function Complete

## Prompt
function prompt
{
    $black = "$([char]27)[30m"
    $red = "$([char]27)[31m"
    $green = "$([char]27)[32m"
    $yellow = "$([char]27)[33m"
    $blue = "$([char]27)[34m"
    $magenta = "$([char]27)[35m"
    $cyan = "$([char]27)[36m"
    $white = "$([char]27)[37m"
    $default = "$([char]27)[39m"

    $first = ""
    $middle = "$cyan$env:USERNAME$default at $magenta$(($env:COMPUTERNAME).ToLower())$default in $blue$(Get-Location)$default"
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
New-ALias -Name open -Value start

## Utilidades
function clean-dir { Get-ChildItem .\ -Include $args -Recurse | foreach ($_) {Remove-Item $_.FullName} }

## Alias para Git
$commit_format="%C(auto)%h %C(cyan)%<(15)%ad%C(auto)%ae%d %s"
$date_format="relative"

New-Alias -Name g -Value git

function git-add { g add $args }
New-Alias -Name ga -Value git-add

function git-branch { if (!$args) { g branch --all --verbose } else { g branch $args }  }
New-Alias -Name gb -Value git-branch

function git-blame { g blame --date=short $args }
New-Alias -Name gbl -Value git-blame

del alias:gc -Force
function git-commit { g commit $args }
New-Alias -Name gc -Value git-commit

function git-commit-amend { g commit --amend --no-edit $args }
New-Alias -Name gca -Value git-commit-amend

function git-checkout { g checkout $args }
New-Alias -Name gch -Value git-checkout

function git-cherry { g cherry-pick $args }
New-Alias -Name gchp -Value git-cherry

function git-diff { g diff --patience $args }
New-Alias -Name gd -Value git-diff

function git-fetch { g fetch $args }
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

function git-stash { g stash $args }
New-Alias -Name gst -Value git-stash

function git-tag { g tag $args }
New-Alias -Name gt -Value git-tag

function git-rebase { if (!$args) { g rebase --interactive --autostash } else { g rebase $args } }
New-Alias -Name grb -Value git-rebase

function git-remote { if (!$args) { g remote --verbose } else { g remote $args }  }
New-Alias -Name grem -Value git-remote
