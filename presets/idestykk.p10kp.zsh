# vim: ft=zsh ts=2 sw=2 et fenc=utf-8

zinc_left=(
  zincs_time
  zincs_colordowtime
  zincs_retval
  zincs_userhost
  zincs_vcs
  zincs_cwd
  idestykk_newline
)

zinc_right=()

zinc_opts=(
  zincs_time 'CONDITIONAL;CONDITIONAL;;;'
  zincs_colordowtime 'CONDITIONAL;CONDITIONAL;normal;normal;'
  zincs_retval 'CONDITIONAL;CONDITIONAL;normal;;'
  zincs_userhost 'CONDITIONAL;CONDITIONAL;;;%n:%m'
  zincs_vcs 'white;239;;;'
  zincs_cwd 'CONDITIONAL;white;;;'
  idestykk_newline 'none;none;ENDLINE;none;'
)

idestykk_theme_weekdays_preview () {
  for i in {0..6}; do
    ZSH_THEME=zinc faketime "+${i}day" zsh -ic "prompt_preview_theme zinc idestykk"
  done
}

idestykk_newline () {
  REPLY="
$ "
}

# zmodload -i zsh/sched
function idestykk_redraw_timer () {
  zle && zle idestykk_redraw_widget
}
idestykk_redraw_widget () {
  [[ "$BUFFER" == "" ]] && {
    zle .reset-prompt
  }
}
zle -N idestykk_redraw_widget
trap idestykk_redraw_timer ALRM
# _ZINC_DBG_OUT "currently in $WIDGET with buffer as $BUFFER"
# WIDGET="idestykk_idle"

_DOW_N="0"

# days of the week 0..6 from strftime
typeset -gAH _iDestyKK_colors
_iDestyKK_colors=(
  0 "93"
  0_text "15"
  0_bright "129"
  1 "201"
  1_text "0"
  1_bright "213"
  2 "124"
  2_text "15"
  2_bright "160"
  3 "39"
  3_text "15"
  3_bright "45"
  4 "34"
  4_text "15"
  4_bright "40"
  5 "226"
  5_text "0"
  5_bright "248"
  6 "163"
  6_text "15"
  6_bright "199"
)

zincs_time_fg () {
  strftime -s _DOW_N '%w' $EPOCHSECONDS
  REPLY="${_iDestyKK_colors[${_DOW_N}_text]}"
}
zincs_time_bg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}_bright]}"
}

typeset -gHA zincs_colordowtime
zincs_colordowtime=(
  Sun "日"
  Mon "月"
  Tue "火"
  Wed "水"
  Thu "木"
  Fri "金"
  Sat "土"
)
function zincs_colordowtime () {
  local _DOW
  strftime -s _DOW '%a' $EPOCHSECONDS
  REPLY="${zincs_colordowtime[$_DOW]}"
}
zincs_colordowtime_fg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}_text]}"
}
zincs_colordowtime_bg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}]}"
}

zincs_retval_fg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}_text]}"
}
zincs_retval_bg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}_bright]}"
}

zincs_userhost_fg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}_text]}"
}
zincs_userhost_bg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}]}"
}

zincs_cwd_fg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}]}"
}
