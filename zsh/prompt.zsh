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

function __prompt()
{
    local branch
    local remote
    local dirty
    local git_rev
    local ahead
    local behind

    local current_env=""
    if (( ${+VIRTUAL_ENV} )); then
        current_env=" %B%F{white}($(basename $VIRTUAL_ENV))%f%b"
    fi

    # Look for Git status
    if git status &>/dev/null; then
        branch="$(git rev-parse --abbrev-ref --symbolic-full-name @ 2> /dev/null)"
        if [ $? -ne 0 ]; then branch="[missing]"; fi
        remote="$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null)"
        if [ $? -eq 0 ]; then remote=" (${remote})"; fi
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

    local insert="%b>%F{yellow}>%B%(?.%F{yellow}.%F{red})>%f%b${current_env}"
    PROMPT="${nl}${current}${branch}${dirty}${behind}${ahead}${nl}${insert} "
    SPROMPT="${insert} Correct %B%F{red}%R%b%f to %B%F{green}%r%b%f [nyae]? "
}
precmd () { __prompt }

RPROMPT='%B%F{red} %(?..E:%?)%b%f'
PROMPT2="%B%F{yellow}$PROMPT2%b%f"

# Use autosuggestion
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
fi

