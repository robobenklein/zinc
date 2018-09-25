# vim: ft=zsh ts=2 sw=2 et fenc=utf-8

p10k_left=(
  p10ks_time p10ks_colordowtime
  p10ks_retval p10ks_userhost
  p10ks_vcs p10ks_cwd
  idestykk_newline
)

p10k_right=()

p10k_opts=(
  p10ks_time 'CONDITIONAL;CONDITIONAL;;;'
  p10ks_colordowtime 'CONDITIONAL;CONDITIONAL;normal;normal;'
  p10ks_retval 'CONDITIONAL;CONDITIONAL;normal;;'
  p10ks_userhost 'CONDITIONAL;CONDITIONAL;;;%n:%m'
  p10ks_vcs 'white;239;;;'
  p10ks_cwd 'CONDITIONAL;white;;;'
  idestykk_newline 'none;none;ENDLINE;none;'
)

idestykk_theme_weekdays_preview () {
  for i in {0..6}; do
    ZSH_THEME=p10k faketime "+${i}day" zsh -ic "prompt_preview_theme p10k idestykk"
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
# _P10K_DBG_OUT "currently in $WIDGET with buffer as $BUFFER"
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

p10ks_time_fg () {
  strftime -s _DOW_N '%w' $EPOCHSECONDS
  REPLY="${_iDestyKK_colors[${_DOW_N}_text]}"
}
p10ks_time_bg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}_bright]}"
}

typeset -gHA p10ks_colordowtime
p10ks_colordowtime=(
  Sun "日"
  Mon "月"
  Tue "火"
  Wed "水"
  Thu "木"
  Fri "金"
  Sat "土"
)
function p10ks_colordowtime () {
  local _DOW
  strftime -s _DOW '%a' $EPOCHSECONDS
  REPLY="${p10ks_colordowtime[$_DOW]}"
}
p10ks_colordowtime_fg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}_text]}"
}
p10ks_colordowtime_bg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}]}"
}

p10ks_retval_fg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}_text]}"
}
p10ks_retval_bg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}_bright]}"
}

p10ks_userhost_fg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}_text]}"
}
p10ks_userhost_bg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}]}"
}

p10ks_cwd_fg () {
  REPLY="${_iDestyKK_colors[${_DOW_N}]}"
}
