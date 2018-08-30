
if (( ${+commands[readlink]} )); then
  if [[ "$(uname)" == "Darwin" ]]; then
  fi
elif (( ${+commands[perl]} )); then
else
  printf '%b\n' "\033[0;31mP10K: Couldn't find a valid symlink resolver! Please modify your fpath manually!\033[0m"
fi
local _P10K_SCRIPTPATH="${(%):-%N}"
local _P10K_INSTALL_LOC="$(_p10k_zrllink $_P10K_SCRIPTPATH)"
local P10K_INSTALL_DIR="${_P10K_INSTALL_LOC%/*}"
typeset -U fpath
fpath+=("$P10K_INSTALL_DIR/p10k_functions")
fpath+=("$P10K_INSTALL_DIR/segments")
fpath+=("$P10K_INSTALL_DIR/51")

autoload -Uz promptinit; promptinit

prompt p10k
