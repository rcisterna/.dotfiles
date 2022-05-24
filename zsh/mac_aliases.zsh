# Aliases generales
alias ls="ls -GFh"
alias tree="tree --dirsfirst -hpCL 2"
alias grep="grep --color=auto"
alias marked="open -a 'Marked 2'"
alias cat="bat"
alias brew_installed="brew leaves | xargs brew deps --installed --for-each | sed 's/^.*:/$(tput setaf 4)&$(tput sgr0)/'"

if command -v nvim 1>/dev/null 2>&1; then
    alias vi="nvim"
    alias vim="nvim"
fi

if command -v docker-compose 1>/dev/null 2>&1; then
    alias dcomp="docker-compose"
fi

# isort alias & functions
if hash isort 2>/dev/null; then
    alias isort_mod="git diff --name-only | grep .py | xargs isort"
    alias isort_stg="git diff --staged --name-only | grep .py | xargs isort"
    function isort_cmt()
    {
        if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
            local current_b="$(git rev-parse --abbrev-ref HEAD)"
            local base_b
            if [ "$1" != "" ]
            then
                base_b="$1"
            else
                base_b="master"
            fi
            git diff --name-only $current_b $(git merge-base $current_b $base_b) | grep .py | xargs isort
        fi
    }
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
