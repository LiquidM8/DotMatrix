# Aliases

#secrets
source $HOME/DotMatrix/.env/SECRETS


alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'

#tmuxinator
alias startw='tmuxinator start work'
alias stopw='tmuxinator stop work'\

#work
alias NULLR='ssh $NULLR'
alias CH='ssh $NODE_IP -p $NODE_PORT'
