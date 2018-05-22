## Ubicar todos los scripts en $Home\[My ]Documents\WindowsPowerShell

## Unix like
function touch {
    Param([Parameter(Mandatory=$true)] [string]$Path)

    if (Test-Path -LiteralPath $Path) { (Get-Item -Path $Path).LastWriteTime = Get-Date }
    else { New-Item -Type File -Path $Path }
}

New-Alias -Name grep -Value Select-String
New-ALias -Name open -Value start

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

function git-add { g add $args }
New-Alias -Name ga -Value git-add

function git-branch { if (!$args) { g branch --all --verbose } else { g branch $args }  }
New-Alias -Name gb -Value git-branch

function git-blame { g blame --date=short $args }
New-Alias -Name gbl -Value git-blame

del alias:gc -Force
function git-commit { g commit $args }
New-Alias -Name gc -Value git-commit

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

function git-status { g status --short $args }
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
