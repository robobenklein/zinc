# P10K Asynchronous Segment Interface

Segments in P10K follow a standardized interface, composed of multiple functions defined in various `autoload`ed files.

This document describes the interface for asynchronous segments. If you are looking for synchronous segments (much simpler), look at the [Standard Interface Docs](segment_interface.md).

We will be continuing to use the `segmint` placeholder name in these examples.

## Required: `segmint(){}`

Same as in the synchronous segments.

## Required: `segmint_default_opts(){}`

Same as in the synchronous segments.

## Required: `segmint_async(){}`

```shell
function segmint_async () {
  sleep 1 # do some work
  echo "async-hi"
}
```

This is the probably where most of your code will go. This function is **not** ever loaded in the interactive Zsh session.

Instead, this function gets autoloaded inside the async worker, and is executed inside that context.

## Required: `segmint_async_return(){}`

This function is called with the results from the async job in this fashion:

```shell
# using numbers from the zsh-async library's callbacks:
# $1 name of segment, in this example "segmint"
# $2 return code
# $3 resulting (stdout) output from job execution
# $4 execution time, floating point e.g. 0.0076138973 seconds
# $5 resulting (stderr) error output from job execution
#
# RETURN_CODE STDOUT EXEC_TIME STDERR
"${1}_return" "$2" "$3" "$4" "$5"
```

So if all you care about is the `stdout`, just take in arg `${2}` inside your function.

## Required: `segmint_async_started(){}`

This function is called as soon as the async job is given to the worker.

You should use this function to clear old returned values so the user is not presented with stale data.

This function is passed the same 4 or more args from the `p10k_opts` mapping. See the synchronous docs for the explanation on these.
