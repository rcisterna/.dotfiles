## Ubicar todos los scripts en $Home\[My ]Documents\WindowsPowerShell

## Unix like
function touch {
    Param([Parameter(Mandatory=$true)] [string]$Path)

    if (Test-Path -LiteralPath $Path) { (Get-Item -Path $Path).LastWriteTime = Get-Date }
    else { New-Item -Type File -Path $Path }
}
New-Alias -Name grep -Value Select-String

## Agregar "activate" para conda envs
if (Get-Command conda -errorAction SilentlyContinue)
{
    function conda-activate-env { Invoke-Expression "$PSScriptRoot\activate.ps1 $args" }
    New-Alias activate conda-activate-env
}

## Alias para Git
$commit_format="%C(auto)%h %C(cyan)%ad %C(auto)%ae (%an) %s"
$date_format="iso"

New-Alias -Name g -Value git

function git-add { git add $args }
New-Alias -Name ga -Value git-add

function git-branch { git branch $args }
New-Alias -Name gb -Value git-branch

function git-blame { git blame --date=short $args }
New-Alias -Name gbl -Value git-blame

del alias:gc -Force
function git-commit { git commit $args }
New-Alias -Name gc -Value git-commit

function git-checkout { git checkout $args }
New-Alias -Name gch -Value git-checkout

function git-cherry { git cherry-pick $args }
New-Alias -Name gchp -Value git-cherry

function git-diff { git diff --patience $args }
New-Alias -Name gd -Value git-diff

function git-fetch { git fetch $args }
New-Alias -Name gf -Value git-fetch

del alias:gl -Force
function git-log { git log --graph --pretty=format:$commit_format --date=$date_format $args }
New-Alias -Name gl -Value git-log

del alias:gm -Force
function git-merge { git merge $args }
New-Alias -Name gm -Value git-merge

function git-push { git push $args }
New-Alias -Name gpush -Value git-push

function git-pull { git pull $args }
New-Alias -Name gpull -Value git-pull

function git-reset { git reset $args }
New-Alias -Name gr -Value git-reset

function git-rm { git rm $args }
New-Alias -Name grm -Value git-rm

function git-status { git status --short $args }
New-Alias -Name gs -Value git-status

function git-status { git status --short --branch $args }
New-Alias -Name gsb -Value git-status

function git-show { git show --stat --pretty=format:$commit_format --date=$date_format $args }
New-Alias -Name gsh -Value git-show

function git-stash { git stash $args }
New-Alias -Name gst -Value git-stash

function git-tag { git tag $args }
New-Alias -Name gt -Value git-tag

function git-rebase { git rebase --interactive --autostash $args }
New-Alias -Name grb -Value git-rebase

function git-remote { git remote --verbose $args }
New-Alias -Name grem -Value git-remote
