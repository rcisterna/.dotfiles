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

if [ -f `brew --prefix`/etc/bash_completion ]; then
	. `brew --prefix`/etc/bash_completion
fi

# VMware Fusion
if [ -d "/Applications/VMware Fusion.app/Contents/Library" ]; then
	export PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library"
fi

# Git prompt
if [ -f ~/.bash_prompt ]; then
	. ~/.bash_prompt
fi

# Archivo de alias local
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Gruvbox
# if [ -f ~/.config/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh ]; then
# 	. ~/.config/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh
# fi

