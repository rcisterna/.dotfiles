# Aliases generales
alias ls="ls -GFh"
alias tree="tree --dirsfirst -hpCL 2"
alias grep="grep --color=auto"
alias vg="tt VAGRANT && vagrant"

# Git aliases
local commit_format="%C(auto)%h %C(cyan)%ad %C(auto)(%an) %s"
local date_format="iso"

alias g="tt GIT && git"
alias ga="g add"
alias gb="g branch"
alias gba="g branch -a"
alias gbl="g blame --date=short"
alias gc="g commit"
alias gca="g commit --amend"
alias gch="g checkout"
alias gchp="g cherry-pick"
alias gd="g diff --patience"
alias gdc="g diff --cached"
alias gds="g diff --stat"
alias gf="g fetch"
alias gl="g log --graph --pretty=format:'$commit_format' --date=$date_format"
alias gll="g log"
alias gm="g merge"
alias gp="g push"
alias gpt="g push --tags"
alias gpull="g pull"
alias gr="g reset"
alias grm="g rm"
alias grh="g reset --hard"
alias grs="g reset --soft"
alias gs="g status --short"
alias gsb="g status --short --branch"
alias gsh="g show --stat --pretty=format:'$commit_format' --date=$date_format"
alias gst="g stash"
alias gt="g tag"

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
