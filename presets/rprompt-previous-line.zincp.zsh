
function zc_begin () {
  REPLY="%{" # invis chars
  # REPLY+=$'\033[s' # save curpos
  REPLY+=$'\033[1A' # up 1L
  # REPLY+=$'\033[1C' # fwd over segment join space
  REPLY+="%}"
}

function zc_end () {
  REPLY=""
  REPLY+="${_ZINC_SEP_CHARS[rprompt_terminating_space]}"
  REPLY+="%{" # invis chars
  # REPLY+=$'\033[1D' # backspace over segment join space
  REPLY+=$'\033[1B' # down 1L
  # REPLY+=$'\033[u' # restore curpos
  REPLY+="%}"
}

function a_newline () {
  REPLY=$'\n'
}

zinc_left=(
  # a_newline
  zincs_userhost zincs_cwd_writable zincs_cwd zincs_vcs
)

zinc_right=(
  zc_begin
  zincs_retval zincs_execution_time zincs_jobs zincs_battery zincs_time zincs_virtualenv
  zc_end
)

function _zc_newline () {
  echo ""
}

-zinc-add-hook _zinc_precmd _zc_newline

zinc_opts=(
  a_newline "none;none;ZINC_SEGMENT_NONRENDERABLE;none"
  zc_begin 'none;none;ZINC_SEGMENT_NONRENDERABLE;none'
  zc_end 'none;none;ZINC_SEGMENT_NONRENDERABLE;none'
)
