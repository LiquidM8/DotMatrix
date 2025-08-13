# Loads all secrets from GitRoot
if git_root="$(git -C "$(dirname "${(%):-%x}")" rev-parse --show-toplevel 2>/dev/null)"; then
  env_dir="$git_root/.env"
  if [[ -d "$env_dir" ]]; then
    for secret_file in "$env_dir"/*(.N); do
      [[ -f "$secret_file" && -r "$secret_file" ]] && source "$secret_file"
    done
  fi
fi

# Store loaded paths so we can unload later
typeset -gA _loaded_venv_paths

# Load all venvs in ~/GitHub/*/.venv/bin into PATH
load_all_venvs() {
  for venv_path in ~/GitHub/*/.venv/bin; do
    if [[ -d "$venv_path" && -z "${_loaded_venv_paths[$venv_path]}" ]]; then
      export PATH="$venv_path:$PATH"
      _loaded_venv_paths[$venv_path]=1
      echo "Loaded: $venv_path"
    fi
  done
}

# Unload all previously loaded venv paths
unload_all_venvs() {
  for venv_path in ${(k)_loaded_venv_paths}; do
    # Remove from PATH (replace all occurrences)
    PATH=${PATH//:$venv_path/}
    PATH=${PATH//$venv_path:/}
    PATH=${PATH//$venv_path/}
    unset '_loaded_venv_paths[$venv_path]'
    echo "Unloaded: $venv_path"
  done
  export PATH
}

