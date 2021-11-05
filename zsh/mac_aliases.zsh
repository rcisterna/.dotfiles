# Aliases generales
alias ls="ls -GFh"
alias tree="tree --dirsfirst -hpCL 2"
alias grep="grep --color=auto"
alias marked="open -a 'Marked 2'"
alias brew_installed="brew leaves | xargs brew deps --installed --for-each | sed 's/^.*:/$(tput setaf 4)&$(tput sgr0)/'"

if command -v nvim 1>/dev/null 2>&1; then
    alias vi="nvim"
    alias vim="nvim"
fi

if command -v docker-compose 1>/dev/null 2>&1; then
    alias dcomp="docker-compose"
fi

# Lista de dependencias para Homebrew
function brew_listdeps()
{
    if brew list > /dev/null; then
        brew list | while read cask; do
            echo -n $fg[blue]$cask $fg[white]
            brew deps $cask --include-build --include-optional --installed | awk '{printf(" %s", $0)}'
            echo ""
        done
    fi
}
