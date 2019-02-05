# Aliases generales
alias ls="ls --human-readable --group-directories-first --color=auto"
alias cp="cp --interactive"
alias df='df --human-readable'
alias free='free --mebi'
alias tree="tree --dirsfirst -hpCL 2"
alias grep="grep --color=auto"

if hash xdg-open 2>/dev/null; then
    alias open="xdg-open"
fi
