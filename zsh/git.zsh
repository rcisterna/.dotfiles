# Git aliases
local commit_format="%C(auto)%h %C(cyan)%ad %C(green)%ae %C(auto)%s%d"
local date_format="format:%d-%m\ %H:%M"

alias g="git --no-pager"
alias g="git"
alias gclone="g clone"
alias ga="g add"
alias gclean="g clean -fdx"
alias gb="g branch"
alias gbl="g blame --date=short"
alias gc="g commit"
alias gca="g commit --amend --no-edit"
alias gcheck="g checkout"
alias gcherry="g cherry --abbrev --verbose"
alias gchpick="g cherry-pick"
alias gd="g diff --patience --unified=10"
alias gf="g fetch --all --prune"
alias gl="g log --graph --pretty=format:'$commit_format' --date=$date_format"
alias glb="g log --graph --pretty=format:'$commit_format' --date=relative"
alias gm="g merge"
alias gmr="g merge --rebase"
alias gpush="g push"
alias gpull="g pull --rebase --autostash"
alias gr="g reset"
alias grm="g rm"
alias gs="g status --short --branch"
alias gsh="g show --unified=10 --pretty=format:'$commit_format' --date=$date_format"
alias gst="g stash --include-untracked"
alias gt="g tag"
alias grb="g rebase"
alias grbi="g rebase --interactive --autostash"
alias grem="g remote --verbose"
# alias gg="for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done"

function gbclean {
    for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done
}

