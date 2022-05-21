# Install Command Line Tools
xcode-select --install

# Get homebrew installation directory
if [[ $(uname -p) == "arm" ]]; then
    HOMEBREW_DIR="/opt/homebrew/bin/brew"
else
    HOMEBREW_DIR="/usr/local/bin/brew"
fi

# Install homebrew
if ! command -v ${HOMEBREW_DIR} &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install homebrew packages
$HOMEBREW_DIR bundle --file ~/.dotfiles/Brewfile

# Create simlinks
if ! test -f ~/.zshrc; then
    ln -s ~/.dotfiles/zsh/zshrc.zsh ~/.zshrc
fi

if ! test -f ~/.gitconfig; then
    ln -s ~/.dotfiles/gitconfig ~/.gitconfig
fi

if ! test -f ~/.gitignore; then
    ln -s ~/.dotfiles/gitignore_global ~/.gitignore
fi

# Create hidden local bin directory
if ! test -d ~/bin; then
    mkdir ~/bin
    chflags hidden ~/bin
fi

# Create neovim config
NVIM_INIT_FILE="${HOME}/.config/nvim/init.vim"
if ! test -f $NVIM_INIT_FILE; then
    mkdir -p ~/.config/nvim
    touch $NVIM_INIT_FILE
    echo "source $HOME/.dotfiles/vim/settings.vim" >> $NVIM_INIT_FILE
    echo "source $HOME/.dotfiles/vim/plugins.vim" >> $NVIM_INIT_FILE
    echo "source $HOME/.dotfiles/vim/mappings.vim" >> $NVIM_INIT_FILE
    echo "source $HOME/.dotfiles/vim/autocmd.vim" >> $NVIM_INIT_FILE
fi

