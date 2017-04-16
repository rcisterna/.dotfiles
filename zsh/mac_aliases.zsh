alias ls="ls -GFh"
alias tree="tree --dirsfirst -hpCL 2"
alias grep="grep --color=auto"

# Git aliases
alias gl="git log --graph --pretty=format:'%C(auto)%h %C(cyan)%ad %C(auto)(%an) %s' --date=iso"
alias gll="git log"
alias gs="git status --short"
alias gsl="git status"
alias ga="git add"
alias gd="git diff"
alias gdc="git diff --cached"
alias gc="git commit -m"
alias gca="git commit -am"
alias gf="git fetch"
alias gm="git merge"
alias gpull="git pull"
alias gpush="git push"

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
