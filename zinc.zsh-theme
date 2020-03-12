# vim: ft=zsh ts=2 sw=2 et fenc=utf-8
#
# ZINC

_ZINC_DBG_OUT () {;}

typeset -gHA _ZINC_0
_ZINC_0[srcfile]="${_ZINC_SCRIPTPATH:-${ZERO:-${(%):-%N}}}"
_ZINC_0[repo]="${_ZINC_0[srcfile]:h}"

# Set zrllink utility.
if (( ${+commands[readlink]} )) && [[ "$(uname)" != "Darwin" ]]; then
  function _zinc_zrllink() {
    readlink -f $1
  }
elif (( ${+commands[python]} )); then
  function _zinc_zrllink() {
    python -c "import os; print(os.path.realpath('$1'))"
  }
elif (( ${+commands[perl]} )); then
  function _zinc_zrllink() {
    perl -MCwd -le 'print Cwd::abs_path(shift)' $1
  }
else
  printf '%b\n' "\033[0;31mZINC: Couldn't find a valid symlink resolver! Please modify your fpath manually!\033[0m"
fi

prompt_zinc_setup () {
  prompt_opts=( cr percent sp subst )
  setopt noprompt{cr,percent,sp,subst} "prompt${^prompt_opts[@]}"

  if [[ "$1" == "dev" ]]; then
    shift
    fpath[1,0]="${_ZINC_0[repo]}/51"
    fpath[1,0]="${_ZINC_0[repo]}/segments"
    # enable debugging logging
    _ZINC_DBG_OUT () {
      # ' >/tmp/_ZINC_DBG_OUT.log 2>&1'
      echo -e "[38;5;8m$@[0m" # >> ~/._ZINC_DBG_OUT.log
    }
  fi

  (( ${fpath[(I)"${_ZINC_0[repo]}/segments"]} )) || {
    fpath+=("${_ZINC_0[repo]}/segments")
  }

  for depfile in ${_ZINC_0[repo]}/zinc_core/@*; do
    _ZINC_DBG_OUT "loading $depfile"
    source "${depfile}"
  done

  # user configuration variables:
  typeset -ga zinc_left zinc_right
  typeset -gA zinc_fg zinc_bg zinc_opts

  # internal globals
  typeset -gA _ZINC_ASYNC_STATII

  # load a preset by name
  if [[ "$1" != "" ]]; then
    if [[ -r "${_ZINC_0[repo]}/presets/${1}.zincp.zsh" ]]; then
      _ZINC_DBG_OUT "loading preset $1"
      source "${_ZINC_0[repo]}/presets/${1}.zincp.zsh"
    else
      echo "ZINC: No such preset found in ${_ZINC_0[repo]}/presets/."
    fi
  fi

  async_init
  @zinc-hooks-init

  PROMPT="%f%b%k\${_ZINC_RENDERED_PROMPT}"
  RPROMPT="%f%b%k\${_ZINC_RENDERED_RPROMPT}%f%b%k"

  @zinc-run-hook _zinc_hook_precmd
  @zinc-run-hook _zinc_hook_chpwd
}
