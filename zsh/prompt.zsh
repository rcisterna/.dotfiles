#!/bin/zsh
setopt prompt_subst

local dot_start='━╾'
local dot_ts='╼┥'
local dot_end='┝╸'
local sep='─'
local user=""
local host="%f"
local current='%F{cyan}%n%f at %F{magenta}%m%f in %F{blue}%0~%f '
local insert='%F{yellow}❯❯ %f'
local nl=$'\n'

function __prompt()
{
    local dynamic_dots
    local datetime
    local branch
    local dirty
    local git_rev
    local ahead
    local behind

    datetime=" %D{%d-%m-%G} "
    let dots_count=${COLUMNS}-18 # dot_start(2) + dot_ts(2) + datetime(12) + dot_end(2)
    while [[ $dots_count -gt 0 ]]; do
        dynamic_dots="${dynamic_dots}$sep"
        let dots_count=${dots_count}-1
    done
    dynamic_dots="${dynamic_dots}"

    # Look for Git status
    if git status &>/dev/null; then
        branch="on %F{white}$(git branch --color=never | sed -ne 's/* //p')%f"
        git_rev="$(git rev-list --left-right @...@{u})"

        if git status -uno -s | grep -q . ; then
            dirty=" %F{white}●%f"
        fi

        behind="$(echo $git_rev | tr -d -c '>' | awk '{print length;}')"
        if [[ ! -z "${behind// }" ]]; then
            behind=" %F{red}↓$behind%f"
        fi

        ahead="$(echo $git_rev | tr -d -c '<' | awk '{print length;}')"
        if [[ ! -z "${ahead// }" ]]; then
            ahead=" %F{green}↑$ahead%f"
        fi

    fi

    PROMPT="$dot_start$dynamic_dots$dot_ts$datetime$dot_end$nl$current$branch$dirty$behind$ahead$nl$insert"
}
PROMPT2="%F{yellow}◀ %f"

precmd () { __prompt }
