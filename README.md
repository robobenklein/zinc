
# P10K

Basically a total rip-off of P9K, but completely rewritten from scratch with new priorities on speed and flexibility.

## Why P10K?

P10K compared to P9K is ...

 - Less user-friendly to configure
 - Much, much faster than P9K during runtime
 - Easily extensible (works via `fpath`)
 - More customizable (make your own segments with a standard API!)

Many configuration convenience sacrifices have been made to improve the speed, reliability, and usability of the prompt during runtime. After all, we might only spend a few hours configuring our prompt, but we'll spend orders of magnitude more actually *using* it.

P10K was built to support mixed async and non-async segments from the ground up. No more blocking calls for Git/HG/SVN information.

Also, async segments are smart:

 - redrawing the prompt doesn't start duplicate jobs
 - async output is by default cached until your next command (optional)
 - custom async segments are easy to implement and require no changes to P10K code

## Performance in mind:

 - Only functions that get used are loaded via `fpath`
 - Process forking and file I/O is avoided as much as possible (or moved to async when needed)
 - Prompt segments can be compiled to ZSH word code for better startup time.
 - ZSH builtins and binary modules are preferred to GNU utils / external binaries.
