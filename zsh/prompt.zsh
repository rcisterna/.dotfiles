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

local dot_start='━╾'
local dot_ts='╼┥'
local dot_end='┝╾'
local sep='╌'
local current='%F{cyan}%n%f at %F{magenta}%m%f in %F{blue}%0~%f '
# local insert='%F{yellow}❯❯ %f'
local nl=$'\n'

function __prompt()
{
    local branch
    local dirty
    local git_rev
    local ahead
    local behind

    local current_env=''
    if (( ${+VIRTUAL_ENV} )); then
        current_env='%F{red}$(basename $VIRTUAL_ENV)%f '
    fi

    # Look for Git status
    if git status &>/dev/null; then
        branch="on %F{white}$(git branch --color=never | sed -ne 's/* //p')%f"
        git_rev="$(git rev-list --left-right @...@{u})"

        if git status -uno -s | grep -q . ; then
            dirty=" %F{white}●%f"
        fi

        behind="$(echo $git_rev | tr -d -c '>' | awk '{print length;}')"
        if [[ ! -z "${behind// }" ]]; then
            behind=" %F{red}⇣$behind%f"
        fi

        ahead="$(echo $git_rev | tr -d -c '<' | awk '{print length;}')"
        if [[ ! -z "${ahead// }" ]]; then
            ahead=" %F{green}⇡$ahead%f"
        fi

    fi
    
	local insert='%b>%F{yellow}>%B%(?.%{$fg[yellow]%}.%{$fg[red]%})>%f%b '
    PROMPT="$nl$current$branch$dirty$behind$ahead$nl$current_env$insert"
}
precmd () { __prompt }

RPROMPT='%{$fg[red]%} %(?..error: %?)%f'
PROMPT2="%B%F{yellow}$PROMPT2%b%f"
SPROMPT="%F{yellow}%F{grey}>>%B%F{red}>%b%f %f Correct %F{red}%R%f to %F{green}%r%f [nyae]? "

# Use autosuggestion
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
fi

