# vim: ft=zsh ts=2 sw=2 et fenc=utf-8

zinc_left=(
  zincs_userhost zincs_cwd zincs_vcs
)

zinc_right=(
  zincs_two zincs_retval zincs_execution_time zincs_jobs zincs_battery zincs_time zincs_virtualenv
)

zinc_fg+=(
  zincs_userhost white
  zincs_cwd black
  zincs_vcs orange
)
zinc_bg+=(
  zincs_userhost black
  zincs_cwd navy
)
zinc_opts+=(
  zincs_cwd "hyperlinks rtab on_chpwd full_git_roots"
  zincs_execution_time "sticky"
  zincs_retval "sticky"
  left ""
  right ""
)
