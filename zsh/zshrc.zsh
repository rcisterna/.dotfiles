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
bindkey '^[[F' end-of-line                                      # End key
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

# Options
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
#setopt extendedglob  # Extended globbing. Allows using regular expressions with *
setopt nocaseglob  # Case insensitive globbing
setopt rcexpandparam  # Array expension with parameters
setopt numericglobsort  # Sort filenames numerically when it makes sense
setopt appendhistory  # Immediately append history instead of overwriting


# Autoset tab title
DISABLE_AUTO_TITLE="true"
tt () {
    echo -ne "\e]1;$@\a"
}

# Enable autocomplete
fpath+=/usr/local/share/zsh-completions
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
# zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Speed up autocompletion
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache


# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

# Poetry autocompletion (must be prior to compinit)
if [ -d ~/.poetry/bin/ ]; then
    fpath+=~/.zfunc
    export PATH="$HOME/.poetry/bin:$PATH"
fi

# Autoload
autoload -U compinit colors zcalc promptinit

# Load colors
compinit -id
colors

# Load spaceship prompt
promptinit
prompt spaceship
export SPACESHIP_TIME_SHOW=true
export SPACESHIP_TIME_FORMAT=%D{%a\ %d-%m\ %H:%M}

# Default editor to nvim (or vim, or vi)
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

# Prompt
# if [ -f ~/.dotfiles/zsh/prompt.zsh ]; then
#     source ~/.dotfiles/zsh/prompt.zsh
# fi

# Load git aliases
if [ -f ~/.dotfiles/zsh/git.zsh ]; then
    source ~/.dotfiles/zsh/git.zsh
fi

# Load local aliases file
if [[ $OSTYPE == darwin* ]] && [ -f ~/.dotfiles/zsh/mac_aliases.zsh ]; then
    source ~/.dotfiles/zsh/mac_aliases.zsh
elif [ -f ~/.dotfiles/zsh/aliases.zsh ]; then
    source ~/.dotfiles/zsh/aliases.zsh
fi

# Homebrew
if hash brew 2>/dev/null; then
    export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
    export HOMEBREW_GITHUB_API_TOKEN=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

    # for pyenv
    export LDFLAGS="-L$(xcrun --show-sdk-path)/usr/lib -L$(brew --prefix zlib)/lib -L$(brew --prefix bzip2)/lib"
    export CPPFLAGS="-L$(xcrun --show-sdk-path)/usr/include -I$(brew --prefix zlib)/include -I$(brew --prefix bzip2)/include"

fi

# Load homebrew's java
if [ -d /usr/local/opt/openjdk/bin/ ]; then
    export PATH="/usr/local/opt/openjdk/bin:$PATH"
fi

# Add executable paths
if [ -d ~/.local/bin/ ]; then
    export PATH=~/.local/bin:$PATH
fi

if [ -d ~/bin/ ]; then
    export PATH="$HOME/bin:$PATH"
fi

# Load pyenv
if [ -d ~/.pyenv/ ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    # if command -v pyenv 1>/dev/null 2>&1; then
    #     eval "$(pyenv init -)"
    # fi
fi

# Heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/rcisterna/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# Gitignore.io
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# Function to get Bundle ID
function bundleid {
    readonly app=${1:?"Especifique ruta a aplicación."}
    # lsappinfo info -only bundleid $app
    # mdls -name kMDItemCFBundleIdentifier -r $app
    defaults read $app/Contents/Info.plist CFBundleIdentifier
}

# Utilities
function priorset {
    readonly app=${1:?"Especifique aplicación."}
    sudo renice -20 $(ps -A | grep "$app"$ | awk '{print $1}')
}

function priorget {
    readonly app=${1:?"Especifique aplicación."}
    ps -Al | grep "$app"$ | awk '{print $7}'
}

function clearport {
    readonly port=${1:?"Especifique puerto."}
    readonly pid=$(sudo lsof -i :$port | awk 'NR==2 {print $2}')
    sudo kill -9 $pid
}

function checkport {
    readonly port=${1:?"Especifique puerto."}
    sudo lsof -i :$port
}

# GPG ioctl error fix
if hash gpg 2>/dev/null; then
    export GPG_TTY=$(tty)
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/rcisterna/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/rcisterna/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/rcisterna/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/rcisterna/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# NVM (node version manager)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# ZSH Autosuggestions
if [ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# ZSH Syntax Highlighting
if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
