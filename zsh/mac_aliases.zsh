# Aliases generales
alias ls="ls -GFh"
alias tree="tree --dirsfirst -hpCL 2"
alias grep="grep --color=auto"
alias vg="tt VAGRANT && vagrant"

# Git aliases
local commit_format="%C(auto)%h %C(cyan)%ad %C(auto)%ae (%an) %s"
local date_format="iso"

alias g="tt GIT && git"
alias gcl="g clone"
alias ga="g add"
alias gb="g branch --all --verbose --verbose"
alias gbl="g blame --date=short"
alias gc="g commit"
alias gca="g commit --amend --no-edit"
alias gcheck="g checkout"
alias gcherry="g cherry --abbrev --verbose"
alias gchpick="g cherry-pick"
alias gd="g diff --patience"
alias gf="g fetch --all --prune"
alias gl="g log --graph --pretty=format:'$commit_format' --date=$date_format"
alias glb="g log --graph --pretty=format:'$commit_format' --date=relative"
alias gm="g merge --rebase"
alias gpush="g push"
alias gpull="g pull --rebase"
alias gr="g reset"
alias grm="g rm"
alias gs="g status --short --branch"
alias gsh="g show --stat --pretty=format:'$commit_format' --date=$date_format"
alias gst="g stash --include-untracked"
alias gt="g tag"
alias grb="g rebase --interactive --autostash"
alias grem="g remote --verbose"

# Lista de dependencias para Homebrew
function brew_listdeps()
{
    if brew list > /dev/null; then
        brew list | while read cask; do
            echo -n $fg[blue]$cask $fg[white]
            brew deps $cask --include-build --include-optional --installed | awk '{printf(" %s", $0)}'
            echo ""
        done
    fi
}
