# Detect if we're inside tmux
if [ -n "$TMUX" ]; then
    # Make sure TERM is set to what tmux expects
    export TERM=tmux-256color
else
    # Set a default TERM for non-tmux (standard SSH or local terminal)
    export TERM=xterm-256color
fi

# When SSHing into switches/servers, force a safe TERM if needed
ssh() {
    # If user explicitly set TERM_SAFE, use that
    if [ -n "$TERM_SAFE" ]; then
        command ssh -o SendEnv=TERM_SAFE "$@"
        return
    fi

    # Example: if going to Cisco/Juniper or embedded devices, use vt100
    case "$*" in
        *cisco*|*juniper*|*switch*|*router*)
            TERM_SAFE=vt100 command ssh -o SendEnv=TERM_SAFE "$@"
            ;;
        *)
            command ssh "$@"
            ;;
    esac
}

