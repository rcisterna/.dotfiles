#!/bin/zsh
setopt prompt_subst

# Use syntax highlighting
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Use history substring search
if [ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
    source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

## bind UP and DOWN arrow keys to history substring search
# zmodload zsh/terminfo
# bindkey "$terminfo[kcuu1]" history-substring-search-up
# bindkey "$terminfo[kcud1]" history-substring-search-down
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

# local dot_start='━╾'
# local dot_ts='╼┥'
# local dot_end='┝╾'
# local sep='╌'
local current="%B%F{cyan}%n%b%f at %B%F{magenta}%m%b%f in %B%F{blue}%0~%b%f"
# local insert='%F{yellow}❯❯ %f'
local nl=$'\n'
local insert="%b>%F{yellow}>%B%(?.%F{yellow}.%F{red})>%f%b"
local venv

function __prompt()
{
    local branch
    local remote
    local dirty
    local git_rev
    local ahead
    local behind
    local poetry_path=$(poetry config settings.virtualenvs.path 2> /dev/null)
    poetry_path=${poetry_path//\"}

    # Look for virtualenv
    if [ ! -z ${VIRTUAL_ENV} ]; then
        venv="%B%F{yellow}("
        if [[ "${poetry_path}" == "$(dirname ${VIRTUAL_ENV})"* ]]; then
            venv="${venv}poetry:$(basename ${VIRTUAL_ENV})"
        elif [[ "${PWD}" == "$(dirname ${VIRTUAL_ENV})"* || "$(dirname ${VIRTUAL_ENV})" == "${PWD}"* ]]; then
            venv="${venv}$(realpath --relative-to=${PWD} ${VIRTUAL_ENV})"
        else
            venv="${venv}${VIRTUAL_ENV}"
        fi
        venv="${venv})%f%b "
    else
        venv=""
    fi

    # Look for Git status
    if git status &>/dev/null; then
        branch="$(git rev-parse --abbrev-ref --symbolic-full-name @ 2> /dev/null)"
        if [ $? -ne 0 ]; then branch="[missing]"; fi
        remote="$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null)"
        if [ $? -eq 0 ]; then remote=" (${remote})"; else remote="" fi
        branch=" on %F{white}${branch}${remote}%f"

        if [ -n "$(git status --porcelain 2> /dev/null)" ]; then
            dirty=" %F{white}●%f"
        fi

        git_rev="$(git rev-list --left-right @...@{u} 2>/dev/null)"
        if [ $? -eq 0 ]; then
            behind="$(echo $git_rev | tr -d -c '>' | awk '{print length;}')"
            if [[ ! -z "${behind// }" ]]; then
                behind=" %F{red}⇣${behind}%f"
            fi

            ahead="$(echo $git_rev | tr -d -c '<' | awk '{print length;}')"
            if [[ ! -z "${ahead// }" ]]; then
                ahead=" %F{green}⇡${ahead}%f"
            fi
        fi

    fi

    PS1="${nl}${current}${branch}${dirty}${behind}${ahead}${nl}${venv}${insert} "
    SPROMPT="${insert} Correct %B%F{red}%R%b%f to %B%F{green}%r%b%f [nyae]? "
}
precmd () { __prompt }

RPS1='%B%F{red} %(?..E:%?)%b%f'
PS2="${venv}%B%F{yellow}[%_]%f%b ${insert} "
PS3="${venv}%B%F{yellow}?#%f%b ${insert} "
PS4="${venv}%B%F{yellow}+%f%b ${insert} "

# Use autosuggestion
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
fi

