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
    ln -s ~/.dotfiles/vim/init.vim $NVIM_INIT_FILE
fi

# Symlink bat config
BAT_CONFIG_FILE="${HOME}/.config/bat/config"
if ! test -f $BAT_CONFIG_FILE; then
    mkdir -p ~/.config/bat
    ln -s ~/.dotfiles/bat.conf $BAT_CONFIG_FILE
fi

# Make Sublime Text the default text editor if it's not already
if ! defaults read com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers | grep -q "sublimetext"; then
    SUBL_APP_DIR="/Applications/Sublime Text.app"
    if test -d "${SUBL_APP_DIR}"; then
        SUBL_BUNDLE_ID=$(defaults read "${SUBL_APP_DIR}/Contents/Info.plist" CFBundleIdentifier)
        defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add "{LSHandlerContentType=public.plain-text;LSHandlerRoleAll=${SUBL_BUNDLE_ID};}"
    fi
fi

# Change default screenshots location
SCREENSHOTS_LOCATION="${HOME}/Pictures/Screenshots"
if ! test -d $SCREENSHOTS_LOCATION; then
    mkdir -p $SCREENSHOTS_LOCATION
fi
if test "$(defaults read com.apple.screencapture location)" != "${SCREENSHOTS_LOCATION}"; then
    defaults write com.apple.screencapture location $SCREENSHOTS_LOCATION
fi

# Auto fetch all repos
CODE_LOCATION="${HOME}/Code"
FETCH_ALL_CMD="find ${CODE_LOCATION} -type d -execdir test -d '{}/.git' \; -execdir git -C {} fetch --all --quiet \; -print -prune"
if ! test -d $CODE_LOCATION; then
    mkdir -p $CODE_LOCATION
fi
if ! crontab -l | grep "fetch --all"; then
    crontab -l && crontab -l > local.cron
    echo "*/5 * * * * ${FETCH_ALL_CMD}" >> local.cron
    crontab local.cron
    rm local.cron
fi
