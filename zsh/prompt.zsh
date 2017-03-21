#!/bin/zsh
setopt prompt_subst

local dots='%F{white}........................................................................ %f'
local current_dir='%F{white}at %F{blue}%0~%f '
local insert='%F{yellow}❯❯ %f'
local nl=$'\n'

function __prompt()
{
    local branch
    local short_hash

    # Look for Git status
    if git status &>/dev/null; then
        branch="%F{white}on $(git branch --color=never | sed -ne 's/* //p')%f"
        if git status -uno -s | grep -q . ; then
            branch="$branch%F{white}*%f"
        fi
        short_hash="%F{gray}$(git log -1 --format='%h')%f"
    fi

    PROMPT="$dots$short_hash$nl$current_dir$branch$nl$insert"
}
PROMPT2="%F{yellow}◀ %f"

precmd () { __prompt }
