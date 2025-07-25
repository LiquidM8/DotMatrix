# SSH Keychain (Optional if using Keychain for SSH agent)
if command -v keychain &>/dev/null; then
  eval "$(keychain --quiet --eval master id_core)"
fi

load_noc() {
  if ! keychain --list 2>/dev/null | grep -q '\bnoc\b'; then
    eval "$(keychain --quiet --eval --timeout 10 noc)"
    echo "NOC Key Loaded!"
  else
    echo "Already Loaded"
  fi
}

