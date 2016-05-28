export PATH="/usr/local/bin:$PATH"

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

# Bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
	. `brew --prefix`/etc/bash_completion
fi

# VMware Fusion
if [ -d "/Applications/VMware Fusion.app/Contents/Library" ]; then
	export PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library"
fi

# Git prompt
if [ -f ~/.dotfiles/bash/prompt.sh ]; then
	. ~/.dotfiles/bash/prompt.sh
fi

# Archivo de alias local
if [[ $OSTYPE == darwin* ]] && [ -f ~/.dotfiles/bash/mac_aliases.sh ]; then
	. ~/.dotfiles/bash/mac_aliases.sh
elif [ -f ~/.dotfiles/bash/aliases.sh ]; then
	. ~/.dotfiles/bash/aliases.sh
fi

# Gruvbox correccion de colores
if [ -f ~/.config/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh ]; then
	. ~/.config/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh
elif [ -f ~/.vimrc/plugged/gruvbox/gruvbox_256palette_osx.sh ]; then
    . ~/.vimrc/plugged/gruvbox/gruvbox_256palette_osx.sh
fi

