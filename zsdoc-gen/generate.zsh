
local pzsd_segment_sources=${pzsd_segment_sources:-segments}
local pzsd_outputfolder=${pzsd_outputfolder:-zsdoc-src}

set -e

function zsh_cat_file () {
  local -a lines
  lines=( "${(@f)"$(<${1})"}" ) 2>/dev/null
  printf '%b' "\n# AUTOGENERATED - DO NOT EDIT\n"
  print "${(j.\n.)lines}"
  printf '%b' "\n# AUTOGENERATED - DO NOT EDIT\n"
}

function create_doc_scaffold () {
  local outputfile="$1"
  local segment="$2"
  echo > $outputfile
  [[ -s "${pzsd_segment_sources}/p10ks_${segment}" ]] || {
    echo "Could not load source ${pzsd_segment_sources}/p10ks_${segment}"
  }
  zsh_cat_file "${pzsd_segment_sources}/p10ks_${segment}" >> $outputfile
  # printf '%b' "\n# P10K Autodoc added: \n" >> $outputfile
  zsh_cat_file "${pzsd_segment_sources}/p10ks_${segment}_default_opts" >> ${outputfile}
  zsh_cat_file "${pzsd_segment_sources}/p10ks_${segment}_display_hidden" >> ${outputfile}
  zsh_cat_file "${pzsd_segment_sources}/p10ks_${segment}_bg" >> $outputfile
  zsh_cat_file "${pzsd_segment_sources}/p10ks_${segment}_fg" >> $outputfile
  # if async
  zsh_cat_file "${pzsd_segment_sources}/p10ks_${segment}_async" >> $outputfile
  zsh_cat_file "${pzsd_segment_sources}/p10ks_${segment}_async_return" >> $outputfile
  zsh_cat_file "${pzsd_segment_sources}/p10ks_${segment}_async_started" >> $outputfile
}

mkdir -p "${pzsd_outputfolder}/segments"

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
  create_doc_scaffold ${pzsd_outputfolder}/p10ks_${segment} $segment
done
