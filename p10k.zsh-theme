# vim: ft=zsh ts=2 sw=2 et fenc=utf-8
#
# P10K

# Set zrllink utility.
if (( ${+commands[readlink]} )); then
  function _p10k_zrllink() {
    readlink -f $1
  }
  if [[ "$(uname)" == "Darwin" ]]; then
    function _p10k_zrllink() {
      readlink $1
    }
  fi
elif (( ${+commands[perl]} )); then
  function _p10k_zrllink() {
    perl -MCwd -le 'print Cwd::abs_path(shift)' $1
  }
else
  printf '%b\n' "\033[0;31mP10K: Couldn't find a valid symlink resolver! P10K may not load correctly!\033[0m"
fi

### install location detection
local _P10K_SCRIPTPATH="${(%):-%N}"
echo $_P10K_SCRIPTPATH
local _P10K_INSTALL_LOC="$(_p10k_zrllink $_P10K_SCRIPTPATH)"
echo $_P10K_INSTALL_LOC
local P10K_INSTALL_DIR="${_P10K_INSTALL_LOC%/*}"

# TODO check if exist then add, instead of type unique
typeset -U fpath
fpath+=("$P10K_INSTALL_DIR/p10k_functions")
fpath+=("$P10K_INSTALL_DIR/segments")
echo $fpath

autoload -Uz promptinit; promptinit

prompt p10k
