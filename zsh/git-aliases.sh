# git aliases
alias ga='git add'
alias gap='git add --patch'
alias gau='git add --update'

function gct() {
  local curr_branch=$(git symbolic-ref --short HEAD)
  git commit -m "$curr_branch $1"
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

function create_worktree_from_jira() {

  local jira=""
  local branch=""

  # Parse arguments
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -j|--jira)
        jira="$2"
        shift 2
        ;;
      -b|--branch-name)
        branch="$2"
        shift 2
        ;;
      *)
        echo "Unknown option: $1"
        return 1
        ;;
    esac
  done

  # Validate inputs
  if [[ -z "$jira" || -z "$branch" ]]; then
    echo "Usage: create_worktree -j <JIRA-ID> -b <branch-name>"
    return 1
  fi

  local jira_id=$(extract_jira_id $jira)
  local final_branch_name="lma-"$jira_id"-"$branch

  # Get the repo name from the current directory
  local repo_name=$(basename "$(git rev-parse --show-toplevel)")
  worktree_dir="~/ttdsrc/${repo_name}-worktrees/${final_branch_name}"

  echo "Creating branch "$final_branch_name" in "$worktree_dir  
  # Create the worktree
  git worktree add $worktree_dir
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