function is_msys() {
  if [[ $(grep MSYS_NT /proc/version) ]]; then
    true
  else
    false
  fi
}

function is_wsl() {
  if [[ $(grep microsoft /proc/version) ]]; then
    true
  else
    false
  fi
}