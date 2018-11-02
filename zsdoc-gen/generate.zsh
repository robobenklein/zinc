
local zsdocoutputfolder=${zsdocoutputfolder:-zsdoc-src}

function create_doc_scaffold () {
  local outputfile="$1"
  local segment="$2"
  echo > $outputfile
  print "autoload -Uz p10ks_${segment}" >> $outputfile
  print "autoload -Uz p10ks_${segment}_default_opts" >> $outputfile
  print "autoload -Uz p10ks_${segment}_display_hidden" >> $outputfile
  print "autoload -Uz p10ks_${segment}_bg" >> $outputfile
  print "autoload -Uz p10ks_${segment}_fg" >> $outputfile
  # if async
  print "autoload -Uz p10ks_${segment}_async" >> $outputfile
  print "autoload -Uz p10ks_${segment}_async_return" >> $outputfile
  print "autoload -Uz p10ks_${segment}_async_started" >> $outputfile
}

mkdir -p ${zsdocoutputfolder}

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
  create_doc_scaffold ${zsdocoutputfolder}/${segment}.zsh $segment
done
