export PATH=/usr/local/bin:$PATH
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

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


# Setear el titulo de una pestaña
DISABLE_AUTO_TITLE="true"
tt () {
    echo -ne "\e]1;$@\a"
}

# Cargar autocompletado
fpath=(/usr/local/share/zsh-completions $fpath)
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

# Archivo de alias local
if [[ $OSTYPE == darwin* ]] && [ -f ~/.dotfiles/zsh/mac_aliases.zsh ]; then
	source ~/.dotfiles/zsh/mac_aliases.zsh
elif [ -f ~/.dotfiles/zsh/aliases.zsh ]; then
	source ~/.dotfiles/zsh/aliases.zsh
fi

# Homebrew Python[3] binaries links to python, pip, etc. 
if [ -d "/usr/local/opt/python/libexec/bin" ]; then
	export PATH="/usr/local/opt/python/libexec/bin":$PATH
fi

# Gruvbox correccion de colores
# if [ -f ~/.config/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh ]; then
# 	. ~/.config/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh
# elif [ -f ~/.vimrc/plugged/gruvbox/gruvbox_256palette_osx.sh ]; then
#     . ~/.vimrc/plugged/gruvbox/gruvbox_256palette_osx.sh
# fi

# Gitignore.io
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
