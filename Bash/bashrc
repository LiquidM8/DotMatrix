# ~/.bashrc
# Bash configuration file

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable programmable completion features (if not already enabled)
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

# Source additional config files if needed
for file in ~/.bashrc.d/*.sh; do
  [ -r "$file" ] && source "$file"
done

# Enable case-insensitive tab-completion
set completion-ignore-case on

# Starship Config
eval "$(starship init bash)"
