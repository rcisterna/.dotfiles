alias ls="ls -GFh"
alias grep="grep --color=auto"

function brew_listdeps()
{
    if brew list > /dev/null; then
        brew list | while read cask; do
            echo -ne "\x1B[1;34m$cask \x1B[0m"
            brew deps $cask --include-optional --installed | awk '{printf(" %s", $0)}'
            echo ""
        done
    fi
}
