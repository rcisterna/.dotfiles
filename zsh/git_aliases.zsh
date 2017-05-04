# Git aliases
local commit_format="%C(auto)%h %C(cyan)%ad %C(auto)(%an) %s"
local date_format="iso"

alias g="git"
alias ga="git add"
alias gb="git branch"
alias gba="git branch -a"
alias gbl="git blame --date=short"
alias gc="git commit"
alias gca="git commit --amend"
alias gch="git checkout"
alias gchp="git cherry-pick"
alias gd="git diff --patience"
alias gdc="git diff --cached"
alias gds="git diff --stat"
alias gf="git fetch"
alias gl="git log --graph --pretty=format:'$commit_format' --date=$date_format"
alias gll="git log"
alias gm="git merge"
alias gp="git push"
alias gpt="git push --tags"
alias gr="git reset"
alias grh="git reset --hard"
alias grs="git reset --soft"
alias gs="git status --short"
alias gsb="git status --short --branch"
alias gsh="git show --stat --pretty=format:'$commit_format' --date=$date_format"
alias gst="git stash"
alias gt="git tag"
