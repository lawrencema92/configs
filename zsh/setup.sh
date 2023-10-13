# plugins
brew install zoxide
export _ZO_DATA_DIR=$HOME/Library/Application
export _ZO_ECHO=1
zoxide init zsh --cmd z --hook pwd
# put this in zshrc eval "$(zoxide init zsh)" as well as the exports

# install zsh4humans
if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi

# disable app store notifications
defaults write com.apple.appstored LastUpdateNotification -date "3029-12-12 12:00:00 +0000"