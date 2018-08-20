# vim:ft=zsh ts=2 sw=2 et fenc=utf-8
#
# P10K
#
# A powerline ZSH theme, inspired by Powerlevel9k and friends.

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

typeset -U fpath
fpath+=("$P10K_INSTALL_DIR/segments")
echo $fpath

_P10K_DBG_OUT () {
  # ' >/tmp/_P10K_DBG_OUT.log 2>&1'
  echo "$@" >>/tmp/_P10K_DBG_OUT.log
}

typeset -a _P10K_AUTOLOADED_FUNCTIONS
function p10k_reload () {
  for segment_function in $_P10K_AUTOLOADED_FUNCTIONS; do
    unfunction $segment_function
    autoload -U $segment_function
  done
}

function p10k_build_prompt_from_spec () {
  setopt localoptions
  # Builds the prompt with the given name.
  #
  # $1: Name of a p10k prompt segment array.
  # $2: Name of a p10k segment options array.

  local prev_bg="NOCONNECT"
  local -A _p10k_opts
  _p10k_opts=(${(kvP)${2}})

  for cur_segment in ${(P)${1}}; do
    (( ${+functions[$cur_segment]} )) || function {
      _P10K_DBG_OUT "loading segment $cur_segment"
      autoload -U +X $cur_segment
      _P10K_AUTOLOADED_FUNCTIONS+=($cur_segment)
    }
    local -a segment_opts
    segment_opts=(${(@s<;>)_p10k_opts[$cur_segment]})
    _P10K_DBG_OUT $cur_segment':' $segment_opts
    if [[ $prev_bg == "NOCONNECT" ]] || [[ ${segment_opts[3]} == "CONNECT_PREV" ]]; then
      # skip drawing the arrow
      printf '%b' '%K{'${segment_opts[2]}'} '
    else
      printf '%b' ' %K{'${segment_opts[2]}'}%F{'${prev_bg}'} '
    fi
    printf '%b' '%F{'${segment_opts[1]}'}'
    "${cur_segment}" ${segment_opts}
    prev_bg="${segment_opts[2]}"
  done

  # finish the prompt line:
  printf '%b' ' %k%F{'${prev_bg}'}%f '

}
