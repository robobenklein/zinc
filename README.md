
# P10K

Inspired by Powerlevel9K, this is a powerline theme written from scratch in pure ZSH.

P10K is ZSH software, not just shell scripts. (See https://github.com/zdharma/Zsh-100-Commits-Club )

## Why P10K?

P10K compared to P9K is ...

 - Configured and structured very differently (P10K uses ZSH associations for almost all options)
 - Much, much faster than P9K during runtime
 - Easily extensible (works via shell functions and zsh's `fpath`)
 - More customizable (make your own segments with a standard API!)

P10K was built to support mixed async and non-async segments from the ground up. No more blocking calls for Git/HG/SVN information or any other command.

Also, async segments are smart:

 - redrawing the prompt doesn't start duplicate jobs
 - async output can be cached differently per-segment
 - custom async segments are easy to implement (3 shell functions) and require no changes to P10K code

### Note about Icons

If you're in it for the super-fancy icons from Nerd-Fonts, etc, Powerlevel9K is still a better choice as the advanced Icon registry and alternative font support is not present in P10K by default.

## Performance:

 - Only functions that get used are loaded via ZSH's `fpath` autoload functionality
 - **There are no external calls in the main thread.** Program calls and shell forking is all done in an async worker.
 - Prompt segments can be compiled to ZSH word code for better startup time. (Just execute `prompt_p10k_compile`)
 - ZSH builtins and binary modules are preferred to GNU utils / external binaries.

Timing example compared to other shell prompts:
```
# P10K: Renders both left and right variables:
( repeat 1000; do; prompt_p10k_render_to_vars > /dev/null; done; )  1.28s user 0.26s system 99% cpu 1.542 total

# P9K 0.6: Functions for left/right
( repeat 1000; do; build_left_prompt > /dev/null && build_right_prompt > ; ; )  88.42s user 50.85s system 114% cpu 2:01.69 total

# Pure: render in precmd
( repeat 1000; do; prompt_pure_precmd > /dev/null; done; )  0.43s user 0.12s system 99% cpu 0.555 total

```
> All tests done with Git information enabled and with the same git repo state.
