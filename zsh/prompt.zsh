#!/bin/bash
PROMPT="%n@%m:%~%# "

function __prompt()
{
    # Base prompt
    PROMPT="%n@%m:%~"

    local dirty
    local branch

    # Look for Git status
    if git status &>/dev/null; then
        if git status -uno -s | grep -q . ; then
            dirty=1
        fi
        branch=$(git branch --color=never | sed -ne 's/* //p')
    fi

    if [[ ! -z "$branch" ]]; then
        local status_color
        if [[ -z "$dirty" ]] ; then
            status_color=$fg[green]
        else
            status_color=$fg[red]
        fi
        PROMPT="$PROMPT($status_color$branch$reset_color)"
    fi
    PROMPT="$PROMPT%# "
}

#precmd () { __prompt }
