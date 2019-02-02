# vim: ft=zsh ts=2 sw=2 et fenc=utf-8

p10k_left=(
  p10ks_time
  p10ks_colordowtime
  p10ks_retval
  p10ks_userhost
  p10ks_vcs
  p10ks_cwd
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

function idestykk_day_settings_monday () {
  # Time Prompt
  TIME_FG='15'
  TIME_BG='207'

  # Return Prompt
  PASS_FG='16'
  PASS_BG='85'
  FAIL_FG='15'
  FAIL_BG='197'

  # User Prompt
  HOST_FG='15'
  HOST_BG='212'

  # Git Prompt
  GIT_FG='15'
  GIT_BG='241'

  # Path Prompt
  PATH_FG='212'
  PATH_BG='255'

}
function idestykk_day_settings_tuesday () {
  # Time Prompt
  TIME_FG='15'
  TIME_BG='196'

  # Return Prompt
  PASS_FG='16'
  PASS_BG='82'
  FAIL_FG='15'
  FAIL_BG='197'

  # User Prompt
  HOST_FG='15'
  HOST_BG='160'

  # Git Prompt
  GIT_FG='15'
  GIT_BG='241'

  # Path Prompt
  PATH_FG='160'
  PATH_BG='255'

}
function idestykk_day_settings_wednesday () {
  # Time Prompt
  TIME_FG='15'
  TIME_BG='75'

  # Return Prompt
  PASS_FG='16'
  PASS_BG='86'
  FAIL_FG='15'
  FAIL_BG='197'

  # User Prompt
  HOST_FG='15'
  HOST_BG='74'

  # Git Prompt
  GIT_FG='15'
  GIT_BG='241'

  # Path Prompt
  PATH_FG='74'
  PATH_BG='255'

}
function idestykk_day_settings_thursday () {
  # Time Prompt
  TIME_FG='15'
  TIME_BG='28'

  # Return Prompt
  PASS_FG='16'
  PASS_BG='10'
  FAIL_FG='15'
  FAIL_BG='196'

  # User Prompt
  HOST_FG='15'
  HOST_BG='34'

  # Git Prompt
  GIT_FG='15'
  GIT_BG='241'

  # Path Prompt
  PATH_FG='28'
  PATH_BG='255'

}
function idestykk_day_settings_friday () {
  # Time Prompt
  TIME_FG='236'
  TIME_BG='227'

  # Return Prompt
  PASS_FG='16'
  PASS_BG='248'
  FAIL_FG='15'
  FAIL_BG='196'

  # User Prompt
  HOST_FG='228'
  HOST_BG='238'

  # Git Prompt
  GIT_FG='15'
  GIT_BG='241'

  # Path Prompt
  PATH_FG='238'
  PATH_BG='255'

}
function idestykk_day_settings_saturday () {
  # Time Prompt
  TIME_FG='15'
  TIME_BG='204'

  # Return Prompt
  PASS_FG='16'
  PASS_BG='86'
  FAIL_FG='15'
  FAIL_BG='196'

  # User Prompt
  HOST_FG='15'
  HOST_BG='203'

  # Git Prompt
  GIT_FG='15'
  GIT_BG='241'

  # Path Prompt
  PATH_FG='203'
  PATH_BG='255'

}
function idestykk_day_settings_sunday () {
  # Time Prompt
  TIME_FG='15'
  TIME_BG='99'

  # Return Prompt
  PASS_FG='16'
  PASS_BG='86'
  FAIL_FG='15'
  FAIL_BG='197'

  # User Prompt
  HOST_FG='15'
  HOST_BG='105'

  # Git Prompt
  GIT_FG='15'
  GIT_BG='241'

  # Path Prompt
  PATH_FG='105'
  PATH_BG='255'

}

typeset -ga p10ks_dowmap
p10ks_dowmap=(
  monday
  tuesday
  wednesday
  thursday
  friday
  saturday
  sunday
)

idestykk_newline () {
  REPLY="
$ "
}

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

p10ks_time_fg () {
  strftime -s _DOW_N '%w' $EPOCHSECONDS
  idestykk_day_settings_${p10ks_dowmap[${_DOW_N}]}
  REPLY="${TIME_FG}"
}
p10ks_time_bg () {
  REPLY="${TIME_BG}"
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
  REPLY="${HOST_FG}"
}
p10ks_colordowtime_bg () {
  REPLY="${HOST_BG}"
}

p10ks_retval_fg () {
  [[ ${_P10K_RETVAL_STORE} == 0 ]] && {
    REPLY="${PASS_FG}"
  } || {
    REPLY="${FAIL_FG}"
  }
}
p10ks_retval_bg () {
  [[ ${_P10K_RETVAL_STORE} == 0 ]] && {
    REPLY="${PASS_BG}"
  } || {
    REPLY="${FAIL_BG}"
  }
}

p10ks_userhost_fg () {
  REPLY="${HOST_FG}"
}
p10ks_userhost_bg () {
  REPLY="${HOST_BG}"
}

p10ks_cwd_fg () {
  REPLY="${PATH_FG}"
}
p10ks_cwd_bg () {
  REPLY="${PATH_BG}"
}
