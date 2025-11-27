# Aliases

# Source all secret environment files
for file in $HOME/GitHub/DotMatrix/.env/*; do
    [ -f "$file" ] && source "$file"
done

# Colors and List
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'

#Linux
alias serial='sudo picocom -b 9600 /dev/ttyUSB0'

#Legacy Server Connections
alias eolssh='ssh -o KexAlgorithms=+diffie-hellman-group1-sha1 -o Ciphers=+aes256-cbc -o PubkeyAcceptedKeyTypes=+ssh-rsa -o HostKeyAlgorithms=+ssh-rsa'

# Work
alias NULLR='ssh $LOCAL_USER@$NULL_HOST'
alias CH='ssh $LOCAL_USER@$CH_HOST -p $CH_PORT -i $HOME/.ssh/keys/RSA'

# Servers
