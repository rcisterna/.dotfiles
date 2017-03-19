#!/bin/zsh
setopt prompt_subst

local dots='.................................................................................................... '
local current_dir='%F{white}at%f %F{blue}%0~%f '
local insert='%F{yellow}❯❯ %f'
local nl=$'\n'

function __prompt()
{
    local dirty
    local branch
    local branch_status
    local short_hash

    # Look for Git status
    if git status &>/dev/null; then
        if git status -uno -s | grep -q . ; then
            dirty=1
        fi
        branch='%F{white}on $(git branch --color=never | sed -ne "s/* //p")%f '
        short_hash=$(git log -1 --format='%h')
    fi

    if [[ ! -z "$branch" ]]; then
        if [[ -z "$dirty" ]] ; then
            branch_status='%F{white}(%F{green}*%F{white})%f'
        else
            branch_status='%F{white}(%F{red}*%F{white})%f'
        fi
    fi
    PROMPT="$dots$short_hash$nl$current_dir$branch$branch_status$nl$insert"
}
PROMPT2="%F{yellow}◀ %f"

precmd () { __prompt }
