#!/bin/zsh

echo "" > /tmp/_P10K_DBG_OUT.log

p10k_left=(p10ks_userhost p10ks_cwd p10ks_vcs)
p10k_right=(p10ks_retval p10ks_execution_time p10ks_time)

typeset -A p10k_opts
p10k_opts=(
  p10ks_cwd 'black;blue;normal;;rtab;-t;-l'
)

echo ${p10k_left}
echo ${p10k_right}
echo ${(kv)p10k_opts}

zmodload zsh/zprof

source p10k.zsh-theme

fpath+=("$P10K_INSTALL_DIR/p10k_functions")
fpath+=("$P10K_INSTALL_DIR/segments")

prompt -p p10k

# echo "===== START ====="
#
# p10k_render_prompt_from_spec p10k_left p10k_opts
# print "$REPLY"
# print -P '$REPLY'
# p10k_render_prompt_from_spec p10k_right p10k_opts right
# print "$REPLY"
# print -P '$REPLY'
#
# echo -e '\n===== SECOND BUILD ====='
#
# p10k_render_prompt_from_spec p10k_left p10k_opts
# print "$REPLY"
# print -P '$REPLY'
# p10k_render_prompt_from_spec p10k_right p10k_opts right
# print "$REPLY"
# print -P '$REPLY'

echo -e '\n===== TIMING ====='

_P10K_DBG_OUT () {}
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'
N=6000
echo N=$N
time repeat $N { prompt_p10k_render_to_vars }

# zprof | head -20

echo

# which p10k_build_prompt_from_spec | cat -n
