
local pzsd_segment_sources=${pzsd_segment_sources:-segments}
local pzsd_outputfolder=${pzsd_outputfolder:-zsdoc-src}

set -e

function create_doc_scaffold () {
  local outputfile="$1"
  local segment="$2"
  echo > $outputfile
  [[ -s ${pzsd_segment_sources}/p10ks_${segment} ]] || {
    echo "Couldn't load source ${pzsd_segment_sources}/p10ks_${segment}"
  }
  local -a lines
  lines=( "${(@f)"$(<${pzsd_segment_sources}/p10ks_${segment})"}" )
  print "${(j.\n.)lines}" >> $outputfile
  printf '%b' "\n# P10K Autodoc added: \n" >> $outputfile
  print "autoload -Uz p10ks_${segment}_default_opts" >> $outputfile
  print "autoload -Uz p10ks_${segment}_display_hidden" >> $outputfile
  print "autoload -Uz p10ks_${segment}_bg" >> $outputfile
  print "autoload -Uz p10ks_${segment}_fg" >> $outputfile
  # if async
  print "autoload -Uz p10ks_${segment}_async" >> $outputfile
  print "autoload -Uz p10ks_${segment}_async_return" >> $outputfile
  print "autoload -Uz p10ks_${segment}_async_started" >> $outputfile
}

mkdir -p ${pzsd_outputfolder}/segments

local -a segments
segments=(
  battery
  cwd
  cwd_writable
  execution_time
  host
  jobs
  retval
  time
  user
  userhost
  vcs
)

for segment in ${segments}; do
  create_doc_scaffold ${pzsd_outputfolder}/segments/${segment} $segment
done
