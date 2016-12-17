export PATH=/usr/local/bin:$PATH

# Cargar autocompletado
fpath=(/usr/local/share/zsh-completions $fpath)
zstyle ':completion:*' special-dirs true

# Carga los colores automaticamente
autoload -U colors compinit
colors
compinit

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

# VMware Fusion
if [ -d "/Applications/VMware Fusion.app/Contents/Library" ]; then
	export PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library"
fi

# Git prompt
if [ -f ~/.dotfiles/zsh/prompt.zsh ]; then
	source ~/.dotfiles/zsh/prompt.zsh
fi

# Archivo de alias local
if [[ $OSTYPE == darwin* ]] && [ -f ~/.dotfiles/zsh/mac_aliases.zsh ]; then
	source ~/.dotfiles/zsh/mac_aliases.zsh
elif [ -f ~/.dotfiles/zsh/aliases.zsh ]; then
	source ~/.dotfiles/zsh/aliases.zsh
fi

# Gruvbox correccion de colores
# if [ -f ~/.config/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh ]; then
# 	. ~/.config/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh
# elif [ -f ~/.vimrc/plugged/gruvbox/gruvbox_256palette_osx.sh ]; then
#     . ~/.vimrc/plugged/gruvbox/gruvbox_256palette_osx.sh
# fi

