#dnb specific
export AWS_REGION="eu-west-1"
alias gproxy='sudo -E ssh -o ConnectTimeout=60 -f -nNT gitproxy'
alias gproxy-off='sudo ssh -O exit gitproxy'
alias gproxy-status='sudo ssh -O check gitproxy'
