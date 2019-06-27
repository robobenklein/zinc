
zinc_default_user="robo"
zinc_default_host="robo-unseptium"

# either user and host separate with CONNECT_PREV
# or zincs_userhost
zinc_left=(
  # zincs_user
  # zincs_host
  zincs_userhost
  zincs_cwd
  zincs_vcs
)

zinc_right=(
  zincs_retval
  zincs_execution_time
  my_custom_time
  zincs_jobs
)

zinc_opts=(
  zincs_user "white;black;CONDITIONAL;normal"
  zincs_host "white;black;CONNECT_PREV+CONDITIONAL;normal"
  zincs_userhost "white;black;CONDITIONAL;normal"
  my_custom_time "black;white;normal;normal"
)

# autohide the user when it's default
function zincs_user_display_hidden () {
  [[ "$USER" == "$zinc_default_user" ]] && true || false
}
function zincs_host_display_hidden () {
  [[ "$HOST" == "$zinc_default_host" ]] && true || false
}

# or show both when either changes:
function zincs_userhost_display_hidden () {
  [[ "$HOST" == "$zinc_default_host" ]] && [[ "$USER" == "$zinc_default_user" ]] && true
}

# set the time format option:
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
function my_custom_time () {
  REPLY="%T"
}

# set the zincs_execution_time min time:
zincs_execution_time[threshold]=10
