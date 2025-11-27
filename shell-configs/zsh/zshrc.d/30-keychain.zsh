# SSH Keychain (Optional if using Keychain for SSH agent)
if command -v keychain &>/dev/null; then
  eval "$(keychain --quiet --eval keys/RSA 2>/dev/null)"
fi

load_noc() {
  if ! keychain --list 2>/dev/null | grep -q '\bnoc\b'; then
    eval "$(keychain --quiet --eval --timeout 10 keys/NOC 2>/dev/null)"
    echo "NOC Key Loaded!"
  else
    echo "Already Loaded"
  fi
}

