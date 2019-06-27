#!/usr/bin/env zunit

@setup {
  zinc_left=( zincs_userhost )

  prompt_zinc_setup
}

@test 'Detect install location' {
  assert "$ZINC_INSTALL_DIR" is_not_empty
}

@test 'ZINC is in fpath and autoloadable' {
  assert "$ZINC_INSTALL_DIR/zinc_functions" in "${(@)fpath}"
  assert "$ZINC_INSTALL_DIR/zinc_functions/prompt_zinc_setup" is_readable
}

@test 'ZINC Worker gets started' {
  assert "_zinc_segment_async_callback" in "${(@)ASYNC_CALLBACKS}"
}
