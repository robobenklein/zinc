# vim: ft=zsh ts=2 sw=2 et fenc=utf-8
#
# ZINC

# Set zrllink utility.
if (( ${+commands[readlink]} )); then
  function _zinc_zrllink() {
    readlink -f $1
  }
  if [[ "$(uname)" == "Darwin" ]]; then
    function _zinc_zrllink() {
      readlink $1
    }
  fi
elif (( ${+commands[perl]} )); then
  function _zinc_zrllink() {
    perl -MCwd -le 'print Cwd::abs_path(shift)' $1
  }
else
  printf '%b\n' "\033[0;31mZINC: Couldn't find a valid symlink resolver! Please modify your fpath manually!\033[0m"
fi

### install location detection
_ZINC_SCRIPTPATH="${(%):-%N}"
# echo $_ZINC_SCRIPTPATH
_ZINC_INSTALL_LOC="$(_zinc_zrllink $_ZINC_SCRIPTPATH)"
# echo $_ZINC_INSTALL_LOC
ZINC_INSTALL_DIR="${_ZINC_INSTALL_LOC%/*}"

function zinc_selfdestruct_setup () {
  # TODO check if exist then add, instead of type unique
  (( ${fpath[(I)"$ZINC_INSTALL_DIR/zinc_functions"]} )) || {
    fpath+=("$ZINC_INSTALL_DIR/zinc_functions")
    fpath+=("$ZINC_INSTALL_DIR/segments")
  }

  # remove self from precmd
  precmd_functions=("${(@)precmd_functions:#zinc_selfdestruct_setup}")

  autoload -Uz +X prompt_zinc_setup async
  autoload -Uz +X promptinit 2>&1 >/dev/null && {
    promptinit
    prompt zinc
  } || {
    prompt_zinc_setup
  }
  prompt_zinc_preexec
  prompt_zinc_precmd
  zle && zle .reset-prompt
}

autoload -Uz add-zsh-hook

add-zsh-hook precmd zinc_selfdestruct_setup

fpath+=("$ZINC_INSTALL_DIR/zinc_functions")
fpath+=("$ZINC_INSTALL_DIR/segments")

autoload -Uz +X prompt_zinc_setup async
