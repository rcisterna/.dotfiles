########## ZSH Configurations

# Historial
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.zsh_history"
WORDCHARS=${WORDCHARS//\/[&.;]}

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

# Enable autocomplete
fpath+=(/usr/local/share/zsh-completions)
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

########## PATH & FPATH Modifications

# Homebrew M1 directories
if [[ -d "/opt/homebrew/bin" ]]; then
    path+=(/opt/homebrew/bin)
fi

if [[ -d "/opt/homebrew/share/zsh/site-functions" ]]; then
    fpath+=(/opt/homebrew/share/zsh/site-functions)
fi

# Homebrew classis directories
if [[ -d "/usr/local/sbin" ]]; then
    path=("/usr/local/sbin" $path)

    # for pyenv
    # export LDFLAGS="-L$(xcrun --show-sdk-path)/usr/lib -L$(brew --prefix zlib)/lib -L$(brew --prefix bzip2)/lib"
    # export CPPFLAGS="-L$(xcrun --show-sdk-path)/usr/include -I$(brew --prefix zlib)/include -I$(brew --prefix bzip2)/include"
fi

if [[ -d "/usr/local/bin" ]]; then
    path=("/usr/local/bin" $path)
fi

# Load homebrew's java
if [[ -d "/usr/local/opt/openjdk/bin/" ]]; then
    path=("/usr/local/opt/openjdk/bin" $path)
fi

# Add executable paths
if [[ -d "$HOME/.local/bin/" ]]; then
    path+=("$HOME/.local/bin/")
fi

if [[ -d "$HOME/bin/" ]]; then
    path+=("$HOME/bin/")
fi

# Load pyenv
if [[ -d "$HOME/.pyenv" ]] && command -v pyenv &> /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    path=("$PYENV_ROOT/bin" $path)
    eval "$(pyenv init --path)"
fi

# Poetry autocompletion (must be prior to compinit)
if [[ -d "$HOME/.poetry/bin/" ]]; then
    fpath+=($HOME/.zfunc)
    path=("$HOME/.poetry/bin" $path)
fi

########## Autoload Configurations

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

########## Environment Variables Configurations
if command -v brew &> /dev/null; then
    export HOMEBREW_GITHUB_API_TOKEN=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
    export HOMEBREW_PREFIX="$(brew --prefix)"
fi

# Default editor to nvim (or vim, or vi)
if command -v nvim &> /dev/null; then
    export VISUAL=nvim
    export EDITOR=nvim
elif command vim &> /dev/null; then
    export VISUAL=vim
    export EDITOR=vim
else
    export VISUAL=vi
    export EDITOR=vi
fi

# Default pager to bat
if command -v bat &> /dev/null; then
    export PAGER=bat
fi

# GPG ioctl error fix
if command -v gpg &> /dev/null; then
    export GPG_TTY=$(tty)
fi

########## Load Other Configuration Files

# ZSH Autosuggestions
if [[ -f "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# ZSH Syntax Highlighting
if [[ -f "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Prompt
# if [[ -f "$HOME/.dotfiles/zsh/prompt.zsh" ]]; then
#     source $HOME/.dotfiles/zsh/prompt.zsh
# fi

# Load git aliases
if [[ -f "$HOME/.dotfiles/zsh/git.zsh" ]]; then
    source $HOME/.dotfiles/zsh/git.zsh
fi

# Load local aliases file
if [[ $OSTYPE == darwin* ]] && [[ -f "$HOME/.dotfiles/zsh/mac_aliases.zsh" ]]; then
    source $HOME/.dotfiles/zsh/mac_aliases.zsh
elif [[ -f "$HOME/.dotfiles/zsh/aliases.zsh" ]]; then
    source $HOME/.dotfiles/zsh/aliases.zsh
fi

########## Helper functions

# Set tab title
DISABLE_AUTO_TITLE="true"
tt () {
    readonly title=${1:?"Especifique título."}
    echo -ne "\e]1;$title\a"
}

# Gitignore.io
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# Function to get Bundle ID
function bundleid {
    readonly app=${1:?"Especifique ruta a aplicación."}
    defaults read $app/Contents/Info.plist CFBundleIdentifier
}

# Priority functions
function priorset {
    readonly app=${1:?"Especifique aplicación."}
    sudo renice -20 $(ps -A | grep "$app"$ | awk '{print $1}')
}

function priorget {
    readonly app=${1:?"Especifique aplicación."}
    ps -Al | grep "$app"$ | awk '{print $7}'
}

# Port functions
function clearport {
    readonly port=${1:?"Especifique puerto."}
    readonly pid=$(sudo lsof -i :$port | awk 'NR==2 {print $2}')
    sudo kill -9 $pid
}

function checkport {
    readonly port=${1:?"Especifique puerto."}
    sudo lsof -i :$port
}
