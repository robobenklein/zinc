#!/usr/bin/env zunit

@test 'ZINC VCS' {
  zinc_left=( zincs_vcs )

  load ../zinc.zsh

  run prompt_zinc_setup testing
}
