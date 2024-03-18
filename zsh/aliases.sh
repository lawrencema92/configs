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

function convertEpoch() {
  local epoch_timestamp=$1
  if [ $(echo -n $epoch_timestamp | wc -m) -gt 12 ]
  then
    epoch_timestamp=${epoch_timestamp%???}
  fi

  echo $1
  date -r $epoch_timestamp '+%m/%d/%Y:%H:%M:%S%Z'
}

function s3ls() {
  if [[ $1 == s3://* ]]
  then
    local key=$(echo $1 | sed 's/s3:\/\///')
  elif [[ $1 == s3a://* ]]
  then
    local key=$(echo $1 | sed 's/s3a:\/\///')
  else
    local key=$1
  fi

  aws s3 ls --human-readable $key
}

function s3stream() {
  if [[ $1 == s3://* ]]
  then
    local key=$1
  elif [[ $1 == s3a://* ]]
  then
    local key=$(echo $1 | sed 's/s3a:\/\//s3:\/\//')
  else
    local key=s3://$1
  fi

  aws s3 cp $key -
}

function s3dl() {
  if [[ $1 == s3://* ]]
  then
    local key=$1
  elif [[ $1 == s3a://* ]]
  then
    local key=$(echo $1 | sed 's/s3a:\/\//s3:\/\//')
  else
    local key=s3://$1
  fi

  if [[ $2 == s3* ]]
  then
    echo "danger danger"
    return 1
  fi

  if [ -z $2 ]
  then
    local dest=./
  else
    local dest=$2
  fi

  aws s3 cp $key $dest
}

function tf() {
  if [ $1 = 'start' ]; then
    tfenv use 1.5.3
    terraform init
  else
    terraform $@
  fi
}

function getCustomer() {
  ~/dev/tools/get_customer $@
}

function generateSuperAppConfigs() {
  ~/aiq/aiq local-ansible $@ | tee /dev/tty | grep -i 'export aiq_config_path' | source /dev/stdin
}

function getTriggerStacks() {
  local env="prod"
  for i in "$@"; do
    case $i in 
      -e|--env)
        shift
        env=$1
        shift
        ;;
      *)
        ;;
    esac
  done

  ~/aiq/aiq stack v2 list $env --app-name trigger-execution | sort
}


function getTriggerHosts() {
  local env="prod"
  local stack=$(~/aiq/aiq stack v2 list $env --app-name trigger-execution | sort | sed '/instances found/d' | sed '1!d')
  local customersOnly=false

  for i in "$@"; do
    case $i in 
      -e|--env)
        shift
        env=$1
        shift
        ;;
      -s|--stack)
        shift
        stack=$1
        shift
        ;;
      -c|--customers-only)
        customersOnly=true
        shift
        ;;
      *)
        ;;
    esac
  done

  if [[ $customersOnly ]] 
  then
    ~/aiq/aiq stack v2 list-hosts $env $stack trigger-execution | sort | awk -F. '{ print $2 }'
  else
    ~/aiq/aiq stack v2 list-hosts $env $stack trigger-execution | sort
  fi
}

function jira-create() {
  jira issue create -p $1 -s $2 -tTask --no-input | grep 'https://' | tr -d '\n' | tee >(pbcopy) 
}

alias parquet-dump='java -jar ~/dev/parquet-dump/target/scala-2.11/Parquet-Dump-assembly-1.1.1.jar'