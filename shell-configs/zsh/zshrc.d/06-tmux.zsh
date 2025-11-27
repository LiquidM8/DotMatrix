# Detect if we're inside tmux
if [ -n "$TMUX" ]; then
    # Make sure TERM is set to what tmux expects
    export TERM=tmux-256color
else
    # Preserve kitty's TERM if present, otherwise use xterm-256color
    case "$TERM" in
        xterm-kitty)
            # Keep kitty's native TERM - SSH wrapper will handle compatibility
            ;;
        *)
            # Set a default TERM for non-tmux (standard SSH or local terminal)
            export TERM=xterm-256color
            ;;
    esac
fi

# When SSHing into switches/servers, force a safe TERM if needed
ssh() {
    # If using kitty or other advanced terminal, downgrade TERM for SSH
    # Many switches/routers don't understand xterm-kitty
    local ssh_term="$TERM"

    case "$TERM" in
        xterm-kitty|*-direct)
            # Use widely compatible TERM for SSH connections
            ssh_term="xterm-256color"
            ;;
    esac

    # If user explicitly set TERM_SAFE, use that instead
    if [ -n "$TERM_SAFE" ]; then
        ssh_term="$TERM_SAFE"
    fi

    # For network devices, use even safer TERM (vt100/xterm)
    case "$*" in
        *cisco*|*juniper*|*switch*|*router*)
            ssh_term="xterm"
            ;;
    esac

    TERM="$ssh_term" command ssh "$@"
}

