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

# git aliases
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'

# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in main trunk; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo master
}

alias gb='git branch'
alias gcm='git checkout $(git_main_branch)'
alias gco='git checkout'
alias gd='git diff'

alias gpsup='git push --set-upstream origin $(git symbolic-ref --short HEAD)'

alias gl='git pull'

alias glog='git log --oneline --decorate --graph'

alias gp='git push'

alias gst='git status'