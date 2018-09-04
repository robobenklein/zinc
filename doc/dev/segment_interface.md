# P10K Segment Interface

Segments in P10K follow a standardized interface, composed of multiple functions defined in various `autoload`ed files.

For these examples, we will be using a placeholder name for the segment name, `segmint`.

## Required: `segmint(){}`

Note:
> Official segments will be prefixed with `p10ks_` (P10K Segment)

This function should set the string (scalar) variable `REPLY` to the output of the segment. This output will be the text that gets rendered into the prompt.

```
function segmint() {
  REPLY="have a mint"
}
```

## Required: `segmint_default_opts(){}`

This function should set the array variable `reply` to the array of default arguments in case they are not defined by the user.

```
function segmint_default_opts() {
  reply=(white black normal normal)
}
```
