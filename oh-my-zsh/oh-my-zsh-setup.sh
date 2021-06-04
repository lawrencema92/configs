# oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# plugins
git clone https://github.com/zdharma/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

brew install zoxide
export_ZO_DATA_DIR=$HOME/Library/Application
export_ZO_ECHO=1
zoxide init zsh --cmd z --hook pwd
# put this in zshrc eval "$(zoxide init zsh)"


# powerlevel10k, restart terminal afterwards
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k