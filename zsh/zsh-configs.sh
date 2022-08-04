zstyle ':completion:*:ssh:argument-1:'       tag-order  hosts users
zstyle ':completion:*:scp:argument-rest:'    tag-order  hosts files users
zstyle ':completion:*:(ssh|scp|rdp):*:hosts' hosts

export FZF_DEFAULT_OPTS="--bind 'ctrl-y:execute-silent(echo {} | pbcopy)+accept'"