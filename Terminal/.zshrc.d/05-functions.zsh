# Loads all secrets from GitRoot
if git_root="$(git -C "$(dirname "${(%):-%x}")" rev-parse --show-toplevel 2>/dev/null)"; then
  env_dir="$git_root/.env"
  if [[ -d "$env_dir" ]]; then
    for secret_file in "$env_dir"/*(.N); do
      [[ -f "$secret_file" && -r "$secret_file" ]] && source "$secret_file"
    done
  fi
fi
