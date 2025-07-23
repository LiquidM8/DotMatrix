# SSH Keychain (Optional if using Keychain for SSH agent)
if command -v keychain &>/dev/null; then
    eval "$(keychain --quiet --eval master noc)"
fi
