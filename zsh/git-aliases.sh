# git aliases
alias ga='git add'
alias gap='git add --patch'
alias gau='git add --update'

function gct() {
  git commit -m $1
}

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

alias ghd='git symbolic-ref --short HEAD'
alias gb='git branch'
alias gcm='git checkout $(git_main_branch)'
alias gco='git checkout'
alias gd='git diff'
alias gpsup='git push --set-upstream origin $(git symbolic-ref --short HEAD)'
alias gl='git pull'
alias glog='git log --oneline --decorate --graph'
alias gp='git push'
alias gst='git status'
alias gsha='git rev-parse HEAD'