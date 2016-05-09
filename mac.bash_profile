export PATH="/usr/local/bin:$PATH"

if [ -f `brew --prefix`/etc/bash_completion ]; then
	. `brew --prefix`/etc/bash_completion
fi

# VMware Fusion
if [ -d "/Applications/VMware Fusion.app/Contents/Library" ]; then
	export PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library"
fi

# Git prompt
if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
	GIT_PROMPT_THEME=Default_NoExitState
	source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
fi

# Archivo de alias local
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

