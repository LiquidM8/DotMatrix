  # History settings
  HISTCONTROL=ignoredups:erasedups
  HISTSIZE=10000
  HISTFILESIZE=20000
  shopt -s histappend
  PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
