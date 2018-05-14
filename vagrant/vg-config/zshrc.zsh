export PATH=/usr/local/bin:$PATH
export LANG=es_CL.UTF-8
export LC_ALL=es_CL.UTF-8

# Carga los colores automaticamente
autoload -U colors compinit
colors
compinit

# Historial
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.zsh_history"

# Opciones
setopt BANG_HIST # Treat the '!' character specially during expansion.
# setopt EXTENDED_HISTORY # Write the history file in the ":start:elapsed;command" format.
# setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS # Do not display a line previously found.
setopt HIST_IGNORE_SPACE # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY # Don't execute immediately upon history expansion.
setopt HIST_BEEP # Beep when accessing nonexistent history.<Paste>
setopt AUTO_CD # Allow directory change without using cd command
setopt CORRECT # Corrects commmands misspellings

# Cargar autocompletado
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
# zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Editor por defecto nvim (o vim, o vi)
if hash nvim 2>/dev/null; then
    export VISUAL=nvim
    export EDITOR=nvim
elif hash vim 2>/dev/null; then
    export VISUAL=vim
    export EDITOR=vim
else
    export VISUAL=vi
    export EDITOR=vi
fi

# Useful aliases
alias grep="grep --color"
alias ls="ls --color=auto --si --group-directories-first"

# Git aliases
local commit_format="%C(auto)%h %C(cyan)%ad %C(auto)(%an) %s"
local date_format="iso"
alias g="git"
alias ga="g add"
alias gb="g branch"
alias gba="g branch -a"
alias gbl="g blame --date=short"
alias gc="g commit"
alias gca="g commit --amend"
alias gch="g checkout"
alias gchp="g cherry-pick"
alias gd="g diff --patience"
alias gdc="g diff --cached"
alias gds="g diff --stat"
alias gf="g fetch"
alias gl="g log --graph --pretty=format:'$commit_format' --date=$date_format"
alias gll="g log"
alias gm="g merge"
alias gp="g push"
alias gpt="g push --tags"
alias gpull="g pull"
alias gr="g reset"
alias grm="g rm"
alias grh="g reset --hard"
alias grs="g reset --soft"
alias gs="g status --short"
alias gsb="g status --short --branch"
alias gsh="g show --stat --pretty=format:'$commit_format' --date=$date_format"
alias gst="g stash"
alias gt="g tag"

# Prompt
setopt prompt_subst

local dot_start='——'
local dot_ts='—|'
local dot_end='|—'
local sep='—'
local current='%F{cyan}%n%f at %F{magenta}%m%f in %F{blue}%0~%f '
local insert='%F{yellow}» %f'
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
    while [[ $dots_count -gt 1 ]]; do
        dynamic_dots="${dynamic_dots}$sep"
        let dots_count=${dots_count}-1
    done
    dynamic_dots="${dynamic_dots}"

    # Look for Git status
    if git status &>/dev/null; then
        branch="on %F{white}$(git branch --color=never | sed -ne 's/* //p')%f"
        git_rev="$(git rev-list --left-right @...@{u})"

        if git status -uno -s | grep -q . ; then
            dirty=" %F{white}×%f"
        fi

        behind="$(echo $git_rev | tr -d -c '>' | awk '{print length;}')"
        if [[ ! -z "${behind// }" ]]; then
            behind=" %F{red}-$behind%f"
        fi

        ahead="$(echo $git_rev | tr -d -c '<' | awk '{print length;}')"
        if [[ ! -z "${ahead// }" ]]; then
            ahead=" %F{green}+$ahead%f"
        fi

    fi

    PROMPT="$dot_start$dynamic_dots$dot_ts$datetime$dot_end$nl$current$branch$dirty$behind$ahead$nl$insert"
}
PROMPT2="%F{yellow}‹ %f"
SPROMPT="%F{yellow}‹ %f Correct %F{red}%R%f to %F{green}%r%f [nyae]? "

precmd () { __prompt }
