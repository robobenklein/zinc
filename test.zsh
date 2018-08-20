#!/bin/zsh


typeset -A p10k_left_opts

p10k_left=(p10ks_user p10ks_host p10ks_cwd)
p10k_left_opts+=(
  p10ks_user 'white;black;;;'
  p10ks_host 'white;black;CONNECT_PREV;;'
  p10ks_cwd 'black;blue;;;fishy'
)

echo ${p10k_left}
echo ${(kv)p10k_left_opts}

source p10k.zsh-theme

p10k_reload

echo "===== START ====="

p10k_build_prompt_from_spec p10k_left p10k_left_opts

echo -e '\n===== SECOND BUILD ====='

p10k_build_prompt_from_spec p10k_left p10k_left_opts

echo -e '\n===== SETTING SHELL PROMPT ====='

PROMPT="%f%b%k\$(p10k_build_prompt_from_spec p10k_left p10k_left_opts)"

setopt prompt_subst
