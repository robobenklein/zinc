#!/usr/bin/env zunit

@setup {
  zinc_left=( zincs_vcs )

  prompt_zinc_setup
}

@test 'VCS segment is present' {
  run echo "$zinc_left"
  assert "zincs_vcs" in "${(@)zinc_left}"
}
