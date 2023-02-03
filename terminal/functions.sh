function is_msys() {
  if [[ ${MSYS2_PATH} ]]; then
    true
  else
    false
  fi
}

function is_wsl() {
  if [[ ${WSL_DISTRO_NAME} ]]; then
    true
  else
    false
  fi
}

function get_distro() {
  if [[ $(grep 'MSYS_NT\|MINGW64_NT' /proc/version) ]]; then
    echo "msys"
  else
    lsb_release -a | grep "Distributor ID:" | cut -d':' -f2 | tr '[:upper:]' '[:lower:]' | xargs echo
  fi
}