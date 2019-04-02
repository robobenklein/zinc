
zinc_left=(
  zincs_userhost zincs_cwd_writable zincs_cwd zincs_vcs
)

zinc_right=(
  zincs_retval zincs_execution_time zincs_jobs zincs_battery zincs_time zincs_virtualenv
)

typeset -gA zincs_cwd
zincs_cwd[add_hyperlink]=1

zinc_opts=(
  zincs_cwd ';;;;rtab;-t;-l'
)
