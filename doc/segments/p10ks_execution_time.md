# Execution Time
## `p10ks_execution_time`

## Options:
- `$1`: FG
- `$2`: BG
- `$3`: Display Mode: see latter section.
- `$4`: Only async mode `notify_complete` is supported.
- `$5`: Optional minimum time for `CONDITIONAL` display mode.

### Display Mode

This segment supports the `CONDITIONAL` display mode. (This is the default display mode.)

The condition here is whether or not the execution time of the last command was greater than `p10ks_execution_time[threshold]`, if `true` then the segment will be shown.

You can also pass the threshold value as segment option 5, ex:

```shell
p10k_opts=(
  p10ks_execution_time ';;;;10' # 10 seconds
)
# OR if you've already set p10k_opts:
p10k_opts[p10ks_execution_time]=';;;;10'
```

Note:
> `$5` is used at load-time while `p10ks_execution_time[threshold]` is used during runtime.
