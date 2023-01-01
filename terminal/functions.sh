function is_wsl() {
  if [[ $(grep microsoft /proc/version) ]]; then
    true
  else
    false
  fi
}