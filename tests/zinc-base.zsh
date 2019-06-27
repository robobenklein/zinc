#!/usr/bin/env zunit

@test 'Load ZINC' {
  load ../zinc.zsh

  assert "$ZINC_INSTALL_DIR" is_not_empty
}

@test 'ZINC is in fpath and autoloadable' {
  load ../zinc.zsh

  assert "$ZINC_INSTALL_DIR/zinc_functions" in "${(@)fpath}"
  assert "$ZINC_INSTALL_DIR/zinc_functions/prompt_zinc_setup" is_readable
}

@test 'ZINC Worker gets started' {
  load ../zinc.zsh

  run prompt_zinc_setup testing

  run echo "${(@)ASYNC_CALLBACKS}"

  assert "_zinc_segment_async_callback" in "${(@)ASYNC_CALLBACKS}"
}
