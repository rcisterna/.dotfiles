#!/bin/bash

function __prompt()
{
    # List of color variables that bash can use
    local BLACK="\[\e[0;30m\]"   # Black
    local DGREY="\[\e[1;30m\]"   # Dark Gray
    local RED="\[\e[0;31m\]"     # Red
    local LRED="\[\e[1;31m\]"    # Light Red
    local GREEN="\[\e[0;32m\]"   # Green
    local LGREEN="\[\e[1;32m\]"  # Light Green
    local BROWN="\[\e[0;33m\]"   # Brown
    local YELLOW="\[\e[1;33m\]"  # Yellow
    local BLUE="\[\e[0;34m\]"    # Blue
    local LBLUE="\[\e[1;34m\]"   # Light Blue
    local PURPLE="\[\e[0;35m\]"  # Purple
    local LPURPLE="\[\e[1;35m\]" # Light Purple
    local CYAN="\[\e[0;36m\]"    # Cyan
    local LCYAN="\[\e[1;36m\]"   # Light Cyan
    local LGREY="\[\e[0;37m\]"   # Light Gray
    local WHITE="\[\e[1;37m\]"   # White

    local RESET="\[\e[0m\]"      # Color reset
    local BOLD="\[\e[;1m\]"      # Bold

    # Base prompt
    PS1="\u@\h:\W"

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
            status_color=$GREEN
        else
            status_color=$RED
        fi
        PS1="$PS1($status_color$branch$RESET)"
    fi
    PS1="$PS1\$ "
}

PROMPT_COMMAND='__prompt'
