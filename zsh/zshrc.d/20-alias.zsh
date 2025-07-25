# Aliases

#secrets
source $HOME/DotMatrix/.env/SECRETS

# Colors and List
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'

#tmuxinator
alias startw='tmuxinator start work'
alias stopw='tmuxinator stop work'\

#Linux
alias serial='sudo picocom -b 9600 /dev/ttyUSB0'

#NVIM env
nvs() {
  case "$1" in
    lazy)    ln -sfn "$HOME/LiquiVim/nvim-lazy"   "$HOME/.config/nvim" ;;
    custom)  ln -sfn "$HOME/LiquiVim/nvim-custom" "$HOME/.config/nvim" ;;
    *)
      echo "Usage: nvs lazy|custom" ;;
  esac
}

#work
alias NULLR='ssh $NULLR'
alias CH='ssh $NODE_IP -p $NODE_PORT'

#servers 
alias prox='ssh $PROX'
alias webdev='ssh $WEBDEV -p $DPORT'
alias mc='ssh $MINE -p $MPORT -i $CORE'




