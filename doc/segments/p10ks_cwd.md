# Current Working Directory
## `p10ks_cwd`

## Options:
 - `$1`: FG
 - `$2`: BG
 - `$3`: Visual Draw Mode
 - `$4`: Render Process Mode
 - `$5`: DIR Display Strategy
 - `$@`: Additional args passed to the chosen strategy

### Common optstrings:

Example dir: `/home/robo/code/configs/zsh`

| optstring        | Example Output |
| ---------------- | -------------- |
| `;;;;rtab;`      | `/h/r/c/c/z`   |
| `;;;;rtab;-t;-l` | `~/c/con/zsh`  |

### DIR Display Strategy

| Strategy | Description                                      | Example                |
| -------- | ------------------------------------------------ | ---------------------- |
|          | No shortening, just `$PWD`                       | `/home/robo/code/p10k` |
| `rtab`   | Reverse tabbing function, has additional options | `~/c/p10k`             |

### Strategy options:

#### `rtab`:

Options can be set with `zstyle` calls, or as arguments `$6...N`

```
 -f, --fish      fish-simulation, like -l -s -t
 -l, --last      Print the last directory''s full name
 -s, --short     Truncate directory names to the first character
 -t, --tilde     Substitute ~ for the home directory
 -T, --nameddirs Substitute named directories as well
The long options can also be set via zstyle, like
  zstyle :prompt:rtab fish yes
```

Note that combined short form (`-sl`) options are *NOT* supported.
