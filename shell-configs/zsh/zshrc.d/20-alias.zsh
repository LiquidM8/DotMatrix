# Aliases

#secrets
#source $HOME/GitHub/DotMatrix/.env/zsh_secrets

# Colors and List
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'

#tmuxinator
alias startw='tmuxinator start work'
alias stopw='tmuxinator stop work'
alias startd='tmuxinator start dev'
alias stopd='tmuxinator stop dev'


#Linux
alias serial='sudo picocom -b 9600 /dev/ttyUSB0'

#Legacy Server Connections
alias eolssh='ssh -o KexAlgorithms=+diffie-hellman-group1-sha1 -o Ciphers=+aes256-cbc -o PubkeyAcceptedKeyTypes=+ssh-rsa -o HostKeyAlgorithms=+ssh-rsa'

# Work
alias NULLR='ssh $ZUSER@$NULL_HOST'
alias CH='ssh $ZUSER@$CH_NODE -p $CH_PORT'

# Servers
alias prox='ssh $RUSER@$PROX'
alias BM='ssh $DUSER@BM -p $DPORT'
