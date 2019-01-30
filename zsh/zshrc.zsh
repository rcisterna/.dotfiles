# Historial
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.zsh_history"
WORDCHARS=${WORDCHARS//\/[&.;]}

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

# Opciones
setopt banghist  # Treat the '!' character specially during expansion.
# setopt EXTENDED_HISTORY  # Write the history file in the ":start:elapsed;command" format.
# setopt INC_APPEND_HISTORY  # Write to the history file immediately, not when the shell exits.
setopt sharehistory  # Share history between all sessions.
setopt histexpiredupsfirst  # Expire duplicate entries first when trimming history.
setopt histignoredups  # Don't record an entry that was just recorded again.
setopt histignorealldups  # Delete old recorded entry if new entry is a duplicate.
setopt histfindnodups  # Do not display a line previously found.
setopt histignorespace  # Don't record an entry starting with a space.
setopt histsavenodups  # Don't write duplicate entries in the history file.
setopt histreduceblanks  # Remove superfluous blanks before recording entry.
setopt histverify  # Don't execute immediately upon history expansion.
setopt histbeep  # Beep when accessing nonexistent history.
setopt autocd  # Allow directory change without using cd command
setopt correct  # Corrects commmands misspellings
setopt extendedglob  # Extended globbing. Allows using regular expressions with *
setopt nocaseglob  # Case insensitive globbing
setopt rcexpandparam  # Array expension with parameters
setopt numericglobsort  # Sort filenames numerically when it makes sense
setopt appendhistory  # Immediately append history instead of overwriting


# Setear el titulo de una pestaña
DISABLE_AUTO_TITLE="true"
tt () {
    echo -ne "\e]1;$@\a"
}

# Cargar autocompletado
fpath=(/usr/local/share/zsh-completions $fpath)
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
# zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Acelerar autocompletado
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache


# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

# Carga los colores automaticamente
autoload -U compinit colors zcalc
compinit -d
colors

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

# Rust src
# export RUST_SRC_PATH=~/.config/nvim/plugged/rust/src

# VMware Fusion
if [ -d "/Applications/VMware Fusion.app/Contents/Library" ]; then
    export PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library"
fi

# Prompt
if [ -f ~/.dotfiles/zsh/prompt.zsh ]; then
    source ~/.dotfiles/zsh/prompt.zsh
fi

# Alias git
if [ -f ~/.dotfiles/zsh/git.zsh ]; then
    source ~/.dotfiles/zsh/git.zsh
fi

# Archivo de alias local
if [[ $OSTYPE == darwin* ]] && [ -f ~/.dotfiles/zsh/mac_aliases.zsh ]; then
    source ~/.dotfiles/zsh/mac_aliases.zsh
elif [ -f ~/.dotfiles/zsh/aliases.zsh ]; then
    source ~/.dotfiles/zsh/aliases.zsh
fi

# pyenv init
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

if hash brew 2>/dev/null; then
    export PATH=/usr/local/bin:$PATH
fi

if [ -d ~/.local/bin/ ]; then
    export PATH=~/.local/bin:$PATH
fi

# pyenv
if [ -d ~/.pyenv/ ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
    fi
fi

# poetry
if [ -d ~/.pyenv/ ]; then
    fpath+=~/.zfunc
    export PATH="$HOME/.poetry/bin:$PATH"
fi

# Gitignore.io
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

