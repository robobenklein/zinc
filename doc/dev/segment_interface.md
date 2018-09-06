# P10K Segment Interface

Segments in P10K follow a standardized interface, composed of multiple functions defined in various `autoload`ed files.

For these examples, we will be using a placeholder name for the segment name, `segmint`.

# Functions

Functions that get called by P10K.

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

## Optional: `segmint_fg(){}` and `segmint_bg(){}`

If `$1` (fg) or `$2` (bg) are set as `CONDITIONAL` in the segment options, P10K will call these functions to get the desired foreground/background color settings.

## Optional: `segmint_display_hidden(){}`

If `$3` is set as `CONDITIONAL` then this function will be called to determine if this segment should be hidden or not.

Only the exit status of this function is checked:

```
segmint_display_hidden && (segment is hidden) || (show the segment)
```

This is so that segments are shown by default.

## Optional: `segmint_async(){}`

This and other asynchronous segment functions are covered in detail in the [Asynchronous Interface Docs](segment_interface_async.md)

# Using P10K hooks

P10K makes a few hooks available for segments that request them:

| Hook | Description |
| --- | --- |
| `_p10k_preexec` | Executed in the `preexec` ZSH hook, but in the proper P10K context. |
| `_p10k_precmd` | Same as `preexec`, but in the P10K `precmd` function. |
| `_p10k_chpwd` | Executed after the segment worker has also updated it's PWD, during normal ZSH `chpwd` hook. |
| `_p10k_async_complete` | This hook is triggered when all the async tasks have finished completely and **after** the final prompt rendering. It will not be triggered if a command line is processed before the async tasks all return. |
