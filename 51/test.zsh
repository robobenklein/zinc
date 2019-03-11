#!/bin/zsh

echo "" > /tmp/_ZINC_DBG_OUT.log

zinc_left=(zincs_userhost zincs_cwd zincs_vcs)
zinc_right=(zincs_retval zincs_execution_time zincs_time)

typeset -A zinc_opts
zinc_opts=(
  zincs_cwd 'black;blue;normal;;rtab;-t;-l'
)

echo ${zinc_left}
echo ${zinc_right}
echo ${(kv)zinc_opts}

zmodload zsh/zprof

source zinc.zsh-theme

fpath+=("$ZINC_INSTALL_DIR/zinc_functions")
fpath+=("$ZINC_INSTALL_DIR/segments")

prompt -p zinc

# echo "===== START ====="
#
# zinc_render_prompt_from_spec zinc_left zinc_opts
# print "$REPLY"
# print -P '$REPLY'
# zinc_render_prompt_from_spec zinc_right zinc_opts right
# print "$REPLY"
# print -P '$REPLY'
#
# echo -e '\n===== SECOND BUILD ====='
#
# zinc_render_prompt_from_spec zinc_left zinc_opts
# print "$REPLY"
# print -P '$REPLY'
# zinc_render_prompt_from_spec zinc_right zinc_opts right
# print "$REPLY"
# print -P '$REPLY'

echo -e '\n===== TIMING ====='

_ZINC_DBG_OUT () {}
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'
N=6000
echo N=$N
time repeat $N { prompt_zinc_render_to_vars }

# zprof | head -20

echo

# which zinc_build_prompt_from_spec | cat -n
