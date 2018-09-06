# Execution Time
## `p10ks_execution_time`

## Options:
- `$1`: FG
- `$2`: BG
- `$3`: Display Mode: see latter section.
- `$4`: Not used by this segment.
- `$5`: Optional minimum time for `CONDITIONAL` display mode.

### Display Mode

This segment supports the `CONDITIONAL` display mode. (This is the default display mode.)

The condition here is whether or not the execution time of the last command was greater than `p10ks_execution_time['threshold']`, if `true` then the segment will be shown.
